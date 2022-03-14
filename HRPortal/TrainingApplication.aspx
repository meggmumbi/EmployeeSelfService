<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingApplication.aspx.cs" Inherits="HRPortal.TrainingApplication" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
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
            Training Application General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Training</a></li>
                        <li class="breadcrumb-item active">Training General Details </li>
                    </ol>
                </div>

            </div>
            <div class="row">
                <div id="generalfeedback" runat="server"></div>
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <strong>Training Plan</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="trainingPlan" OnSelectedIndexChanged="trainingPlan_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Course Title</strong>
                        <asp:DropDownList ID="txtcourseTitle" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="txtcourseTitle_SelectedIndexChanged">
                            
                        </asp:DropDownList>
                    </div>
                     <div class="form-group">
                        <strong>Course Category</strong>
                        <asp:TextBox ID="coursecategory" runat="server" CssClass="form-control " ReadOnly="true" />
                    </div>
                     <div class="form-group">
                        <strong>Training Objective</strong>
                        <asp:TextBox ID="description" runat="server" CssClass="form-control " />
                    </div>
                    <div class="form-group">
                        <strong>Start Date</strong>
                        <asp:TextBox ID="mstartDate" runat="server" CssClass="form-control " ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>End Date</strong>
                        <asp:TextBox ID="mendDate" runat="server" CssClass="form-control " ReadOnly="true"/>
                    </div>
                    <div class="form-group">
                        <strong>Fundcode</strong>                     
                        <asp:DropDownList runat="server" ID="fundcode" CssClass="form-control" AppendDataBoundItems="true" >
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Financial Year</strong>                     
                        <asp:DropDownList runat="server" ID="year" CssClass="form-control select2" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Training Type</strong>                     
                        <asp:DropDownList runat="server" ID="trainingtype" CssClass="form-control select2">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="0">Internal</asp:ListItem>
                            <asp:ListItem Value="1">External</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Mode Of Training:</strong>                     
                        <asp:DropDownList runat="server" ID="modeoftraining" CssClass="form-control select2">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="0">Lectures</asp:ListItem>
                            <asp:ListItem Value="1">Technology based(Online)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Training Venue Region</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="trainingvenue" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Duration</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Duration" ReadOnly="true"/>
                    </div>
                    <div class="form-group">
                        <strong>Residency</strong>                     
                        <asp:DropDownList runat="server" ID="residency" CssClass="form-control select2">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="0">Residential</asp:ListItem>
                            <asp:ListItem Value="1">Non residential</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Training Location</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="location" />
                    </div>
                    <div class="form-group">
                        <strong>Training Institution</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="nprovider" ReadOnly="true"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addGeneralDetails" OnClick="addGeneralDetails_Click"/>
            <span class="clearfix"></span>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Training Participants
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Training</a></li>
                        <li class="breadcrumb-item active">Training Participants </li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div runat="server" id="teamFeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Type</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="type" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Team Member</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="teamMember" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Destination</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="linedestination" ReadOnly="true"/>
                    </div>
                    <div class="form-group">
                        <strong>Number of Days</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="teamNumberOfDays" placeholder="Number of Days" type="number" min="0" AutoCompleteType="Disabled" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Destination</th>
                        <th>Team Member</th>
                        <th>Number of Days</th>
                        <th>Total Amount</th>
                        <th>Qualifications</th>
                        <th>Training History</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        string docNo = Request.QueryString["docNo"];

                        var query = nav.TrainingParticipants.Where(x => x.Training_Code == docNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Type %></td>
                        <td><%=item.Destination %></td>
                        <td><%=item.Employee_Name %></td>
                        <td><%=item.No_of_Days %></td>
                        <td><%=item.Total_Amount %></td>
                        <td><label class="btn btn-warning" onclick="qualifications('<%=item.Employee_Code %>');"><i class="fa fa-eye fa-fw"></i>Qualifications</label></td>
                        <td><label class="btn btn-primary" onclick="traininghistory('<%=item.Employee_Code %>');"><i class="fa fa-eye fa-fw"></i>Training History</label></td>
                        <td>
                            <label class="btn btn-success" onclick="editTeamMember('<%=item.Line_No %>','<%=item.Type %>','<%=item.Employee_Code  %>','<%=item.No_of_Days %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeTeamMember('<%=item.Line_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackStep1" OnClick="GoBackStep1_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="gotostep3" Text="Next" OnClick="gotostep3_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>

      <% 
        }
        else if (step == 3)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Training Costs
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Training</a></li>
                        <li class="breadcrumb-item active">Training Costs </li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div runat="server" id="costfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Cost Category</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="costcategory" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem value="0">Training</asp:ListItem>
                            <asp:ListItem value="1">Procurable</asp:ListItem>
                            <asp:ListItem value="2">Other Costs</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Employee</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="costEmp">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Unit Cost</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="unitcost"/>
                    </div>
                    <div class="form-group">
                        <strong>Cost Item</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="costitem" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Item Category:</strong>                     
                        <asp:DropDownList runat="server" ID="itemcategory" CssClass="form-control select2" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="itemcategory_SelectedIndexChanged">
                              <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Service/Item:</strong>                     
                       <asp:DropDownList runat="server" ID="itemcode" CssClass="form-control select2" AutoPostBack="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Quantity</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="quantity"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="costDescription"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Unit of Measure</strong>                     
                        <asp:DropDownList runat="server" ID="uom" CssClass="form-control select2" AppendDataBoundItems="true">
                              <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Source of Fund</strong>                     
                        <asp:DropDownList runat="server" ID="fundsource" CssClass="form-control select2" AppendDataBoundItems="true">
                              <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Training Cost" ID="addtrainingcosts" OnClick="addtrainingcosts_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Cost Category</th>
                        <th>Description</th>
                        <th>Unit Cost</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["docNo"];

                        var query = nav.TrainingCost.Where(x => x.Training_ID == docNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Cost_Category %></td>
                        <td><%=item.Description %></td>
                        <td><%=item.Unit_Cost_LCY %></td>
                        <td><%=item.Quantity %></td>
                        <td><%=item.Line_Amount %></td>
                        <td>
                            <label class="btn btn-success" onclick="editCost('<%=item.Cost_Category %>','<%=item.Cost_Category %>','<%=item.Cost_Item  %>', '<%=item.Service_Item_Code %>','<%=item.Unit_Cost_LCY %>','<%=item.Quantity %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeCost('<%=item.Line_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackStep2" OnClick="GoBackStep2_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="GoToStep4" Text="Next" OnClick="GoToStep4_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
          <% 
        }
        else if (step == 4)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Training Needs
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <table id="example3" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var nav = new Config().ReturnNav();
                        string docNo = Request.QueryString["docNo"];

                        var query = nav.TrainingCoursesNeeds.Where(x => x.Training_Need_Code == docNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Course_Code %></td>
                        <td><%=item.Training_Need_Description %></td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="txtgobacktostep3" OnClick="txtgobacktostep3_Click1"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="gotostep5" Text="Next" OnClick="gotostep5_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>


    <%}
        else if (step == 5)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Training</a></li>
                        <li class="breadcrumb-item active">Training Supporting Documents </li>
                    </ol>
                </div>
            </div>
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
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Training Requisition/";
                       String imprestNo = Request.QueryString["docNo"];
                       imprestNo = imprestNo.Replace('/', '_');
                       imprestNo = imprestNo.Replace(':', '_');
                       String documentDirectory = filesFolder + imprestNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               //String myfile = Convert.ToString(file);
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                       <td><a href="DownLoadFile.aspx?fileName=<%=file.Replace(documentDirectory, "")%>&&docNo=<%=imprestNo %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>    
                      <%-- <td><a href="imprest.aspx?&&myfile=<%=Request.QueryString["url"] %>"></a></td>  --%>               
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
            <center>
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Print Training Application Report" ID="printReport" OnClick="printReport_Click"/>
            </center><br />
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackToStep3" OnClick="GoBackToStep4_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
<%} %>

     <script>
         function removeTeamMember(LineNo) {
             document.getElementById("MainBody_removeLineNumber").value = LineNo;
              $("#removeTeamMemberModal").modal();
          }
      </script>  

      <script>
         function removeCost(LineNo) {
             document.getElementById("MainBody_CostLineNumber").value = LineNo;
              $("#removeCostModal").modal();
          }
      </script>  
         <script>
        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("MainBody_fileName").value = fileName;
             $("#deleteFileModal").modal(); 
         }
     </script> 
    <script>
        function editTeamMember(entryno, type, teammember, days) {
            document.getElementById("MainBody_editType").value = type;
            document.getElementById("MainBody_editTeamMember").value = teammember;
            document.getElementById("MainBody_editDays").value = days;
            document.getElementById("MainBody_originalNo").value = entryno;
            $("#editTeamMemberModal").modal();
        }
    </script>
    <script>
    function qualifications(employee) {
        document.getElementById("MainBody_employeequalification").value = employee;
    $("#trainingqualifications").modal();
        }
    </script> 

    <script>
    function traininghistory(employee) {
        document.getElementById("MainBody_employeetraininghist").value = employee;
    $("#traininghistory").modal();
        }
    </script> 

  <div id="removeTeamMemberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Team Member</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the team member?</p>
          <asp:TextBox runat="server" ID="removeLineNumber" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Team Member" ID="removeteammember" OnClick="removeteammember_Click"/>
      </div>
    </div>

  </div>
