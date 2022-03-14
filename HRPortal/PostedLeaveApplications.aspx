<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PostedLeaveApplications.aspx.cs" Inherits="HRPortal.PostedLeaveApplications" %>

<%@ Import Namespace="HRPortal" %>
<asp:content id="Content2" contentplaceholderid="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Posted Leave Applications
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                   <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Application No</th>
                                <th>Leave Type</th>
                                <th>Days Applied</th>
                                <th>Start Date</th>
                                <th>Return Date</th>
                                <th>Status</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var leaves = nav.LeaveApplications.Where(r => r.Employee_No == (String)Session["employeeNo"] && r.Status == "Released" && r.Posted==true);
                                foreach (var leave in leaves)
                                {
                            %>
                            <tr>
                                <td><%=leave.Application_Code %> </td>
                                <td><%=leave.Leave_Type %> </td>
                                <td><%=leave.Days_Applied %> </td>
                                <td><%=Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=Convert.ToDateTime(leave.Return_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=leave.Status %> </td>
                              
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
</asp:content>
