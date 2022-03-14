<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BRResponseSection.aspx.cs" Inherits="HRPortal.BRResponseSection" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
     <div class="panel panel-primary">
        <div class="panel-heading">
            Open Surveys
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example2"  class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Section Code</th>
                    <th>Description</th>
                    <th>Section Completion Instruction</th>
                </tr>
                </thead>
                <tbody>
                <%
                    string surveyNo = Request.QueryString["surveyNo"];
                    var nav = new Config().ReturnNav();
                    var survey = nav.BrResponseSection.Where(x=> x.Survey_Response_ID == surveyNo).ToList();
                    foreach (var line in survey)
                    {
                        %>
                    <tr>
                        <td><% =line.Section_Code %></td>
                        <td><% =line.Description %></td>
                        <td><% =line.Section_Completion_Instruction %></td>
<%--                        <td><% =line.No_of_Questions%></td>
                        <td><% =line.Total_Weight%></td>--%>
                         <td><a href="BrQuestions.aspx?surveyNo=<%=line.Survey_Response_ID %>&&sectionCode=<%=line.Section_Code %>"><label class="btn btn-success">View Details</label></a></td>
                    </tr>
                    <%
                    } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
