<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AnnualWorkPlan.aspx.cs" Inherits="HRPortal.AnnualWorkPlan" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Annual Work Plan</h3>
        </div>
            <table class="table table-bordered table-striped" id="example1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Strategy Plan No.</th>
                        <th>Year Reporting</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>View</th>
                        <th>Print</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        var workplans = nav.AnnualWorkPlan.Where(x => x.Approval_Status == "Released");
                        foreach (var workplan in workplans)
                        {
                    %>
                    <tr>
                        <td><% =workplan.No %></td>
                        <td><% =workplan.Description%></td>
                        <td><% =workplan.Strategy_Plan_ID%> </td>
                        <td><% =workplan.Year_Reporting_Code%></td>
                        <td><% = Convert.ToDateTime(workplan.Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(workplan.End_Date).ToString("dd/MM/yyyy")%></td>
                         <td><a href="StrategicWorkPlanLines.aspx?WorkploanNo=<%=workplan.No %>"><label class="btn btn-success"><i class="fa fa-eye"></i>View</label></a></td>
                        <td> <a href="AnnualWorkPlanReport.aspx?AnnualPlanNo=<%=workplan.No %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
</asp:Content>
