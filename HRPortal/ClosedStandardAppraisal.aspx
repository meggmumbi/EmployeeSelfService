<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClosedStandardAppraisal.aspx.cs" Inherits="HRPortal.ClosedStandardAppraisal" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Approved Individual Performance  ScoreCard</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Supervisor Name</th>
                        <th>Description</th>
                        <th>Evaluation Start Date</th>
                        <th>Evaluation End Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var performancelogs = nav.PerfomanceEvaluation.Where(r => r.Approval_Status == "Released" && r.Employee_No == employeeNo);
                        foreach (var performancelog in performancelogs)
                        {
                    %>
                    <tr>
                        <td><% =performancelog.Supervisor_Name %></td>
                        <td><% =performancelog.Description%></td>
                        <td><% =performancelog.Evaluation_Start_Date%></td>
                        <td><% =performancelog.Evaluation_End_Date%> </td>
                        <td><a href="StandardAppraisalReport.aspx?PCNo=<%=performancelog.No %>">
                            <label class="btn btn-success">View Report</label></a></td>

                        <%   
                            }
                        %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
