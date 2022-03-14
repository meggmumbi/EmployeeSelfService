<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ClosedStrategicPlan.aspx.cs" Inherits="HRPortal.ClosedStrategicPlan" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Ongoing Corporate Strategic Plan</h3>
        </div>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                            <p><small>Core Mandate Primary Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
                            <p><small>Core Mandate Secondary Initiatives</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
                            <p><small>Job Description</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
                            <p><small>Board PC Activities</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-1">
            <div class="panel panel-heading">
                <h3 class="panel-title">General Details</h3>
            </div>
            <div class="panel-body">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Strategic Plan No.</label>
                        <asp:textbox runat="server" id="strategicplanno" cssclass="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Functional Work Plan</label>
                        <asp:textbox runat="server" id="funcionalworkplan" cssclass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Annual Reporting Code.</label>
                        <asp:textbox runat="server" id="annualreportingcode" cssclass="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Goal Template</label>
                        <asp:textbox runat="server" id="Textbox1" cssclass="form-control" />
                    </div>
                </div>
                <div class="col-md-12 col-lg-12">
                    <button class="btn btn-primary nextBtn pull-right" type="button">Next</button>
                </div>

            </div>

        </div>

        <div class="panel panel-primary setup-content" id="step-2">
            <div class="panel-heading">
                <h3 class="panel-title">Board Initiative</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Initiative No</th>
                            <th>Objective/Initiative</th>
                            <th>Initiative Type</th>
                            <th>Strategy Plan</th>
                            <th>Year Reporting</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Annual Target</th>
                            <th>Achieved Target</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12 col-lg-12">
                <button class="btn btn-primary nextBtn pull-right" type="button">Next</button>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-3">
            <div class="panel-heading">
                <h3 class="panel-title">Core Mandate Primary Initiative</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Initiative No</th>
                            <th>Objective/Initiative</th>
                            <th>Initiative Type</th>
                            <th>Strategy Plan</th>
                            <th>Year Reporting</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Annual Target</th>
                            <th>Achieved Target</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12 col-lg-12">
                <button class="btn btn-primary nextBtn pull-right" type="button">Next</button>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-4">
            <div class="panel-heading">
                <h3 class="panel-title">Core Mandate Secondary Initiative</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Initiative No</th>
                            <th>Objective/Initiative</th>
                            <th>Initiative Type</th>
                            <th>Strategy Plan</th>
                            <th>Year Reporting</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Annual Target</th>
                            <th>Achieved Target</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12 col-lg-12">
                <button class="btn btn-primary nextBtn pull-right" type="button">Next</button>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-5">
            <div class="panel-heading">
                <h3 class="panel-title">Job Description</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Work Plan</th>
                            <th>Job Description </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
