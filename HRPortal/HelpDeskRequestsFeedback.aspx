<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HelpDeskRequestsFeedback.aspx.cs" Inherits="HRPortal.HelpDeskRequestsFeedback" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Give feedback to ICT Help Desk/Reopen the issue
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                        <li class="breadcrumb-item active">Help Desk Feedback</li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
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
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" ID="GiveFeedBack" Text="Close Request" OnClick="GiveFeedBack_Click" />
            <asp:Button runat="server" CssClass="btn btn-danger pull-right" ID="reopen" Text="Reopen the issue" OnClick="reopen_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
</asp:Content>
