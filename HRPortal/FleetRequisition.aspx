<%@ Page Title="Fleet Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FleetRequisition.aspx.cs" Inherits="HRPortal.FleetRequisition" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 6 || step < 1)
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
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Travel Type:</strong>
                    <asp:DropDownList runat="server" ID="travelType" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="travelType_SelectedIndexChanged">
                        <asp:ListItem>Select</asp:ListItem>
                        <asp:ListItem Value="0">Local Running</asp:ListItem>
                        <asp:ListItem Value="1">Safari</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        <%--    <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <asp:Label ID="ImprestMemo" runat="server" Text=""><strong>Imprest Memo:</strong></asp:Label>
                    <asp:DropDownList runat="server" ID="imprestNo" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="imprestselected_SelectedIndexChanged" />
                </div>
            </div>--%>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>From:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="from" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Destination:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="destination"  />
                </div>
            </div>


            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Journey Route:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="journeyRoute"  />

                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Purpose of Trip:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="purposeOfTrip"  />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <asp:Label ID="daysrequested" runat="server" Text=""><strong>No. of Days Requested:</strong></asp:Label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="noOfDays" TextMode="Number"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Date of Trip:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="dateofTrip"  />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <asp:Label ID="timeout" runat="server" Text=""><strong>Time of Trip(e.g 10.30):</strong></asp:Label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="timeoftrip"  TextMode="Time" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <asp:Label ID="houresoftrip" runat="server" Text=""><strong>Hours of trip:</strong></asp:Label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="triphours" />
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {

    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Travel Requisition Staff
           <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-8 col-lg-8">
                    <strong>Employee:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="employee" />
                </div>
                <div class="col-md-4 col-lg-4">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click" />
                </div>
            </div>
            <br />
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Employee Number</th>
                        <th>Employee Name</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.TravelRequisitionStaff.Where(r => r.Req_No == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Employee_No %></td>
                        <td><% =line.Employee_Name %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeStaff('<%=line.EntryNo %>', '<%=line.Employee_Name %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />

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
            Non Staff Members                    
                      <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback1" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>ID No/Passport Number:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="idnumber" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Name:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="names" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Phone Number:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="phonumber" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Organization Name:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="organization" />
                </div>
                <div class="col-md-4 col-lg-4">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Non Staff Member" ID="Button1" OnClick="addNonStaffMembers_Click" />
                </div>
            </div>
            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID Number</th>
                        <th>Name</th>
                        <th>Phone Number</th>
                        <th>Organization Name</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.TravelRequisitionNonStaff.Where(r => r.Req_No == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.ID_No %></td>
                        <td><% =line.Name %></td>
                        <td><% =line.Phone_Number %></td>
                        <td><% =line.Position %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeNonStaff('<%=line.EntryNo %>', '<%=line.Req_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button2" OnClick="previous1_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed3_Click" />

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Load Details               
                      <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback1" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Item Category:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="itemCategory" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Description:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="description" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Quantity:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="quantity" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Purpose:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="purpose" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Serial Number:</strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="txtserialNumber" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Returnable:</strong>
                    <asp:CheckBox runat="server" CssClass="form-control " ID="returnable" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Return Date:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="returndate" placeholder="Return Date" />
                    </div>
                </div>
                <div class="col-md-4 col-lg-4">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Load Details" ID="Button3" OnClick="addLoadDetails_Click" />
                </div>
            </div>
            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Item Category</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Purpose</th>
                        <th>Return Date</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.FleetRequistionLines.Where(r => r.Requisition_Number == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Item_Type %></td>
                        <td><% =line.Description %></td>
                        <td><% =line.Quantity %></td>
                        <td><% =line.Purpose %></td>
                        <td><% =line.Item_Return_Date %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeload('<%=line.Ticket_No %>', '<%=line.Item_Type %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button4" OnClick="previous3_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed4_Click" />

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
            Fuel  Details               
                      <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="fuelfeedback" runat="server"></div>
            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Expense Type</th>
                        <th>Project No</th>
                        <th>Project name</th>
                        <th>Budget Line No.</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.FuelTravelRequisition.Where(r => r.Req_No == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Expense_Type %></td>
                        <td><% =line.Job_No %></td>
                        <td><% =line.Job_Name %></td>
                        <td><% =line.Job_Task %></td>
                        <td><% =line.Requested_Amount %></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button6" OnClick="previous3_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed5_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (step == 6)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
                            String imprestNo = Request.QueryString["requisitionNo"];
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" />
            <div class="clearfix"></div>
        </div>
    </div>



    <%
        }
    %>
    <script>
        function removeStaff(id, name) {
            var host = '<%=ConfigurationManager.AppSettings["SiteLocation"]%>';
            var requisitionNo = '<%=Request.QueryString["requisitionNo"]%>';
            swal({
                title: "Are you sure you want to remove " + name + " from the travel requisition?",
                text: "Once deleted, this action cannot be undone!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
              .then((willDelete) => {
                  if (willDelete) {

                      window.location.href = host + "FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo + "&&entry=" + id;
                      /*swal("Poof! Your imaginary file has been deleted!", {
                          icon: "success",
                      });*/
                  } /*else {
                     swal("Your imaginary file is safe!");
                 }*/
              });
        }
    </script>
    <script>
        function removeStaff(id, name) {
            document.getElementById("staffname").innerText = name;
            document.getElementById("MainBody_staffid").value = id;
            $("#deletestaffModal").modal();
        }
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }

        function removeload(entry, name) {
            document.getElementById("itemcategory").innerText = name;
            document.getElementById("MainBody_entrynumber").value = entry;
            $("#deleteloadModal").modal();
        }
        function removefuel(tasks, expensetype) {
            document.getElementById("fueltype").innerText = expensetype;
            document.getElementById("MainBody_txtfuel").value = tasks;
            $("#deletefuelModal").modal();
        }
        function removeNonStaff(entry, name) {
            document.getElementById("stffname").innerText = name;
            document.getElementById("MainBody_nonstaffnumber").value = entry;
            $("#deleteNonStaffModal").modal();
        }
    </script>
    <div id="deletestaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Staff Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Staff Details <strong id="staffname"></strong>?</p>
                    <asp:TextBox runat="server" ID="staffid" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff Details" OnClick="deleteStaffClick" />
                </div>
            </div>

        </div>
    </div>
    <div id="deletefuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Fuel Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the fuel Details <strong id="fueltype"></strong>?</p>
                    <asp:TextBox runat="server" ID="txtfuel" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Fuel Details" OnClick="deletefuel_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="deleteNonStaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Non Staff Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="stffname"></strong>?</p>
                    <asp:TextBox runat="server" ID="nonstaffnumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff" OnClick="deleteStaff_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="deleteloadModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Load Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="itemcategory"></strong>?</p>
                    <asp:TextBox runat="server" ID="entrynumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Load" OnClick="deleteLoad_Click" />
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

</asp:Content>
