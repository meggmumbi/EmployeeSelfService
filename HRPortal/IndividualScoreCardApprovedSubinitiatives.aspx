<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IndividualScoreCardApprovedSubinitiatives.aspx.cs" Inherits="HRPortal.IndividualScoreCardApprovedSubinitiatives" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Approved Individual Performance  ScoreCard</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                    <th>Activity No</th>
                    <th>Objective/Initiative</th>
                    <th>Sub Targets</th>
                    <th>Unit of Measure</th>
                    <th>Start Date</th>
                    <th>Due Date</th>
                    <th>Sub-Indicator</th>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String ScoreCardId = Convert.ToString(Request.QueryString["IndividualCardNo"]);
                    string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                    var subactivities = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                    foreach (var subactivity in subactivities)
                    {
                %>
                <tr>
                    <td><%=subactivity.Initiative_No %></td>
                    <td><%=subactivity.Objective_Initiative %></td>
                    <td><%=subactivity.Sub_Targets %></td>
                    <td><%=subactivity.Unit_of_Measure %></td>
                    <td><% =Convert.ToDateTime(subactivity.Start_Date).ToString("dd/MM/yyyy")%></td>
                    <td><% =Convert.ToDateTime(subactivity.Due_Date ).ToString("dd/MM/yyyy")%></td>
                    <td><% =subactivity.Outcome_Perfomance_Indicator%></td>

                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
