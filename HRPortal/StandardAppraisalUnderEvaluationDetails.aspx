<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardAppraisalUnderEvaluationDetails.aspx.cs" Inherits="HRPortal.StandardAppraisalUnderEvaluationDetails" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
        var nav = new Config().ReturnNav();
        string docNo = Request.QueryString["docNo"];

        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 5 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Objectives and Outcomes</h3>
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
            <table class="table table-bordered table-striped datatable ObjectiveEvaluationResultTable" id="example5">
                <thead>
                    <tr>
                        <th style="display:none">No</th>
                        <th style="display:none">No</th>
                        <th>Objective/Initiative</th>
                        <th>Target Quantity</th>
                        <th>Appraiser Review Quantity</th>
                        <th>Comments</th>
                    </tr>
                </thead>
                <tbody>
                    <%                                                                              
                        var cspplan = nav.ObjectiveEvaluationResult.Where(r => r.Performance_Evaluation_ID == docNo).ToList();
                        foreach (var csps in cspplan)
                        {
                    %>
                    <tr>
                        <td style="display:none" id="lineNo"><% =csps.Line_No %></td>
                        <td style="display:none" id="docNo"><% =csps.Performance_Evaluation_ID %></td>
                        <td><% =csps.Objective_Initiative%></td>
                        <td><% =csps.Target_Qty%> </td>
                        <td><input type="number" style="width: 5em;" autocomplete="off"  min="0" value="<% =csps.AppraiserReview_Qty%>"/></td>
                        <td><input style="width: 10em;" type="text" autocomplete="off" value="<%=csps.Comments %>"/></td>
                        </tr>
                        <%
                            }
                        %>
                </tbody>
            </table>
        <center>
            <input type="button" id="btnSaveObjectiveEvaluationResult" class="btn btn-success btnSaveObjectiveEvaluationResult" value="Save Details" />                        
            <div class="clearfix"></div>
        </center>
        <br />
        <div class="panel-footer">
            <asp:Button runat="server" ID="NextToStep2" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep2_Click"/>
            <span class="clearfix"></span>
        </div> 
    </div>
            <% 
            }
            else if (step == 2)
            {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Proficiency Evaluation</h3>
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable ProficiencyEvaluationResultTable" id="example4">
                <thead>
                    <tr>
                        <th style="display:none">No</th>
                        <th style="display:none">No</th>
                        <th>Description</th>
                        <th>Target Quantity</th>
                        <th>Appraiser Review Quantity</th>
                        <th>Comments</th>
                    </tr>
                </thead>
                <tbody>
                        <%
                    var initiatives = nav.ProficiencyEvaluationResult.Where(x=> x.Performance_Evaluation_ID == docNo);
                    foreach (var initiative in initiatives)
                    {
                %>
                    <tr>
                        <td style="display:none"><% =initiative.Line_No %></td>
                        <td style="display:none"><% =initiative.Performance_Evaluation_ID %></td>
                        <td><% =initiative.Description%></td>
                        <td><% =initiative.Target_Qty%></td>
                        <td><input type="number" style="width: 5em;" autocomplete="off"  min="0" value="<% =initiative.AppraiserReview_Qty%>"/></td>
                        <td><input style="width: 10em;" type="text" autocomplete="off" value="<%=initiative.Comments %>"/></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <center>
            <input type="button" id="btnSaveProficiencyEvaluationResult" class="btn btn-success btnSaveProficiencyEvaluationResult" value="Save Details" />                        
            <div class="clearfix"></div>
        </center>
        <br />
        <div class="panel-footer">
            <asp:Button runat="server" ID="nexttostep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="nexttostep3_Click"/>
            <asp:Button runat="server" ID="backtostep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="backtostep1_Click"/>
            <span class="clearfix"></span>
        </div> 
        </div>
    </div>
        <% 
    }
    else if (step == 3)
    {
    %>
        <div class="panel panel-primary">
        <div class="panel-heading">
            Evaluation Improvement Plan
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Appraisal</a></li>
                        <li class="breadcrumb-item active">PIP </li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div runat="server" id="pipFeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>PIP Category</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="pipcategory" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="description" placeholder="Description" />
                    </div>
                </div>
            </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Lines Details" ID="addEvaluationImprovementPlan" OnClick="addEvaluationImprovementPlan_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>PIP Category</th>
                        <th>Description</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var query = nav.EvaluationPIP.Where(x => x.Perfomance_Evaluation_No == docNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.PIP_Category %></td>
                        <td><%=item.Description %></td>
<%--                        <td>
                            <label class="btn btn-success" onclick="editTeamMember('<%=item.PIP_Number %>','<%=item.PIP_Category %>','<%=item.Description  %>');"><i class="fa fa-pencil"></i>Edit</label></td>--%>
                        <td>
                            <label class="btn btn-danger" onclick="removePIP('<%=item.PIP_Number %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep2" OnClick="backtostep2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="nexttostep4" Text="Next"  OnClick="nexttostep4_Click"/>
            <div class="clearfix"></div>
        </div>
            <% 
    }
    else if (step == 4)
    {
    %>
        <div class="panel panel-primary">
        <div class="panel-heading">
            Evaluation Training Needs
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Appraisal</a></li>
                        <li class="breadcrumb-item active">Training Needs </li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div runat="server" id="needsfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Training Need Category</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="needcategory" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                   </div>
                    <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="mDesc" placeholder="Description" />
                    </div>
                    </div>
                 
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Lines" ID="addtrainingneeds" OnClick="addtrainingneeds_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example3" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Training Needs Category</th>
                        <th>Description</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var query = nav.EvaluationTrainingneeds.Where(x => x.Perfomance_Evaluation_No == docNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Training_Need_Category %></td>
                        <td><%=item.Description %></td>
<%--                        <td>
                            <label class="btn btn-success" onclick="editTeamMember('<%=item.Training_Need_Number %>','<%=item.Training_Need_Category %>','<%=item.Description  %>');"><i class="fa fa-pencil"></i>Edit</label></td>--%>
                        <td>
                            <label class="btn btn-danger" onclick="removeNeedLine('<%=item.Training_Need_Number %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep3" OnClick="backtostep3_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="nexttostep5" Text="Next" OnClick="nexttostep5_Click"/>
            <div class="clearfix"></div>
        </div>
                <% 
    }
    else if (step == 5)
    {
    %>
        <div class="panel panel-primary">
        <div class="panel-heading">
            Appraisal Confirmation
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Appraisal</a></li>
                        <li class="breadcrumb-item active">Confirmation </li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div runat="server" id="confirmfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Employee Confirmation</strong>
                        <asp:CheckBox runat="server" CssClass="form-control" ID="employeeconfirm" />
                    </div>
                    <div class="form-group">
                        <strong>Supervisor Confirmation</strong>
                        <asp:CheckBox runat="server" CssClass="form-control" ID="supervisorconfirm" />
                    </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep4" OnClick="backtostep4_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="Submit" Text="Submit To HR" OnClick="Submit_Click"/>
            <div class="clearfix"></div>
        </div>
        <% 
            }
    %>

<script>
    function removePIP(LineNo) {
        document.getElementById("MainBody_removePIPLineNo").value = LineNo;
        $("#removePIPModal").modal();
    }
</script>
<script>
    function removeNeedLine(LineNo) {
        document.getElementById("MainBody_removeNeedLineNo").value = LineNo;
        $("#removeNeedLineModal").modal();
    }
</script>

<div id="removePIPModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Confirm Removal of Line</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to remove the line?</p>
                <asp:TextBox runat="server" ID="removePIPLineNo" type="hidden" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Line" ID="removePIPline" OnClick="removePIPline_Click"/>
            </div>
        </div>

    </div>
</div>

<div id="removeNeedLineModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Confirm Removal of Line</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to remove the line?</p>
                <asp:TextBox runat="server" ID="removeNeedLineNo" type="hidden" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Line" ID="removeNeedLine" OnClick="removeNeedLine_Click"/>
            </div>
        </div>

    </div>
</div>
</asp:Content>
