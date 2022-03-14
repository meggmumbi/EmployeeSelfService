<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyEscalatedHelpdeskRequest.aspx.cs" Inherits="HRPortal.MyEscalatedHelpdeskRequest" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    My Escalated Help Desk Requests
                </div>
                <div class="panel-body">
                    <table id="example1" class="table table-striped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Job No</th>
                                <th>Employee No </th>
                                <th>Description </th>
                                <th>Request Date</th>
                                <th>Resolve</th>
                                <th>ICT Escalation</th>
                                <th>Escalate to Head</th>
                                <th>Status</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var requests = nav.MyHeldeskRequests.Where(x => x.Escalated_To_EmpNo == empNo && x.Status == "Escalated").ToList();
                                foreach (var request in requests)
                                {
                            %>
                            <tr>
                                <td><%=request.Job_No%> </td>
                                <td><%=request.Employee_No%> </td>
                                <td><%=request.Description_of_the_issue %> </td>
                                <td><%=Convert.ToDateTime(request.Request_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><a href="ResolveHelpdesk.aspx?requestno=<%=request.Job_No %>" class="btn btn-success"><i class="fa fa-edit"></i>Resolve</a> </td>
                                <td><a href="EscalateIctRequests.aspx?requestno=<%=request.Job_No %>" class="btn btn-success"><i class="fa fa-edit"></i>Escalate to ICT</a> </td>
                                <td><a href="EscalateIctRequestsToHead.aspx?requestno=<%=request.Job_No %>" class="btn btn-success"><i class="fa fa-edit"></i>Escalate To Head</a> </td>
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
