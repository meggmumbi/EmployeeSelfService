<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewPerformanceLogEntry.aspx.cs" Inherits="HRPortal.NewPerformanceLogEntry" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
        var nav = new Config().ReturnNav();
        var csp = Convert.ToString(Session["StrategicPlanNo"]);
        var IndividualPCNo = Convert.ToString(Session["IndividualPCNo"]);
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
    %>
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Individual Performance Logs</h3>
        </div>

        <%
            if (step == 1)
            { %>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-success btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-default btn-circle">2</a>
                            <p><small>Performance Targets</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-default btn-circle">3</a>
                            <p><small>Documents</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                <h3 class="panel-title">General Details</h3>
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Personal Score Card No.</label>
                        <asp:DropDownList runat="server" ID="personalscorecardno" CssClass="form-control" AppendDataBoundItems="true"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity Start Date</label>
                        <asp:TextBox runat="server" ID="tr_StartDate" CssClass="form-control" PlaceHolder="DD/MM/YYY" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity End Date</label>
                        <asp:TextBox runat="server" ID="tr_EndDate" CssClass="form-control" PlaceHolder="DD/MM/YYY" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Descripton<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" ID="textdescription" CssClass="form-control" placeholder="Please enter description"/>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validatetextdescription" ControlToValidate="textdescription" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>

            <div class="panel-footer">
                <asp:Button runat="server" ID="Button1" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click" />
                <span class="clearfix"></span>
            </div>
        </div>
        <%}
            else if (step == 2)
            {
        %>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-default btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-success btn-circle">2</a>
                            <p><small>Performance Targets</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-steps">
                            <a href="#" type="button" class="btn btn-default btn-circle">3</a>
                            <p><small>Documents</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Performance Targets</h3>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="panel-body">
                    <label class="btn btn-success pull-right" data-toggle="modal" data-target="#plogsActivities"><i class="fa fa-plus fa-fw"></i>Select Activities</label>
                </div>
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <table id="example1" class="table table-bordered table-striped AllPerformanceTargetsTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Description</th>
                            <th>Achieved Date</th>
                            <th>Target Qty</th>
                            <th>Achieved Target</th>
                            <th>Comments</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            string employeeNo = Convert.ToString(Session["employeeNo"]);
                            string PlogNumber = Request.QueryString["PerformanceLogNo"];
                            var performancelogs = nav.PlogsLines.Where(r => r.Employee_No == employeeNo && r.PLog_No == PlogNumber);
                            foreach (var performancelog in performancelogs)
                            {
                        %>
                        <tr>

                            <td><% =performancelog.EntryNo %></td>
                             <td><a href="SubPlogLines.aspx?InitiativeNo=<%=performancelog.Initiative_No %>&&PlogNumber=<%=performancelog.Personal_Scorecard_ID%>"</a><% =performancelog.Sub_Intiative_No%> </td>
                             <td><input type="date"  id="datepicker"  value="<%=Convert.ToDateTime(performancelog.Achieved_Date).ToString("yyyy-MM-dd") %>" /></td>
                            <td><% =performancelog.Target_Qty%></td>
                            <td><input type="number" autocomplete="off" id="txtagreedtarget" value="<%=performancelog.Achieved_Target%>" /></td>
                            <td><input type="text" autocomplete="off" id="txtcomments" value="<%=performancelog.Comments%>" /></td>
                            <td><label class="btn btn-danger" onclick="removeactivity('<%=performancelog.EntryNo %>','<%=performancelog.Initiative_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                            <%
                                }
                            %>
                    </tbody>
                </table>
                 <center>
                         <input type="button" id="btnSavePlogActivities" class="btn btn-success btnSavePlogActivities" value="Save Performance Targets" />                           
                        <div class="clearfix"></div>
                    </center>
                <div class="panel-footer">
                    <asp:Button runat="server" ID="NextToStep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep3_Click" />
                    <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click" />
                    <span class="clearfix"></span>
                </div>
            </div>
            <% 
                }
                else if (step == 3)
                {
            %>
            <div class="row user-tabs">
                <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                    <div class="stepwizard">
                        <div class="stepwizard-row setup-panel">
                            <div class="stepwizard-step col-xs-steps">
                                <a href="#" type="button" class="btn btn-default btn-circle">1</a>
                                <p><small>General Details</small></p>
                            </div>
                            <div class="stepwizard-step col-xs-steps">
                                <a href="#" type="button" class="btn btn-default btn-circle">2</a>
                                <p><small>Performance Targets</small></p>
                            </div>
                            <div class="stepwizard-step col-xs-steps">
                                <a href="#" type="button" class="btn btn-success btn-circle">3</a>
                                <p><small>Documents</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Attach Supporting documents, maximum size is 5MB (The following formats are allowed: docs,png,xlsx,csv,pdf,JPG,JPEG,JFIF,GIF)</h3>
                    <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                </div>
                <div class="panel-body">
                    <div runat="server" id="documentsfeedback"></div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="form-group">
                                <strong>Select file to upload:</strong>
                                <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="form-group">
                                <br />
                                <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" />
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Document Title</th>
                                <th>Download</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try
                                {
                                    String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Performance Logs Card/";
                                    String imprestNo = Request.QueryString["imprestNo"];
                                    imprestNo = imprestNo.Replace('/', '_');
                                    imprestNo = imprestNo.Replace(':', '_');
                                    String documentDirectory = filesFolder + imprestNo + "/";
                                    if (Directory.Exists(documentDirectory))
                                    {
                                        foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                        {
                                            String url = documentDirectory;
                            %>
                            <tr>
                                <td><% =file.Replace(documentDirectory, "") %></td>

                                <td><a href="<%=fileFolderApplication %>\Performance Logs Card\<% =imprestNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                            </tr>
                            <%
                                        }
                                    }
                                }
                                catch (Exception)
                                {

                                }%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" ID="SubmitPlogs" CssClass="btn btn-success pull-right" Text="Submit Performance Logs" OnClick="SubmitPlogs_Click" />
                    <asp:Button runat="server" ID="BackToStep2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep2_Click" />
                    <span class="clearfix"></span>
                </div>
            </div>
            <%} %>
            <div id="plogsActivities" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All Availlable Performance Activities </h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="panel-body">
                                    <div runat="server" id="generalfeedbacks"></div>
                                    <table id="example2" class="table table-bordered table-striped PerformanceTargetsTable1">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>No</th>
                                                <th>Objective/Initiative</th>
                                                <th>Year Reporting</th>
                                                <th>Assigned Weight</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                String employeeNo1 = Convert.ToString(Session["employeeNo"]);
                                                var ScoreCardNumber = Request.QueryString["ScoreCardNo"];
                                                var strategyPlanNumber = Request.QueryString["CSPNo"];
                                                var nav1 = new Config().ReturnNav();
                                                var performancelogs1 = nav.PcObjectives.Where(r => r.Workplan_No == ScoreCardNumber && r.Strategy_Plan_ID == strategyPlanNumber);
                                                foreach (var performancelog in performancelogs1)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <input type="checkbox" class="checkboxes1" id="selectedplogactivity" name="selectedplogactivity" value="<% =performancelog.Initiative_No %>" /></td>
                                                <td><% =performancelog.Initiative_No %></td>
                                                <td><% =performancelog.Objective_Initiative%></td>
                                                <td><% =performancelog.Year_Reporting_Code%></td>
                                                <td><% =performancelog.Assigned_Weight%></td>
                                                <%
                                                    }
                                                %>
                                        </tbody>
                                    </table>
                                    <div class="col-md-12 col-lg-12">
                                        <input type="button" id="btn_apply_SubmitTargets" class="btn btn-success btn_apply_SubmitTargets" value="Submit Targets" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function deleteFile(fileName) {
                document.getElementById("filetoDeleteName").innerText = fileName;
                document.getElementById("MainBody_fileName").value = fileName;
                $("#deleteFileModal").modal();
            }
            function removeactivity(lineNumber, initiative) {
                $("#additionalnumber").val('0');
                document.getElementById("MainBody_additionalnumber").value = lineNumber;
                document.getElementById("MainBody_initiativenumber").value = initiative;
                $("#removeActivityModal").modal();
            }
        </script>
         <div id="removeActivityModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Peformance Log Activity</h4>
                </div>
                <div class="modal-body">
                     <asp:TextBox runat="server" ID="additionalnumber" type="hidden" />
                    <asp:TextBox runat="server" ID="initiativenumber" type="hidden" />
                    Are you sure you want to send Remove Activity ? 
                </div>

                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Activity" OnClick="DeleteActity_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
        <div id="deleteFileModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting File</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                        <asp:TextBox runat="server" ID="fileName" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click" />
                    </div>
                </div>

            </div>
        </div>
</asp:Content>
