﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EscalateIctRequests.aspx.cs" Inherits="HRPortal.EscalateIctRequests" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Escalate ICT Help Desk Request  
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                        <li class="breadcrumb-item active">Escalate Help Desk </li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">

                    <div class="form-group">
                        <strong>Escalate To:</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="txtEscalate" />
                    </div>

                    <div class="form-group">
                        <strong>Escalate Details:</strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Description" TextMode="MultiLine" />
                    </div>

                </div>

            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Escalate
                "
                ID="Escalate" OnClick="Escalate_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
</asp:Content>
