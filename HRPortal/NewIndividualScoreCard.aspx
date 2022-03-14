<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewIndividualScoreCard.aspx.cs" Inherits="HRPortal.NewIndividualScoreCard" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
        <%

            int step = 1;
            var Scorecardstatus = string.Empty;
            try
            {
                var nav = new Config().ReturnNav();
                var csp = Request.QueryString["StrategicPlanNo"];
                var AnnualCode = Request.QueryString["AnnualCode"];
                var IndividualPCNo = Request.QueryString["IndividualCardNo"];
                var SeniorPCNo = Request.QueryString["SeniorPCNo"];
                var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                var AnnualPlan = Request.QueryString["annualplan"].ToString();
                var Directorate = Request.QueryString["directorate"].ToString();
                step = Convert.ToInt32(Request.QueryString["step"]);
                if (step > 4 || step < 1)
                {
                    step = 1;
                }
            }
            catch (Exception)
            {
                step = 1;
            }

    %>
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Individual Performance Score Card</h3>
        </div>
        
       <%   
           if (step == 1)
           {
          %>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a  runat="server" href="NewIndividualScoreCard.aspx?step=1&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>"  class="btn btn-success btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >2</a>
                            <p><small>Core Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >3</a>
                            <p><small>Additional Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >4</a>
                            <p><small>Job Description</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            <div class="panel panel-heading">
                <h3 class="panel-title">General Details</h3>
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 4<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

            </div>            
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Strategic Plan No.</label>
                        <asp:DropDownList runat="server" ID="strategicplanno" Class="form-control"  readonly="true" />
                    </div>
                     <div class="form-group">
                        <label class="control-label">Annual Reporting Code.</label>
                        <asp:DropDownList runat="server" ID="annualreportingcode" Class="form-control"  readonly="true"/>
                    </div>
                    
                </div>
                   <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description</label>
                        <asp:TextBox runat="server" ID="txtdescription" CssClass="form-control" ReadOnly="true" />
                    </div>
                  </div>
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <label class="control-label">Department/Center PC ID</label>
                        <asp:DropDownList runat="server" ID="funcionalworkplan" Class="form-control select2" AppendDataBoundItems="true">
                            <asp:ListItem>--Select Department/Center PC ID--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    </div>
                  
                 <div class="col-md-12 col-lg-12">
                <div class="panel-footer">
                   <asp:Button runat="server" ID="Button1" CssClass="btn btn-success pull-right" Text="Proceeed" OnClick="apply_Click" />
                </div>
             </div>
           </div>
              
            </div>
            <% 
                }
                else if (step == 2)
                {
    %>
    <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a  runat="server" href="NewIndividualScoreCard.aspx?step=1&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>"  class="btn btn-default btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-success btn-circle" >2</a>
                            <p><small>Core Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >3</a>
                            <p><small>Additional Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >4</a>
                            <p><small>Job Description</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Core Initiative(<i style="color:yellow">Kindly click on Objective/Initiative to view/add sub-initiatives</i>)</h3>
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="col-md-12 col-lg-12">
                     <div class="panel-body">
                        <label class="btn btn-success pull-right" data-toggle="modal" data-target="#primaryActivities"><i class="fa fa-plus fa-fw"></i>Select Activities</label>
                       <%

                           var IndividualPCNo = Request.QueryString["IndividualCardNo"];
                           var nav = new Config().ReturnNav();
                           var pc = nav.PerfomanceContractHeader.Where(x => x.No == IndividualPCNo);
                           foreach (var item in pc)
                           {
                               Scorecardstatus = item.Approval_Status;
                            %>
                          <h4 class="pull-left">Core Initiative Weight %:<strong style="color:coral">(<%=item.Total_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">Additional Initiative Weight %:<strong style="color:coral">(<%=item.Secondary_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">JD Initiative Weight %:<strong style="color:coral">(<%=item.JD_Assigned_Weight %>)</strong></h4>
                         <% }

                         %>
                     </div>
                </div>
                 <table id="example3" class="table table-bordered table-striped primarycoreInitiativeTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Activity ID</th>
                            <th>Objective/Initiative</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Agreed Target</th>
                            <th>Assigned Weight</th>
                            <th>Remove</th>  
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var employeeNo1 = Convert.ToString(Session["employeeNo"]);
                            var ScoreCardId = Request.QueryString["IndividualCardNo"];
                            var csp = Request.QueryString["StrategicPlanNo"];
                            var AnnualCode = Request.QueryString["AnnualCode"];
                            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                            var AnnualPlan = Request.QueryString["annualplan"].ToString();
                            var Directorate = Request.QueryString["directorate"].ToString();
                            var nav1 = new Config().ReturnNav();
                            var initatives1 = nav1.WorkplanInitiative.Where(x => x.Workplan_No == ScoreCardId).ToList();
                            foreach (var initative in initatives1)
                            {
                        %>
                           <tr>
                            <td id="entrynumberValue"><% =initative.EntryNo %></td>
                            <td><%=initative.Initiative_No%></td>
                            <td><a href="IndividualScoreCardSubinitiatives.aspx?ActivityNo=<%=initative.Initiative_No %>&&IndividualCardNo=<%=ScoreCardId %>&&StrategicPlanNo=<%=csp%>&&WorkploanNo=<%=WorkploanNo%>&&annualplan=<%=AnnualPlan%>&&directorate=<%=Directorate %>"</a><% =initative.Objective_Initiative%> </td>                         
                            <td><input type="date" id="datepicker" value="<%=Convert.ToDateTime(initative.Start_Date).ToString("yyyy-MM-dd")%>" /></td>
                            <td><input type="date" id="datepicker"  value="<%=Convert.ToDateTime(initative.Due_Date).ToString("yyyy-MM-dd") %>" /></td>
                            <td><input type="number" value="<%=initative.Imported_Annual_Target_Qty %>"/></td>
                            <td><input type="number" value="<%=initative.Assigned_Weight %>"/></td>
                            <td> <label class="btn btn-danger" onclick="removeactivity('<%=initative.EntryNo %>');"><i class="fa fa-trash"></i>Delete</label></td>
                          <% }%> 
                    </tbody>
                </table>
                <center>
                        <input type="button" id="btnSaveCoreInitiatives" class="btn btn-success btnSaveCoreInitiatives" value="Save Core Initiatives" />                        
                        <div class="clearfix"></div>
                    </center>
            </div>
              <div class="panel-footer">
                <asp:Button runat="server" ID="NextToStep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep3_Click"/>
                <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click"/>
                <span class="clearfix"></span>
            </div> 
        </div>

        <div id="primaryActivities" class="modal fade" role="dialog">
                  <div class="modal-dialog" style="width:800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All Availlable Activities </h4>
                        </div>
                        <div class="modal-body">
                     <div class="row" style="width:800px">
                  <div class="panel-body" style="width:800px">               
                 <table id="example6" class="table table-bordered table-striped primaryActivityInitiativeTableDetails" id="primaryActivityInitiativeTableDetails" name="primaryActivityInitiativeTableDetails">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                            <th>No</th>
                            <th>Objective/Initiative</th>
                            <th>Start Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var employeeNo3 = Convert.ToString(Session["employeeNo"]);
                            var cspNumber = Request.QueryString["StrategicPlanNo"];
                            var workPlanNumber = Request.QueryString["WorkploanNo"];
                            var nav3 = new Config().ReturnNav();
                            var allActivities = nav3.PcObjectives.Where(s => s.Strategy_Plan_ID == cspNumber && s.Workplan_No == workPlanNumber).ToList();
                            foreach (var initative in allActivities)
                            {
                             %>
                        <tr>
                             <td><input type="checkbox" class="checkboxes" id="selectedactivityrecords1" name="selectedactivityrecords1" value=""/></td>                           
                            <td><% =initative.Initiative_No %></td>
                             <td><% =initative.Objective_Initiative%> </td>
                            <td><% =initative.Year_Reporting_Code%></td>
                            <%
                                }
                            %>
                    </tbody>
                </table>
                <div class="row">
                   <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <button type="button" class="btn btn-success btn_applyallselectedActvities" id="btn_applyallselectedActvities" name="btn_applyallselectedActvities">Submit Selected Activites</button>
                        <div class="clearfix"></div>
                    </div>
                   
                </div>
                </div>
            </div>
            </div>
            </div>
        </div>
    </div>
    </div>
      
       <% 
           }
           else if (step == 3)
           {
    %>
    <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a  runat="server" href="NewIndividualScoreCard.aspx?step=1&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>"  class="btn btn-default btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >2</a>
                            <p><small>Core Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-success btn-circle" >3</a>
                            <p><small>Additional Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >4</a>
                            <p><small>Job Description</small></p>
                        </div>
                        <%--<div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=5&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >5</a>
                            <p><small>Attach Supporting Documents</small></p>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Additional Initiative(<i style="color:yellow">Kindly click on Objective/Initiative to view/add sub-initiatives</i>)</h3>
                  <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div runat="server" id="feedbackdetails"></div>
             <div class="col-md-12 col-lg-12">
                      <div class="panel-body">
                        <label class="btn btn-success pull-right" data-toggle="modal" data-target="#allsecondaryActivities"><i class="fa fa-plus fa-fw"></i>Select Activities</label>
                          <%

                              var IndividualPCNo = Request.QueryString["IndividualCardNo"];
                              var nav = new Config().ReturnNav();
                              var pc = nav.PerfomanceContractHeader.Where(x => x.No == IndividualPCNo);
                              foreach (var item in pc)
                              {
                            %>
                          <h4 class="pull-left">Core Initiative Weight %:<strong style="color:coral">(<%=item.Total_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">Additional Initiative Weight %:<strong style="color:coral">(<%=item.Secondary_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">JD Initiative Weight %:<strong style="color:coral">(<%=item.JD_Assigned_Weight %>)</strong></h4>
                         <% }

                         %>
                    </div>
                </div>
            <div class="panel-body">
                 <table id="example5" class="table table-bordered table-striped Additionalactivities">
                    <thead>
                        <tr>
                             <th>No</th>
                            <th>Activity ID</th>
                            <th>Objective/Initiative</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Agreed Target</th>
                            <th>Assigned Weight</th>
                            <th>Delete</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            var employeeNo2 = Convert.ToString(Session["employeeNo"]);
                            var ScoreCardId1 = Request.QueryString["IndividualCardNo"];
                            var csp = Request.QueryString["StrategicPlanNo"];
                            var AnnualCode = Request.QueryString["AnnualCode"];
                            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                            var AnnualPlan = Request.QueryString["annualplan"].ToString();
                            var Directorate = Request.QueryString["directorate"].ToString();
                            var nav2 = new Config().ReturnNav();
                            var SecondaryPCObjectives = nav2.SecondaryPCObjective.Where(x => x.Workplan_No == ScoreCardId1).ToList();
                            foreach (var SecondaryPCObjective in SecondaryPCObjectives)
                            {
                        %>
                        <tr>
                            <td id="entrynumberValues1"><% =SecondaryPCObjective.EntryNo %></td>
                            <td><%=SecondaryPCObjective.Initiative_No%></td>
                            <td><a href="AdditionaActivitiesSubinitiatives.aspx?ActivityNo=<%=SecondaryPCObjective.Initiative_No %>&&IndividualCardNo=<%=ScoreCardId1 %>&&StrategicPlanNo=<%=csp%>&&WorkploanNo=<%=WorkploanNo%>&&annualplan=<%=AnnualPlan%>&&directorate=<%=Directorate %>"</a><% =SecondaryPCObjective.Objective_Initiative%> </td>
                            <td><input type="date" id="datepicker"  value="<%=Convert.ToDateTime(SecondaryPCObjective.Start_Date).ToString("yyyy-MM-dd") %>"  /></td>
                            <td><input type="date" id="datepicker"  value="<%=Convert.ToDateTime(SecondaryPCObjective.Due_Date).ToString("yyyy-MM-dd") %>" /></td>
                            <td><input type="number"  autocomplete="off" value="<%=SecondaryPCObjective.Imported_Annual_Target_Qty %>"  min="0"/></td>
                            <td><input type="number" autocomplete="off" value="<%=SecondaryPCObjective.Assigned_Weight %>" min="0"/></td>
                            <td> <label class="btn btn-danger" onclick="removeadditionalactivity('<%=SecondaryPCObjective.EntryNo %>','<%=SecondaryPCObjective.Initiative_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                            <%
                                }
                            %>
                    </tbody>
                </table>
                  <center>
                         <input type="button" id="btnSaveAdditionalInitiativesActivities" class="btn btn-success btnSaveAdditionalInitiativesActivities" value="Save Additional Activities" />                           
                        <div class="clearfix"></div>
                    </center>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" ID="NextToStep4" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep4_Click"/>
                <asp:Button runat="server" ID="BackToStep2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep2_Click"/>
                <span class="clearfix"></span>
            </div>  
        </div>

          <div id="allsecondaryActivities" class="modal fade" role="dialog">
                 <div class="modal-dialog" style="width:800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All Availlable Activities </h4>
                        </div>
                        <div class="modal-body">
                     <div class="row" style="width:800px">
                <div class="panel-body" style="width:800px">
                 <table id="example2" class="table table-bordered table-striped secondary1ActivityInitiativeTableDetails">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAllActivities" name="checkBoxAllActivities" class="custom-checkbox" /></th>
                            <th>Activity ID</th>
                            <th>Directorate</th>
                            <th>Description</th>
                            <th>Perfomarnce Indicator</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            var employeeNo4 = Convert.ToString(Session["employeeNo"]);
                            var WorkPlan = Request.QueryString["WorkploanNo"];
                            var annualplan = Request.QueryString["annualplan"];
                            var directorate = Request.QueryString["directorate"];
                            var nav4 = new Config().ReturnNav();
                            var SecondaryPCObjectives4 = nav4.StrategyWorkplanLines.Where(c => c.No == annualplan).ToList();
                            foreach (var SecondaryPCObjective in SecondaryPCObjectives4)
                            {
                        %>
                        <tr>
                            <td><input type="checkbox" class="checkboxes" id="selectedactivityrecords2" name="selectedactivityrecords2" value=""/></td>  
                            <td><% =SecondaryPCObjective.Activity_ID%> </td>
                            <td><% =SecondaryPCObjective.PrimaryDirectorate_Name%> </td>
                            <td><% =SecondaryPCObjective.Description%></td>
                            <td><% =SecondaryPCObjective.Perfomance_Indicator%></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                  <div class="row">
                   <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <button type="button" class="btn btn-success btnSaveAdditionalInitiativesCategories" id="btnSaveAdditionalInitiativesCategories" name="btnSaveAdditionalInitiativesCategories">Submit Selected Activites</button>
                        <div class="clearfix"></div>
                    </div>
                    </div>
                </div>
            </div>
            </div>
           </div>
        </div>
    </div>
    </div>
    
                <% 
                    }
                    else if (step == 4)
                    {
    %>
     <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a  runat="server" href="NewIndividualScoreCard.aspx?step=1&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>"  class="btn btn-default btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >2</a>
                            <p><small>Core Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-default btn-circle" >3</a>
                            <p><small>Additional Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a runat="server" href="NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=<%=IndividualPCNo %>&&StrategicPlanNo=<%=csp %>&&WorkploanNo=<%=WorkploanNo %>&&annualplan=<%=AnnualPlan %>&&directorate=<%=Directorate %>" type="button" class="btn btn-success btn-circle" >4</a>
                            <p><small>Job Description</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Job Description</h3>
                  <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div runat="server" id="feedbacks"></div>
            <div class="panel-body">
                <div class="col-md-12 col-lg-12">
                     <div class="panel-body">
                        <%

                            var IndividualPCNo = Request.QueryString["IndividualCardNo"];
                            var nav = new Config().ReturnNav();
                            var pc = nav.PerfomanceContractHeader.Where(x => x.No == IndividualPCNo);
                            foreach (var item in pc)
                            {
                            %>
                          <h4 class="pull-left">Core Initiative Weight %:<strong style="color:coral">(<%=item.Total_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">Additional Initiative Weight %:<strong style="color:coral">(<%=item.Secondary_Assigned_Weight %>)</strong></h4>
                         <h4 class="pull-left">JD Initiative Weight %:<strong style="color:coral">(<%=item.JD_Assigned_Weight %>)</strong></h4>
                         <% }

                         %>
                     </div>
                </div>
                 <table id="example5" class="table table-bordered table-striped JDTargetsTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Work Plan</th>
                            <th>Job Description </th>
                            <th>Unit of Measure</th>
                            <th>Annual Target</th>
                            <th>Assigned Weight</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String employeeNo5 = Convert.ToString(Session["employeeNo"]);
                            String ScoreCardId5 = Request.QueryString["IndividualCardNo"];
                            var csp = Request.QueryString["StrategicPlanNo"];
                            var AnnualCode = Request.QueryString["AnnualCode"];
                            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                            var AnnualPlan = Request.QueryString["annualplan"].ToString();
                            var Directorate = Request.QueryString["directorate"].ToString();
                            var nav5 = new Config().ReturnNav();
                            var jobs5 = nav5.JobDescription.Where(x => x.Workplan_No == ScoreCardId5).ToList();
                            foreach (var jobs in jobs5)
                            {
                        %>
                        <tr>
                            <td><% =jobs.Line_Number %></td>
                            <td><% =jobs.Workplan_No%></td>
                            <td><a href="JobDescriptionSubinitiatives.aspx?ActivityNo=<%=jobs.Line_Number %>&&IndividualCardNo=<%=ScoreCardId5 %>&&StrategicPlanNo=<%=csp%>&&WorkploanNo=<%=WorkploanNo%>&&annualplan=<%=AnnualPlan%>&&directorate=<%=Directorate %>"</a><% =jobs.Description%> </td>
                             <td><% =jobs.Unit_of_Measure %></td>
                            <td><input type="number" id="txtannualtarget"  value="<%=jobs.Imported_Annual_Target_Qty %>" /></td>
                            <td><input type="number" id="txtassignedweight"  value="<%=jobs.Assigned_Weight %>"></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                 <center>
                    <input type="button" id="btn_saveJDTargets" class="btn btn-success btn_saveJDTargets" value="Save Job Description" />      
                      <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Preview PC" ID="Button3" OnClick="print_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       
                      <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Preview PC Sub Indicators" ID="Button4" OnClick="printsubindicators_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                 
                    <div class="clearfix"></div>
                </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="Button2" OnClick="submitPC_Click"/>
            <asp:Button runat="server" ID="BackToStep3" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep3_Click"/>
            <span class="clearfix"></span>
        </div>  
    </div>
        <% 
            }
            else if (step == 5)
            {
    %>
     <div class="panel panel-primary" >
            <div class="panel-heading">
                <h3 class="panel-title">Attach Supporting documents, maximum size is 5MB (The following formats are allowed: docs,png,xlsx,csv,pdf,JPG,JPEG)</h3>
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                          <div runat="server" id="documentsfeedback"></div>
           <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <strong>Select file to upload:</strong>
                       <asp:FileUpload runat="server" ID="document" CssClass="form-control" style="padding-top: 0px;"/>
                   </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <br/>
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click"/>
                   </div>
               </div>
           </div>
           <table class="table table-bordered table-striped" id="example3">
               <thead>
               <tr>
                   <th>Document Title</th>
                   <th>Download</th>
                   <th>Delete</th>
               </tr>
               </thead>
               <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";
                       String PCNo = Request.QueryString["IndividualCardNo"];
                       PCNo = PCNo.Replace('/', '_');
                       PCNo = PCNo.Replace(':', '_');
                       String documentDirectory = filesFolder + PCNo + "/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               String url = documentDirectory;
                        %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Individual Scorecard\<% =PCNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
                   </tr>
                   <%
                               }
                           }
                       }
                       catch (Exception)
                       {

                       }%>
               </tbody>
           </table> 
            </div>
          <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="BackTostep4" OnClick="BackTostep4_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="submitPC" OnClick="submitPC_Click"/>
          <div class="clearfix"></div>
        </div>
    </div>

  
 <%} %>
<script type="text/javascript">
    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("MainBody_fileName").value = fileName;
        $("#deleteFileModal").modal();
    }
    function removeactivity(lineNo) {
        $("#activityNumber").val('0');
        document.getElementById("MainBody_activityNumber").value = lineNo;
        $("#removeSubActivity").modal();
    }
    function removeadditionalactivity(lineNumber, initiative) {
        $("#additionalnumber").val('0');
        document.getElementById("MainBody_additionalnumber").value = lineNumber;
        document.getElementById("MainBody_initiativenumber").value = initiative;
        $("#removeAdditionalSubActivity").modal();
    }
    $(function () {
        $("#datepicker").datepicker();
    });
</script> 
     <div id="removeAdditionalSubActivity" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Individual Score Card Additional Activity</h4>
                </div>
                <div class="modal-body">
                     <asp:TextBox runat="server" ID="additionalnumber" type="hidden" />
                    <asp:TextBox runat="server" ID="initiativenumber" type="hidden" />
                    Are you sure you want to send Remove Activity ? 
                </div>

                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Activity" OnClick="DeleteAdditionalSubActity_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
      <div id="removeSubActivity" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Individual Score Card Activity</h4>
                </div>
                <div class="modal-body">
                     <asp:TextBox runat="server" ID="activityNumber" type="hidden"  />
                    Are you sure you want to send Remove Activity ? 
                </div>

                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Activity" OnClick="DeleteSubActity_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
 <div id="deleteFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click"/>
      </div>
    </div>

  </div>
</div>
</asp:Content>
