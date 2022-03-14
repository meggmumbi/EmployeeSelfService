<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedTrainingEvaluation.aspx.cs" Inherits="HRPortal.SubmittedTrainingEvaluation" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Training Needs Requests</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Application Code</th>
                        <th>Course Title</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Venue</th>
                        <th>Faciliktators</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingEvaluation = nav.TrainingEvaluation.Where(r => r.Employee_No == employeeNo && r.Status == "Submitted");
                        foreach (var myTrainingEvaluation in trainingEvaluation)
                        {
                    %>
                    <tr>
                        <td><% =myTrainingEvaluation.No %></td>
                        <td><% =myTrainingEvaluation.Application_Code%></td>
                        <td><% =myTrainingEvaluation.Course_Title%></td>
                        <td><% =myTrainingEvaluation.Start_DateTime %></td>
                        <td><% =myTrainingEvaluation.End_DateTime%></td>
                        <td><% =myTrainingEvaluation.Venue%></td>
                        <td><% =myTrainingEvaluation.Facilitators%></td>
                        <td>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
