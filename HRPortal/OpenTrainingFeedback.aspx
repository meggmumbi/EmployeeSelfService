<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenTrainingFeedback.aspx.cs" Inherits="HRPortal.OpenTrainingFeedback" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Training Feedback</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Application Code</th>
                        <th>Course Title</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Venue</th>
                        <th>Facilitators</th>
                        <th>Course Justifaction</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingfeedback = nav.Trainingfeedback.Where(r => r.Employee_No == employeeNo && r.Status == "Open");
                        foreach (var mytrainingfeedback in trainingfeedback)
                        {
                    %>
                    <tr>
                        <td><% =mytrainingfeedback.No %></td>
                        <td><% =mytrainingfeedback.Application_Code%></td>
                        <td><% =mytrainingfeedback.Course_Title%></td>
                        <td><% = Convert.ToDateTime(mytrainingfeedback.Start_DateTime).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(mytrainingfeedback.End_DateTime).ToString("dd/MM/yyyy") %></td>
                        <td><% =mytrainingfeedback.Venue%></td>
                        <td><% =mytrainingfeedback.Facilitators%></td>
                        <td><% =mytrainingfeedback.Course_Justification%></td>
                        <td> <a href="TrainingFeedback.aspx?feedbackNo=<%=mytrainingfeedback.No %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit</a> </td>
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
