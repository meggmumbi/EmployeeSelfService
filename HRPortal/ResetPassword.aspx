<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HRPortal.ResetPassword" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Reset Password
            <span class="pull-right"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <p><strong>Current Password:</strong></p>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Current Password" TextMode="Password" ID="currentPassword" />
                    </div>
                    <div class="form-group">
                        <p><strong>New Password:</strong></p>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="New Password" TextMode="Password" ID="newPassword" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">

                    <div class="form-group">
                        <p><strong>Confirm Password:</strong></p>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Confirm Password" TextMode="Password" ID="confirmPassword" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Change Password" ID="changedetails" OnClick="ResetPassword_Click" />
                <span class="clearfix"></span>
            </div>
        </div>

    </div>
</asp:Content>
