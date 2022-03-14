<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSurveyResponses.aspx.cs" Inherits="HRPortal.EmployeeSurveyResponses" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Survey Responses</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document No.</th>
                        <th>Description</th>
                        <th>Document Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var query = nav.BusinessResearchResponse.Where(r => r.Participant_ID == employeeNo);
                        foreach (var survey in query)
                        {
                    %>
                    <tr>
                        <td><% =survey.Document_No %></td>
                        <td><% =survey.Description%></td>
                        <td><% =survey.Document_Date%></td>
                        <td><a href="BRResponseSection.aspx?surveyNo=<%=survey.Document_No %>">
                            <label class="btn btn-success">Respond To Survey</label></a></td>
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
