<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskDashboard.aspx.cs" Inherits="HRPortal.RiskDashboard" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>5</h3>

                    <p>Risk Management Plans</p>
                </div>
                <div class="icon">
                    <i class="ion ion-bag"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>2</h3>

                    <p>Open Risk Incidents</p>
                </div>
                <div class="icon">
                    <i class="ion ion-stats-bars"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>4</h3>

                    <p>Pending Risk Incidents</p>
                </div>
                <div class="icon">
                    <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-red">
                <div class="inner">
                    <h3>1</h3>

                    <p>Approved Risk Incidents</p>
                </div>
                <div class="icon">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Risk Incedent Logs           
        </div>
        <div class="box-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Date Of Reporting</th>
                        <th>Date Of Accident</th>
                        <th>Place Of Occurence</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%--                    <%
                        var nav = Config.ReturnNav();
                        var applications1 = nav.InsuranceClaims.Where(r => r.Claim_Position == "CLAIM NOTIFICATION");
                        foreach (var application in applications1)
                        {
                    %>
                    <tr>
                        <td><%= application.No %></td>
                        <td><%= application.Customer_No %></td>
                        <td><%= application.Policy_No %></td>
                        <td><%= application.Date_of_Reporting %></td>
                        <td><%= application.Date_of_Accident_Loss_Death %></td>
                        <td><%= application.Place_of_Occurence %></td>
                        <td><%= application.Claim_Position %></td>
                    </tr>
                    <%
                        }
                    %>--%>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
