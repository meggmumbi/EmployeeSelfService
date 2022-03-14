<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="EmployeeSupervisorAppraisal.aspx.cs" Inherits="HRPortal.EmployeeSupervisorAppraisal" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Employee-Supervisor Appraisal</h3>
        </div>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                            <p><small>Objectives and OutComes</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-1">
            <div class="panel panel-heading">
                <h3 class="panel-title">General Details</h3>
            </div>
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Employee No.</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Employee Name</label>
                            <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Strategy Plan No:</strong>
                            <asp:DropDownList runat="server" ID="strategicplanno" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Performance Plan No:</strong>
                            <asp:DropDownList runat="server" ID="funcionalworkplan" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Performance Task No:</strong>
                            <asp:DropDownList runat="server" ID="tasknumbers" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Personal Score Card No:</strong>
                            <asp:DropDownList runat="server" ID="personalscorecards" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Annual Reporting Year:</strong>
                            <asp:DropDownList runat="server" ID="annualreportingcode" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Last Evaluation Date:</strong>
                            <asp:TextBox runat="server" ID="lastevaluationdate" CssClass="form-control" TextMode="Date" />
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-12">
                        <center>
                    <asp:Button runat="server" ID="apply" CssClass="btn btn-success" Text="Suggest Objectives and Outcomes" OnClick="apply_Click" />
                <div class="clearfix"></div>
                </center>
                    </div>
                </div>
                <div class="col-md-12 col-lg-12">
                    <button class="btn btn-primary nextBtn pull-right" type="button">Next</button>
                </div>
            </div>

        </div>

        <div class="panel panel-primary setup-content" id="step-2">
            <div class="panel-heading">
                <h3 class="panel-title">Objectives and Outcomes</h3>
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <table id="example1" class="table table-bordered table-striped PerformanceTargetsTable">
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
                <div class="col-md-12 col-lg-12">
                    <input type="button" class="btn btn-success pull-right" value="Submit for Approval" />
                </div>
            </div>

        </div>
    </div>

    <div id="removeSubActivity" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Individual Score Card Sub Activity</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="subactivityEntryNo" type="hidden" />
                    Are you sure you want to send Remove Sub Activity ? 
                </div>

                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Sub-Activity" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <script>
        function DeleteSubInitiative(entryNumber) {
            document.getElementById("MainBody_subactivityEntryNo").value = entryNumber;
            $("#removeSubActivity").modal();
        }
    </script>
</asp:Content>

