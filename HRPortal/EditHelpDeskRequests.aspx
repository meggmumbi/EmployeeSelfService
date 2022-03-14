<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditHelpDeskRequests.aspx.cs" Inherits="HRPortal.EditHelpDeskRequests" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Update Request to ICT Help Desk
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                        <li class="breadcrumb-item active">Update Help Desk Request </li>
                    </ol>
                </div>
            </div>
            <div id="editictFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">

                    <div class="form-group">
                        <strong>Description:</strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Description" TextMode="MultiLine" />
                    </div>

                </div>

            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Update Request
                "
                ID="editICTHelpDeskRequest" OnClick="editICTHelpDeskRequest_Click" />
            <span class="clearfix"></span>
        </div>
    </div>

</asp:Content>
