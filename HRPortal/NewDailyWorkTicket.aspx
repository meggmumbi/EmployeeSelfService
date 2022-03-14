<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewDailyWorkTicket.aspx.cs" Inherits="HRPortal.NewDailyWorkTicket" %>

<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
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
        if (step == 1)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Daily Work Ticket General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Month Date:</strong>
                        <asp:DropDownList runat="server" ID="monthdate" CssClass="form-control select2" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Current Ticket Number:</strong>
                        <asp:TextBox runat="server" ID="ticketno" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Previous Ticket Number:</strong>
                        <asp:TextBox runat="server" ID="previousticketNo" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Vehicle Registration Number:</strong>
                        <asp:DropDownList runat="server" ID="vehiclenumber" CssClass="form-control select2" AutoPostBack="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Date Closed:</strong>
                        <asp:TextBox runat="server" ID="em_EndDate" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Authorized By:</strong>
                        <asp:DropDownList runat="server" ID="authorizedBy" CssClass="form-control select2" AutoPostBack="true" />
                    </div>
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
            Daily Work Ticket Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="LinesFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Transport Requisition No:</strong>
                        <asp:DropDownList runat="server" ID="requisitionNo" CssClass="form-control select2" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Date:</strong>
                        <asp:TextBox runat="server" ID="tr_StartDate" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Driver Name:</strong>
                        <asp:DropDownList runat="server" ID="driverNo" CssClass="form-control select2" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Details Of Journey And Route In Full:</strong>
                        <asp:TextBox runat="server" ID="journeydetails" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Closing Odometer Reading:</strong>
                        <asp:TextBox runat="server" ID="closingodometerreading" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Fuel Drawn(Litres):</strong>
                        <asp:TextBox runat="server" ID="fueldrawn" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Opening Odometer Reading:</strong>
                        <asp:TextBox runat="server" ID="openodometerreading" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Oil Drawn(Litres):</strong>
                        <asp:TextBox runat="server" ID="oildrawn" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Total Kilometers:</strong>
                        <asp:TextBox runat="server" ID="totalkilometers" TextMode="Number" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Receipt Number:</strong>
                        <asp:TextBox runat="server" ID="cashreceiptNo" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <br />
                    <br />
                    <br />
                    <asp:Button runat="server" CssClass="btn-success btn btn-block" Text="Add Daily Work Ticket Line Details" ID="addlines" OnClick="addlines_Click" />
                </div>
            </div>
        </div>

        <hr />
        <table id="example1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Destination</th>
                    <th>Total Km</th>
                    <th>Oil Drawn</th>
                    <th>Fuel Drawn</th>
                    <th>Receipt No</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    string employeeNo = Convert.ToString(Session["employeeNo"]);
                    string ticketNo = Request.QueryString["ticketNo"];
                    var tickets = nav.DailyWorkTicketLines.Where(r => r.Daily_Work_Ticket == ticketNo);
                    foreach (var request in tickets)
                    {
                %>
                <tr>
                    <td><%=request.Transport_Requisition_No %></td>
                    <td><%=request.Destination %></td>
                    <td><%=request.Total_Kilometres %></td>
                    <td><%=request.Oil_Drawn_Litres %></td>
                    <td><%=request.Fuel_Drawn_Litres %></td>
                    <td><%=request.ReceiptNo %></td>
                    <td><label class="btn btn-success" onclick="editDailyTicket( '<%=request.EntryNo %>', '<%=request.Total_Kilometres %>','<%=request.Oil_Drawn_Litres %>','<%=request.Fuel_Drawn_Litres %>', '<%=request.ReceiptNo %>');"><i class="fa fa-edit"></i>Edit</label></td>
                    <td><label class="btn btn-danger" onclick="removeDailyTicket('<%=request.EntryNo %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="tostep1" OnClick="Previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="Button1" OnClick="nextpage_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%}
        else if (step == 3)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Daily Work Ticket Card/";
                            String ticketNo = Request.QueryString["ticketNo"];
                            ticketNo = ticketNo.Replace('/', '_');
                            ticketNo = ticketNo.Replace(':', '_');
                            String documentDirectory = filesFolder + ticketNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>

                        <td><a href="<%=fileFolderApplication %>\Daily Work Ticket Card\<% =ticketNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="BackToStep2" OnClick="BackToStep2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%

        }
    %>

    <script>
        function editDailyTicket(entryno, km, oildrawn, fueldrawn, receiptno) {
            document.getElementById("MainBody_editKm").value = km;
            document.getElementById("MainBody_editOil").value = oildrawn;
            document.getElementById("MainBody_editFuel").value = fueldrawn;
            document.getElementById("MainBody_entryno").value = entryno;
            document.getElementById("MainBody_editreceiptno").value = receiptno;
            $("#editDailyTicketModal").modal();
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
        function removeDailyTicket(LineNo) {
            document.getElementById("MainBody_removeLineNumber").value = LineNo;
            $("#removeDailyTicketModal").modal();
        }
    </script>
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

    <div id="editDailyTicketModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Daily Work Ticket</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="entryno" type="hidden" />
                    <div class="form-group">
                        <strong>Kilometers Covered</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editKm" />
                    </div>
                    <div class="form-group">
                        <strong>Oil Drawn:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editOil" />
                    </div>
                    <div class="form-group">
                        <strong>Fuel Drawn</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editFuel" />
                    </div>
                    <div class="form-group">
                        <strong>Receipt No:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editreceiptno" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Daily work ticket" ID="editdailyticketline" OnClick="editdailyticketline_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="removeDailyTicketModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Daily Work Ticket Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Daily Work Ticket line?</p>
                    <asp:TextBox runat="server" ID="removeLineNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Daily Work Ticket Line" ID="removeticketline" OnClick="removeticketline_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
