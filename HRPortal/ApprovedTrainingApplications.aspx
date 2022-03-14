<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedTrainingApplications.aspx.cs" Inherits="HRPortal.ApprovedTrainingApplications" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Approved Training Application</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Course Title</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Location</th>
                        <th>Duration</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingapplication = nav.Trainingrequests.Where(r => r.Employee_No == employeeNo && r.Status == "Approved");
                        foreach (var mytrainingapplication in trainingapplication)
                        {
                    %>
                    <tr>
                        <td><% =mytrainingapplication.Code %></td>
                        <td><% =mytrainingapplication.Course_Title%></td>
                        <td><% =Convert.ToDateTime(mytrainingapplication.Start_DateTime).ToString("dd/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(mytrainingapplication.End_DateTime).ToString("dd/MM/yyyy")%></td>
                        <td><% =mytrainingapplication.Location%></td>
                        <td><% =mytrainingapplication.Duration%></td>
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
