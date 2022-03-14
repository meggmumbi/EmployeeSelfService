<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AppraisalUnderEvaluations.aspx.cs" Inherits="HRPortal.AppraisalUnderEvaluations" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
          Appraisals Under Evaluations
            <span class="pull-right"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <table id="example3" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Activity No</th>
                            <th>Objective/Initiative</th>
                            <th>%Complete</th>
                            <th>Sub Targets</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = new Config().ReturnNav();
                            String employeeNo = Convert.ToString(Session["employeeNo"]);
                            String ScoreCardId = Convert.ToString(Session["IndividualCardNo"]);
                            string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                            var subactivities = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                            foreach (var subactivity in subactivities)
                            {
                        %>
                        <tr>
                            <td><%=subactivity.Initiative_No %></td>
                            <td><%=subactivity.Objective_Initiative %></td>
                            <td><%=subactivity.Complete %></td>
                            <td><%=subactivity.Sub_Targets %></td>
                            <td><%=subactivity.Start_Date %></td>
                            <td><%=subactivity.Due_Date %></td>
                            <td>
                                <label class="btn btn-danger" onclick="DeleteSubInitiative('<%=subactivity.Entry_Number %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

