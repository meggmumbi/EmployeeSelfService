<%@ Page Title="Payslip" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="payslip.aspx.cs" Inherits="HRPortal.payslip" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h5>Generate Payslip</h5>
        </div>
        <div class="panel-body">
            <div class="widget">
                <div class="widget-header">
                    <i class="icon-file"></i>
                </div>
                <div class="widget-content">
                    <div id="feedback" runat="server"></div>
                    <div class="form-group">
                        <label>Pay Period</label>
                        <asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="payperiod_SelectedIndexChanged" />
                    </div>
                    <div class="form-group">
                        <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="400px" id="payslipFrame" style="margin-top: 10px;"></iframe>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
