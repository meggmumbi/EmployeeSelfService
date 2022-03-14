<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedDailyWorkTicket.aspx.cs" Inherits="HRPortal.ApprovedDailyWorkTicket" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
           <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Requisition No</th>
                        <th>Vehicle Allocated</th>
                        <th>Driver Allocated</th>
                        <th>Driver Name</th>
                        <th>Date Of Request</th>
                        <th>Status</th>
                        <th>View Approval Entries</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string requisitionNo = Request.QueryString["requisitionNo"];
                        string empNo = Request.QueryString["employeeNo"];
                        var nav = new Config().ReturnNav();
                        var headers = nav.OpenDailyWorkTicket.Where(x => x.Driver_Allocated == empNo && x.Daily_Work_Ticket == requisitionNo && x.Status == "Released").ToList();
                        foreach (var header in headers)
                        {
                    %>
                    <tr>
                        <td><% =header.Daily_Work_Ticket %></td>
                        <td><% =header.Vehicle_Allocated %></td>
                        <td><% =header.Driver_Allocated %></td>
                        <td><% =header.Driver_Name %></td>
                        <td><% =Convert.ToDateTime( header.Date_of_Request).ToShortDateString()%></td>
                        <td><% =header.Status%></td>
                        <td><a href="StoreRequisitionsApproverEntries.aspx?requisitionNo=<%=header.Daily_Work_Ticket %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>



                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>


</asp:Content>
