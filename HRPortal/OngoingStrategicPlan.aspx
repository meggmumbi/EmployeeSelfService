<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="OngoingStrategicPlan.aspx.cs" Inherits="HRPortal.OngoingStrategicPlan" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Ongoing Corporate Strategic Plan</h3>
        </div> 
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#theme" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic Theme</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#objective" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic Objective </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#strategies" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategies </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#strategicinitiatives" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic Initiatives </h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Corporate Strategic Plan General Details</h3>
                        </div>
                            <table id="example2" class="table table-bordered table-striped datatable" id="example6">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Primary Theme</th>
                                        <th>Duration</th>
                                        <th>Start Date</th>
                                        <th>Due Date</th>
                                        <th>Implementation</th>
                                        <th>Attachments</th>
                                        <th>Print</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                                        var nav = new Config().ReturnNav();
                                        var cspplan = nav.OngoingCorporateStrategicPlan.Where(r => r.Implementation_Status == "Ongoing").ToList();
                                        foreach (var csps in cspplan)
                                        {
                                    %>
                                    <tr>
                                        <td><% =csps.Description%></td>
                                        <td><% =csps.Primary_Theme%></td>
                                        <td><% =csps.Duration_Years%> </td>
                                        <td><% = Convert.ToDateTime(csps.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(csps.End_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% =csps.Implementation_Status%></td>
                                        <td><a href="CSPAttachment.aspx?cspNo=<%=csps.Code %>"><label class="btn btn-success">Attached Documents</label></a></td>
                                         <td><a href="CSPPrintout.aspx?cspNo=<%=csps.Code %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                    </div>
                  </div>
                    <div id="strategicinitiatives" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic Initiative</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example1" class="table table-bordered table-striped" >
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th>Primary Directorate</th>
                                            <th>Primary Department</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                             var nav1 = new Config().ReturnNav();
                                             var initiatives = nav.StrategicInitiative;
                                             foreach (var initiative in initiatives)
                                             {
                                    %>
                                       <tr>
                                        <td><% =initiative.Description%></td>
                                        <td><% =initiative.Primary_Directorate_Name%></td>
                                        <td><% =initiative.Primary_Department_Name%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="theme" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic Theme</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example3" class="table table-bordered table-striped" >
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th>Primary Strategic Issue</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <%
                                          var nav2 = new Config().ReturnNav();
                                          var themes = nav.StrategicThemes;
                                          foreach (var theme in themes)
                                          {
                                        %>
                                       <tr>
                                        <td><% =theme.Description%></td>
                                        <td><% =theme.Primary_Strategic_Issue%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="objective" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic Objectives</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example4" class="table table-bordered table-striped" >
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                         var nav3 = new Config().ReturnNav();
                                         var objectives = nav.StrategicObjectives;
                                         foreach (var objective in objectives)
                                         {
                                        %>
                                       <tr>
                                        <td><% =objective.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div id="strategies" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategies</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example5" class="table table-bordered table-striped" >
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                         var nav4 = new Config().ReturnNav();
                                         var strategies = nav.CSPStrategies;
                                         foreach (var objective in strategies)
                                         {
                                        %>
                                       <tr>
                                        <td><% =objective.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
</asp:Content>
