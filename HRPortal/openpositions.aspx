<%@ Page Title="Open Positions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="openpositions.aspx.cs" Inherits="HRPortal.openpositions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="span12">
        <div class="widget widget-table action-table">
            <div class="widget-header">
                <i class="icon-th-list"></i>
                <h3>Vacant Positions</h3>
            </div>
            <div class="widget-content">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>JOB ID </th>
                            <th>JOB DESCRIPTIONS</th>
                            <th>JOB GRADE</th>
                            <th>Required Positions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var positions = nav.VacantPositions.Where(x => x.Closed_Application == false && x.Requisition_Type == "Internal" && x.Status == "Approved");
                            foreach (var position in positions)
                            {
                        %>
                        <tr>
                            <td><a href="JobDetails.aspx?id=<%=position.Job_ID %>"><%=position.Job_ID %></a> </td>
                            <td><%=position.Job_Title %> </td>
                            <td><%=position.Job_Grade %> </td>
                            <td><%=position.Required_Positions %> </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</asp:Content>
