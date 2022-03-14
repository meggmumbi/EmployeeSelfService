<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingPlan.aspx.cs" Inherits="HRPortal.TrainingPlan" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
<div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Training Plan</h3>
        </div>  
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#lines" data-toggle="tab"><h3 class="panel-title" style="color:black">Training Plan Lines</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#report" data-toggle="tab"><h3 class="panel-title" style="color:black">View Report</h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Training Plan General Details</h3>
                        </div>
                            <table class="table table-bordered table-striped datatable" id="example6">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Start Date</th>
                                        <th>Due Date</th>
                                        <th>Year Code</th>
                                        <th>Total Estimated Cost</th>
                                        <th>Budget Allocation</th>
                                        <th>Budget Available</th>
                                        <th>Budget Utilized</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                                        var nav = new Config().ReturnNav();
                                        var cspplan = nav.TrainingPlanHeader.ToList();
                                        foreach (var csps in cspplan)
                                        {
                                            Session["planNo"] = csps.No;
                                    %>
                                    <tr>
                                        <td><% =csps.Description%></td>
                                        <td><% = Convert.ToDateTime(csps.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(csps.End_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% =csps.Year_Code%></td>    
                                        <td><% = Convert.ToDecimal(csps.Total_Estimated_Cost).ToString("#,##0") %></td> 
                                        <td><% = Convert.ToDecimal(csps.Budget_Allocation).ToString("#,##0") %></td> 
                                        <td><% = Convert.ToDecimal(csps.Bugdet_Available).ToString("#,##0") %></td> 
                                        <td><% = Convert.ToDecimal(csps.Budget_Utilized).ToString("#,##0") %></td> 
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                    </div>
                  </div>
                    <div id="lines" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Training Plan Lines</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example1">
                                    <thead>
                                        <tr>
                                            <th>Course Description</th>
                                            <th>Field Description</th>
                                            <th>Target Group</th>
                                            <th>Course Duration</th>
                                            <th>Planned No of Staff</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <%
                                       var nav2 = new Config().ReturnNav();
                                        var themes = nav.TrainingPlanLines.Where(x=> x.Training_Plan_Code == Convert.ToString(Session["planNo"]));
                                        foreach (var theme in themes)
                                        {
                                        %>
                                       <tr>
                                        <td><% =theme.Course_Description%></td>
                                        <td><% =theme.Field_Name%></td>
                                        <td><% =theme.Target_Group%></td>
                                        <td><% =theme.Course_Duration%></td>
                                        <td><% =theme.Planned_No_of_Staff%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="report" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Report</h3>
                            </div>
                            <div class="panel-body">
                               <div class="panel-heading"> <i class="icon-file"></i>
                                  Training Plan report
                                </div>
                                <!-- /widget-header -->
                                <div class="panel-body">
                                    <div class="row">
                                    <div class="col-sm-6">
                                            <ol class="breadcrumb float-sm-right">
                                                <li class="breadcrumb-item"><a href="#">Training Plan </a></li>
                                                <li class="breadcrumb-item active"> Report </li>
                                            </ol>
                                        </div>
                                </div>
                                    <div id="feedback" runat="server"></div>
                                                     <div class="com-md-3 col-lg-3">
                                         <br/>
                                     <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="generate_Click"/>
                                 </div>
                                    <br/>
                                    <div class="form-group">
                                     <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                                        </div>
                                    </div>
               
            
                            </div>
                        </div>
                    </div>                    
            </div>
        </div>
</asp:Content>
