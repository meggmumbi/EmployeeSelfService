﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResolveHelpdesk.aspx.cs" Inherits="HRPortal.ResolveHelpdesk" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    My Resolved Help Desk Requests
                </div>
                <div class="panel-body">
                    <table id="example1" class="table table-striped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Ticket No</th>
                                <th>Description </th>
                                <th>Request Date</th>
                                <th>Request Time</th>
                                <th>Escalated To</th>
                                <th>Action Taken</th>
                                <th>Status</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var requests = nav.MyHeldeskRequests.Where(x => x.Employee_No == empNo && x.Status == "Resolved").ToList();
                                foreach (var request in requests)
                                {
                            %>
                            <tr>
                                <td><%=request.Job_No%> </td>
                                <td><%=request.Description_of_the_issue %> </td>
                                <td><%=Convert.ToDateTime(request.Request_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=request.Request_Time %> </td>
                                <td><%=request.Escalated_To %> </td>
                                <td><%=request.Action_Taken %> </td>
                                <td><%=request.Status %> </td>
                                <td><a href="HelpDeskRequestsFeedback.aspx?jobNo=<%=request.Job_No%>" class="btn btn-success"><i class="fa fa-edit"></i>Feedback</a> </td>

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
