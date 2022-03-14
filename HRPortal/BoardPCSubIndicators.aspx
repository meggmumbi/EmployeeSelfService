﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="BoardPCSubIndicators.aspx.cs" Inherits="HRPortal.BoardPCSubIndicators" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Board PC Sub Indicators</h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable" id="example4">
                <thead>
                    <tr>
                        <th>Sub Initiative</th>
                        <th>Unit of Measure</th>
                        <th>Target</th>
                        <th>Completion Date</th>
                    </tr>
                </thead>
                <tbody>
                        <%
                    var nav = new Config().ReturnNav();
                    string InitiativeNo = Request.QueryString["InitiativeNo"];
                    string docNo = Request.QueryString["docNo"];
                    var initiatives = nav.SubPCObjective.Where(x=> x.Initiative_No == InitiativeNo && x.Workplan_No == docNo);
                    foreach (var initiative in initiatives)
                    {
                %>
                    <tr>
                        <td><% =initiative.Objective_Initiative%></td>
                        <td><% =initiative.Unit_of_Measure%></td>
                        <td><% =initiative.Imported_Annual_Target_Qty%></td>
                        <td><% = Convert.ToDateTime(initiative.Due_Date).ToString("dd/MM/yyyy")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
             <asp:Button runat="server" ID="PreviousPage" CssClass="btn btn-warning pull-left" Text="Previous Page" OnClick="Previous_Click"/>
        </div>
    </div>
</asp:Content>
