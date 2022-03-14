<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ApprovedRecordRequsitions.aspx.cs" Inherits="HRPortal.ApprovedRecordRequsitions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">Approved Record Requisitions</div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped datatable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Requester Number</th>
                        <th>Requester Name</th>
                        <th>Date Requested</th>
                        <th>Duration</th>
                        <th>Expected Return Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string request = Request.QueryString["fileRequestNo"];
                        var filelines = nav.FileMovementHeader.Where(x => x.Status == "Approved" && x.Account_No == Session["employeeNo"].ToString()).ToList();
                        foreach (var file in filelines)
                        {
                    %>
                    <tr>
                        <td><%=file.No %></td>
                        <td><%=file.Account_No %></td>
                        <td><%=file.Account_Name %></td>
                        <td><%=file.Date_Requested %></td>
                        <td><%=file.Duration_Requested %></td>
                        <td><%=file.Expected_Return_Date %></td>
                        <td><%=file.Status %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
