<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="StrategicWorkPlanLines.aspx.cs" Inherits="HRPortal.StrategicWorkPlanLines" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Annual Work Plan Lines</h3>
        </div>
        <table class="table table-bordered table-striped" id="example1">
            <thead>
                <tr>
                    <th>Description</th>
                    <th>Performance Indicator</th>
                    <th>Imported Annual Target Qty</th>
                    <th>Primary Directorate</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                    var workplanLines = nav.StrategyWorkplanLines.Where(x => x.No == WorkploanNo);
                    foreach (var workplanLine in workplanLines)
                    {
                %>
                <tr>
                    <td><% =workplanLine.Description%></td>
                    <td><% =workplanLine.Perfomance_Indicator%></td>
                    <td><% =workplanLine.Imported_Annual_Target_Qty%></td>
                    <td><% =workplanLine.PrimaryDirectorate_Name%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</asp:Content>
