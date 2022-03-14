<%@ Page Title="Imprest" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="imprest.aspx.cs" Inherits="HRPortal.imprest" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <%
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
        <div class="panel-heading">
            General Details
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Subject:</strong>
                        <asp:TextBox runat="server" ID="subject" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <strong>Objective:</strong>
                        <asp:TextBox runat="server" ID="objective" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <strong>Destination:</strong>
                        <asp:TextBox runat="server" ID="destinationNarration" CssClass="form-control" TextMode="MultiLine" MaxLength="100" />
                    </div>
                    <div class="form-group">
                        <strong>Source of Funds:</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="fundcode" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Travel Date:</strong>
                        <asp:TextBox runat="server" ID="travelDate" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <strong>Number of Days:</strong>
                        <asp:TextBox runat="server" ID="numberOfDays" TextMode="Number" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <strong>Select Project/Exchequer Account:</strong>
                        <asp:DropDownList runat="server" ID="job" CssClass="form-control select2" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="True" />
                    </div>
                    <div class="form-group">
                        <strong>Select the Vote:</strong>
                        <asp:DropDownList runat="server" ID="jobTaskno" CssClass="form-control select2" />
                    </div>

                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addGeneralDetails" OnClick="addGeneralDetails_Click" />
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
            Team
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="teamFeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Destination Town:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="destinationTown" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Vote Item:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="voteItem" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Team Member:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="teamMember" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Number of Days:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="teamNumberOfDays" TextMode="Number"  />
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click" />
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Destination Town</th>
                        <th>Vote Item</th>
                        <th>Team Member</th>
                        <th>Number of Days</th>
                        <th>Daily Subsistence</th>
                        <th>Total Entitlement</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String imprestNo = Request.QueryString["imprestNo"];
                        var projectTeamMembers = nav.ProjectMembers.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo && r.Type == "Person");
                        foreach (var member in projectTeamMembers)
                        {
                    %>
                    <tr>
                        <td><%=member.Work_Type %></td>
                        <td><%=member.Type_of_Expense %></td>
                        <td><%=member.Name %></td>
                        <td><%=member.Time_Period %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(member.Direct_Unit_Cost)) %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(member.Total_Entitlement)) %></td>
                        <td><label class="btn btn-success" onclick="editTeamMember('<%=member.Work_Type %>','<%=member.No %>','<%=member.Type_of_Expense %>', '<%=member.Time_Period %>');"><i class="fa fa-pencil"></i> Edit</label></td>
                        <td> <label class="btn btn-danger" onclick="removeTeamMember('<%=member.Work_Type %>','<%=member.No %>','<%=member.Name %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed3_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 3)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Fuel  Details               
     <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 6<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="fuelFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Expense Type:</strong>
                    <asp:DropDownList runat="server" ID="txtworkType" CssClass="form-control " AutoPostBack="true">
                        <asp:ListItem Value="0">Fuel</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-6 col-lg-6">
                    <strong>Budget Line:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="txtbudgetline" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Project No.:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="txtprojectnumber" OnSelectedIndexChanged="job1_SelectedIndexChanged" AutoPostBack="True" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Amount:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="txtamount" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-lg-4">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Fuel Details" ID="Button5" OnClick="addFuel_Click" />
                </div>
            </div>
            <br />
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Expense Type</th>
                        <th>Project No</th>
                        <th>Project name</th>
                        <th>Budget Code</th>
                        <th>Amount</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String imprestNo = Request.QueryString["imprestNo"];
                        var lines = nav.FuelTravelRequisition.Where(r => r.Req_No == imprestNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Expense_Type %></td>
                        <td><% =line.Job_No %></td>
                        <td><% =line.Job_Name %></td>
                        <td><% =line.Job_Task %></td>
                        <td><% =line.Requested_Amount %></td>
                        <%--<td><label class="btn btn-success" onclick="editFuel('<%=line.Work_Type %>','<%=line.No %>','<%=line.Time_Period %>');"><i class="fa fa-edit-o"></i> Edit</label></td>--%>
                        <td>
                            <label class="btn btn-danger" onclick="removeFuel('<%=line.EntryNo %>','<%=line.Job_No %>','<%=line.Job_Task %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed3_Click1" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed4_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (step == 4)
        {
    %>
    <%--<div class="panel panel-primary">
        <div class="panel-heading">
            Casuals
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="casualsFeedBack"></div>

            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Type:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsType" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Resource:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsResource" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Work Type:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsWorkType" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>No. Required:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="casualsNoRequired" placeholder="No. Required" TextMode="Number" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>No. of Days:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="casualsNoOfDays" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Casual" ID="addCasual" OnClick="addCasual_Click" />
                    </div>
                </div>
            </div>
            <hr />

            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Resource</th>
                        <th>Work Type</th>
                        <th>No. Required</th>
                        <th>No. of Days</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String imprestNo = Request.QueryString["imprestNo"];
                        var projectTeamMembers = nav.Casuals.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo);
                        foreach (var member in projectTeamMembers)
                        {
                    %>
                    <tr>
                        <td><%=member.Type %></td>
                        <td><%=member.ResourceName %></td>
                        <td><%=member.Work_Type%></td>
                        <td><%=member.No_Required%></td>
                        <td><%=member.No_of_Days%></td>

                        <td>
                            <label class="btn btn-success" onclick="editCasual('<%=member.Type %>', '<%=member.Resource_No %>', '<%=member.Work_Type %>', '<%=member.No_Required %>', '<%=member.No_of_Days %>');"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeCasual('<%=member.Type %>','<%=member.Resource_No %>','<%=member.ResourceName %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed5_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed6_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 5)
        {--%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Other Costs
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="othercostsfeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Vote Item:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="otherCostsVoteItem" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Required For:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="requiredFor" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Quantity Required:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="quantityRequired" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>No. of Days:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="otherCostsNoofDays" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Unit Cost:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="otherCostsUnitCost" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn-success btn btn-block" Text="Add Cost" ID="addOtherCosts" OnClick="addOtherCosts_Click" />
                    </div>
                </div>
            </div>
            <hr />
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Vote Item</th>
                        <th>Required for</th>
                        <th>Quantity Required</th>
                        <th>No. of Days</th>
                        <th>Unit Cost</th>
                        <th>Line Amount</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String imprestNo = Request.QueryString["imprestNo"];
                        var otherCosts = nav.OtherCosts.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo);
                        foreach (var cost in otherCosts)
                        {
                    %>
                    <tr>
                        <td><%=cost.Description %></td>
                        <td><%=cost.Required_For %></td>
                        <td><%=cost.Quantity_Required %></td>
                        <td><%=cost.No_of_Days %></td>
                        <td><%=cost.Unit_Cost %></td>
                        <td><%=cost.Line_Amount %></td>


                        <td>
                            <label class="btn btn-success" onclick="editOtherCost('<%=cost.Line_No%>', '<%=cost.Type_of_Expense%>', '<%=cost.Required_For%>', '<%=cost.Quantity_Required%>', '<%=cost.No_of_Days%>','<%=cost.Unit_Cost%>');"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeOtherCost('<%=cost.Description %>','<%=cost.Line_No%>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed8_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed8_Click1" />
            <div class="clearfix"></div>
        </div>
    </div>




    <%
        }
        else if (step == 5)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 6 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                    </div>
                </div>
            </div>
            <table id="example2" class="table table-bordered table-striped">
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
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

                        <td><a href="<%=fileFolderApplication %>\Imprest Memo\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed10_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
    %>


    <script>
        function removeTeamMember(workType, no, name) {
            document.getElementById("teamMembertoRemoveName").innerText = name;
            document.getElementById("MainBody_removeNumber").value = no;
            document.getElementById("MainBody_removeWorkType").value = workType;
            $("#removeTeamMemberModal").modal();
        }

        function removeOtherCost(costName, lineNo) {
            document.getElementById("costtoRemoveName").innerText = costName;
            document.getElementById("MainBody_costToRemovelineNo").value = lineNo;
            $("#removeOtherCostsModal").modal();
        }

        function removeFuel(no, name) {
            document.getElementById("fueltoRemoveName").innerText = name;
            document.getElementById("MainBody_removeFuelNumber").value = no;
            $("#removeFuelModal").modal();
        }

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }

        function removeCasual(type, resourceNo, resourceName) {
            document.getElementById("casualtoRemoveName").innerText = resourceName;
            document.getElementById("MainBody_removeCasualType").value = type;
            document.getElementById("MainBody_removeCasualResourceNo").value = resourceNo;
            $("#removeCasualsModal").modal();
        }

        function editTeamMember(workType, no, expenseType, myDays) {
            document.getElementById("MainBody_editDestinationTown").value = workType;
            document.getElementById("MainBody_editVoteItem").value = expenseType;
            document.getElementById("MainBody_editTeamMember").value = no;
            document.getElementById("MainBody_editNumberOfDays").value = myDays;
            document.getElementById("MainBody_originalNo").value = no;
            document.getElementById("MainBody_originalWorkType").value = workType;

            $("#editTeamMemberModal").modal();
        }

        function editFuel(workType, no, mileage) {
            document.getElementById("MainBody_editFuelOriginalNo").value = no;
            document.getElementById("MainBody_editFuelResource").value = no;
            document.getElementById("MainBody_editFuelOriginalWorkTye").value = workType;
            document.getElementById("MainBody_editFuelWorkType").value = workType;
            document.getElementById("MainBody_editFuelMileage").value = mileage;

            $("#editFuelModal").modal();
        }

        function editCasual(type, resourceNo, workType, noRequired, noOfDays) {
            document.getElementById("MainBody_originalCasualsType").value = type;
            document.getElementById("MainBody_originalCasualsResourceNo").value = resourceNo;
            document.getElementById("MainBody_editCasualsType").value = type;
            document.getElementById("MainBody_editCasualsResource").value = resourceNo;
            document.getElementById("MainBody_editCasualsWorkType").value = workType;
            document.getElementById("MainBody_editCasualsNoRequired").value = noRequired;
            document.getElementById("MainBody_editCasualsNoOfDays").value = noOfDays;

            $("#editCasualsModal").modal();
        }

        function editOtherCost(lineNo, voteItem, requiredFor, quantityRequired, noOfDays, unitCost) {


            document.getElementById("MainBody_originalLine").value = lineNo;
            document.getElementById("MainBody_editCostVoteItem").value = voteItem;
            document.getElementById("MainBody_editCostRequiredFor").value = requiredFor;
            document.getElementById("MainBody_editCostQuantityRequired").value = quantityRequired;
            document.getElementById("MainBody_editCostNoofDays").value = noOfDays;
            document.getElementById("MainBody_editCostUnitCost").value = unitCost;

            $("#editOtherCostsModal").modal();
        }
    </script>
    <div id="removeFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Fuel</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the fuel <strong id="fueltoRemoveName"></strong>from the imprest?</p>
                    <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Fuel" OnClick="removeFuel_Click" />
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="removeTeamMemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Member</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the team member <strong id="teamMembertoRemoveName"></strong>from the imprest team?</p>
                    <asp:TextBox runat="server" ID="removeNumber" type="hidden" />
                    <asp:TextBox runat="server" ID="removeWorkType" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Member" OnClick="removeMember_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editTeamMemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Team Member</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalNo" type="hidden" />
                    <asp:TextBox runat="server" ID="originalWorkType" type="hidden" />
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Destination Town</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editDestinationTown" />
                        </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Vote Item:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="editVoteItem" />
                            </div>
                        </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Team Member:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editTeamMember" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Number of Days:</strong>
                            <asp:TextBox runat="server" CssClass="form-control"  ID="editNumberOfDays" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Member" OnClick="editTeamMember_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="editFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Fuel</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editFuelOriginalWorkTye" type="hidden" />
                    <asp:TextBox runat="server" ID="editFuelOriginalNo" type="hidden" />
                    <div class="form-group">
                        <strong>Work Type</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editFuelWorkType" />
                    </div>
                    <div class="form-group">
                        <strong>Resource:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editFuelResource" />
                    </div>

                    <div class="form-group">
                        <strong>Mileage:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Mileage" ID="editFuelMileage" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Fuel" OnClick="editFuel_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removeCasualsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Casual</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the casual <strong id="casualtoRemoveName"></strong>from the imprest team?</p>
                    <asp:TextBox runat="server" ID="removeCasualType" type="hidden" />
                    <asp:TextBox runat="server" ID="removeCasualResourceNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <%--<asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Casual" OnClick="removeCasual_Click" />--%>
                </div>
            </div>

        </div>
    </div>

    <div id="editCasualsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Casual</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalCasualsType" type="hidden" />
                    <asp:TextBox runat="server" ID="originalCasualsResourceNo" type="hidden" />
                    <div class="form-group">
                        <strong>Type</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editCasualsType" />
                    </div>
                    <div class="form-group">
                        <strong>Resource:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editCasualsResource" />
                    </div>

                    <div class="form-group">
                        <strong>Work Type:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editCasualsWorkType" />
                    </div>

                    <div class="form-group">
                        <strong>No. Required:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="No. Required" ID="editCasualsNoRequired" />
                    </div>
                    <div class="form-group">
                        <strong>No. of Days:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCasualsNoOfDays" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <%--<asp:Button runat="server" CssClass="btn btn-success" Text="Edit Casual" OnClick="editCasual_Click" />--%>
                </div>
            </div>

        </div>
    </div>
    <div id="removeOtherCostsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Other Costs</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the cost with vote item <strong id="costtoRemoveName"></strong>from the imprest?</p>
                    <asp:TextBox runat="server" ID="costToRemovelineNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Cost" OnClick="removeOtherCost_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="editOtherCostsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Other Cost</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalLine" type="hidden" />
                    <div class="form-group">
                        <strong>Vote Item</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editCostVoteItem" />
                    </div>
                    <div class="form-group">
                        <strong>Required For:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Required For" ID="editCostRequiredFor" />
                    </div>

                    <div class="form-group">
                        <strong>Quantity Required:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Quantity Required" ID="editCostQuantityRequired" />
                    </div>
                    <div class="form-group">
                        <strong>No. of Days:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCostNoofDays" />
                    </div>
                    <div class="form-group">
                        <strong>Unit Cost:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCostUnitCost" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Cost" OnClick="editOtherCosts_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
