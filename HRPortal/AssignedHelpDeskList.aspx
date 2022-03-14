<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignedHelpDeskList.aspx.cs" Inherits="HRPortal.AssignedHelpDeskList" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
 <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    My Assigned Help Desk Requests
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <table id="example1" class="table table-striped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Ticket No</th>
                                <th>Description </th>
                                <th>Request Date</th>
                                <th>Request Time</th>
                                <th>Assigned To</th>
                                <th>Resolve</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var requests = nav.ICT_Helpdesk_Assign.Where(x => x.Assigned_To == empNo && x.Status == "Assigned").ToList();
                                foreach (var request in requests)
                                {
                            %>
                            <tr>
                                <td><%=request.Job_No%> </td>
                                <td><%=request.Description_of_the_issue %> </td>
                                <td><%=Convert.ToDateTime(request.Request_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=request.Request_Time %> </td>
                                <td><%=request.Assigned_To %> </td>
                                <td><a href="ResolveHelpdesk.aspx?requestno=<%=request.Job_No %>" class="btn btn-success"><i class="fa fa-edit"></i>Resolve</a> </td>
                                <td><%=request.Status %> </td>


                            </tr>
                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