</div>

  <div id="removeCostModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Cost</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the cost?</p>
          <asp:TextBox runat="server" ID="CostLineNumber" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Cost" ID="removecost" OnClick="removecost_Click"/>
      </div>
    </div>

  </div>
</div>
   
 <div id="editTeamMemberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Training Participant</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalNo" type="hidden"/> 
        <div class="form-group">
            <strong>Type:</strong>
            <asp:DropDownList runat="server"  CssClass="form-control select2"   ID="editType" style="width:570px"/>
        </div> 
        <div class="form-group">
            <strong>Team Member:</strong>
            <asp:DropDownList runat="server"  CssClass="form-control select2"  ID="editTeamMember" style="width:570px"/>
        </div> 
          <div class="form-group">
            <strong>Number of Days:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editDays"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Team Member" ID="editteammemberbutton" OnClick="editteammemberbutton_Click"/>
      </div>
    </div>

  </div>
</div>

     <div id="deleteFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click"/>
      </div>
    </div>

  </div>
</div>

   <!--Training Qualifications-->
     <div id="trainingqualifications" class="modal fade" role="dialog">
                     <div class="modal-dialog" style="width:800px">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Employee Qualifications </h4>
                            </div>
                            <div class="modal-body">
                            
                         <div class="row" style="width:800px">
                    <div class="panel-body" style="width:800px">
                        <asp:TextBox runat="server" ID="employeequalification" type="hidden"/>
                     <table id="example5" class="table table-bordered table-striped secondary1ActivityInitiativeTableDetails">
                        <thead>
                            <tr>
                                <th>Qualification Code</th>
                                <th>From Date</th>
                                <th>To Date</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Institution</th>
                                <th>Year</th>
                                <th>Specialization</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                var employeeNo4 = employeequalification.Text.Trim();
                                var nav4 = new Config().ReturnNav();
                                var qualification = nav4.EmployeeQualification.Where(x=> x.Employee_No == employeeNo4).ToList();
                                foreach (var qual in qualification)
                                {
                            %>
                            <tr> 
                                <td><% =qual.Qualification_Code%> </td>
                                <td><% = Convert.ToDateTime(qual.From_Date).ToString("dd/MM/yyyy")%> </td>
                                <td><% =Convert.ToDateTime(qual.To_Date).ToString("dd/MM/yyyy")%> </td>
                                 <td><% =qual.Type%> </td>
                                <td><% =qual.Description%> </td>
                                <td><% =qual.Institution_Company%></td>
                                <td><% =qual.Year%> </td>
                                <td><% =qual.Specialization%></td>
                                <%
                                }

                                %>
                        </tbody>
                    </table>
                </div>
                </div>
               </div>
            </div>
        </div>
    </div>
     <!--Training History-->
         <div id="traininghistory" class="modal fade" role="dialog">
                     <div class="modal-dialog" style="width:800px">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Training History </h4>
                            </div>
                    <div class="modal-body">                        
                    <div class="row" style="width:800px">
                    <div class="panel-body" style="width:800px">
                    <asp:TextBox runat="server" ID="employeetraininghist" type="hidden"/>
                     <table id="example4" class="table table-bordered table-striped secondary1ActivityInitiativeTableDetails">
                        <thead>
                            <tr>
                                <th>Course</th>
                                <th>Venue</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                string employeeNo5 = employeetraininghist.Text.Trim();
                                var nav5 = new Config().ReturnNav();
                                var history = nav5.TrainingHistory.Where(x=> x.Employee_No == employeeNo5).ToList();
                                foreach (var hist in history)
                                {
                            %>
                            <tr> 
                                <td><% =hist.Course%> </td>
                                <td><% =hist.Venue%> </td>
                                <td><% = Convert.ToDateTime(hist.Start_Date).ToString("dd/MM/yyyy")%></td>
                                <td><% = Convert.ToDateTime(hist.End_Date).ToString("dd/MM/yyyy")%></td>
                                <%
                                }

                                %>
                        </tbody>
                    </table>
                </div>
                </div>
               </div>
            </div>
        </div>
    </div>
</asp:Content>
