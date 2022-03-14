<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedTrainingNeedsRequests.aspx.cs" Inherits="HRPortal.ApprovedTrainingNeedsRequests" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Training Needs Requests</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Date Requested</th>
                        <th>Status</th>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingRequests = nav.Trainingneedsrequests.Where(r => r.Employee_No == employeeNo && r.Status == "Released");
                        foreach (var myTrainingRequests in trainingRequests)
                        {
                    %>
                    <tr>
                        <td><% =myTrainingRequests.Code %></td>
                        <td><% =myTrainingRequests.Description%></td>
                        <td><% = Convert.ToDateTime(myTrainingRequests.Created_On).ToString("dd/MM/yyyy")%></td>
                         <td><% =myTrainingRequests.Status%></td>
                    </tr>
                       <%   
                            }
                        %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>