﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardAppraisalReport.aspx.cs" Inherits="HRPortal.StandardAppraisalReport" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
       <div class="row" style="width: 100%; margin: auto;">
    <div class="panel panel-primary">
        
            <div class="panel-heading"> <i class="icon-file"></i>
              Appraisal Report
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Appraisal </a></li>
                            <li class="breadcrumb-item active"> Report </li>
                        </ol>
                    </div>
            </div>
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                    </div>
                </div>
               
            
         
          </div>
        </div>
    <div class="clearfix"></div>
     <script>
            
       
            $(document).ready(function () {
               

            });
        </script>
</asp:Content>
