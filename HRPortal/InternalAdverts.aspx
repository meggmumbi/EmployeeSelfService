<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="InternalAdverts.aspx.cs" Inherits="HRPortal.InternalAdverts" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">
            Internal Adverts
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Job Reference</th>
                        <th>Job Title/Designation</th>
                        <th>Employment Type</th>
                        <th>Positions</th>
                        <th>Application Deadline</th>
                        <th>Job Grade</th>
                        <th>Access E-Recruitment</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var today = DateTime.Today;
                        var time24 = DateTime.Now.ToString("HH:mm:ss");
                        DateTime now = DateTime.Now;
                        DateTime secondschanged = new DateTime(now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second);
                        var query = nav.AdvertisedVacancies.Where(x => x.Document_Type == "Job Vacancy" && x.Vacancy_Status == "Published" && x.Approval_Status == "Released" && x.Application_Closing_Date >= today && x.Target_Candidate_Source == "Limited-Internal Staff").ToList();
                        foreach (var openjobs in query)
                        {
                            var jobEndDate = Convert.ToDateTime(openjobs.Application_Closing_Date).ToString("MM/dd/yyyy");
                            TimeSpan time = new TimeSpan(17, 0, 0);
                            DateTime closingDate = Convert.ToDateTime(jobEndDate) + time;

                            DateTime TimeNow = new DateTime(now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second);

                            if (closingDate >= TimeNow)
                            {
                    %>
                    <tr>
                        <td><% =openjobs.Vacancy_No %></td>
                        <td><% =openjobs.Job_Title_Designation %></td>
                        <td><% =openjobs.Employment_Type%></td>
                        <td><% =openjobs.No_of_Openings%> </td>
                        <td><% =openjobs.Application_Closing_Date%></td>
                        <td><% =openjobs.Job_Grade_ID%></td>
                        <td><a href="https://erecruitment.kemri.org:7070/Home/Login" class="btn btn-success"><i class="fa fa-eye"></i>Login to E-Recruitment</a> </td>


                    </tr>
                    <%
                            }
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
