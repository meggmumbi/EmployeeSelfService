<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewIndividualScoreCardSubIndicatorsReport.aspx.cs" Inherits="HRPortal.NewIndividualScoreCardSubIndicatorsReport" %>
<asp:content id="Content3" contentplaceholderid="MainBody" runat="server">
       <div class="row" style="width: 100%; margin: auto;">
    <div class="panel panel-primary">
            <div class="panel-heading"> <i class="icon-file"></i>
              Performance Contract Report
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                    </div>
                </div>
          </div>
        </div>
</asp:content>
