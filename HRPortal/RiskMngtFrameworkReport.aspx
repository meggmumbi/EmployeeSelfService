﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskMngtFrameworkReport.aspx.cs" Inherits="HRPortal.RiskMngtFrameworkReport" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="span12">
        <div class="widget">

            <div class="widget-header">
                <i class="icon-file"></i>
                <h3>Risk Management Framework Report</h3>
            </div>
            <div class="widget-content">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="payslipFrame" style="margin-top: 10px;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</asp:Content>
