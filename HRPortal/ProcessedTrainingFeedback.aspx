<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessedTrainingFeedback.aspx.cs" Inherits="HRPortal.ProcessedTrainingFeedback" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Processed Training Feedback</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Course Title</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Duration</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingRequests = nav.Trainingrequests.Where(r => r.Employee_No == employeeNo && r.Status == "Released");
                        foreach (var myTrainingRequests in trainingRequests)
                        {
                    %>
                    <tr>
                        <td><% =myTrainingRequests.Code %></td>
                        <td><% =myTrainingRequests.Course_Title%></td>
                        <td><% = Convert.ToDateTime(mytrainingfeedback.Start_DateTime).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(mytrainingfeedback.End_DateTime).ToString("dd/MM/yyyy") %></td>
                        <td><% =myTrainingRequests.Duration%></td>
                        <td><% =myTrainingRequests.Description%></td>
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
