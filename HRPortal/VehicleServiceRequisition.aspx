<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="VehicleServiceRequisition.aspx.cs" Inherits="HRPortal.VehicleServiceRequisition" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 2 || step < 1)
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
            Motor vehicle Requisition General Details
       <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Vehicle Registration No.:</strong>
                        <asp:DropDownList ID="registrationNumber" CssClass="form-control select2" runat="server" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Project No:</strong>
                        <asp:DropDownList runat="server" ID="projectnumber" CssClass="form-control select2" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="True" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Odometer Reading:</strong>
                        <asp:TextBox runat="server" ID="odometerreading" CssClass="form-control" TextMode="Number" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Budget Line:</strong>
                        <asp:DropDownList runat="server" ID="voteitemline" CssClass="form-control select2" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Service Type:</strong>
                        <asp:DropDownList runat="server" ID="servicecode" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Maintenance Cost :</strong>
                        <asp:TextBox runat="server" ID="maintenancecost" CssClass="form-control" TextMode="Number" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description:</strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Vendor(Dealer):</strong>
                        <asp:DropDownList runat="server" ID="vendornumber" CssClass="form-control select2" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>FundCode:</strong>
                        <asp:DropDownList runat="server" ID="fundingsource" CssClass="form-control" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
        <div class="clearfix"></div>
    </div>
    <%
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
    %>
    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("MainBody_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }

        function editLine(lineNo, treq, date, openOdometer, closedOdometer, totalKM, timeIn, timeOut, fuelDrawn, receiptNo, oilDrawn) {
            document.getElementById("MainBody_edtTransportRequisition").value = treq;
            document.getElementById("MainBody_edtdateOfRequest").value = date;
            document.getElementById("MainBody_edtopenOdometer").value = openOdometer;
            document.getElementById("MainBody_edtclosedOdometer").value = closedOdometer;
            document.getElementById("MainBody_edttotalKilometres").value = totalKM;
            document.getElementById("MainBody_edtfuelDrawn").value = fuelDrawn;
            document.getElementById("MainBody_edtReceiptNo").value = receiptNo;
            document.getElementById("MainBody_editLineNo").value = lineNo;
            document.getElementById("MainBody_edtOilDrawn").value = oilDrawn;
            $("#editLineModal").modal();
        }
    </script>
    <script>
        function removetripLine(entry, policeabstract) {
            document.getElementById("txtpoliceabstract").innerText = policeabstract;
            document.getElementById("MainBody_incidentdelete").value = entry;
            $("#deleteTripModal").modal();
        }
    </script>
    <div id="deleteTripModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Incidents</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Incident <strong id="txtpoliceabstract"></strong>?</p>
                    <asp:TextBox runat="server" ID="incidentdelete" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Incident" />
                </div>
            </div>

        </div>
    </div>

    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="itemName"></strong>?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" ID="DeleteTicketLine" />
                </div>
            </div>

        </div>
    </div>

    <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editLineNo" type="hidden" />

                    <div class="form-group">
                        <strong>Transport Requisition:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="edtTransportRequisition" />
                    </div>

                    <div class="form-group">
                        <strong>Date Of Request:</strong>
                        <asp:TextBox ID="edtdateOfRequest" CssClass="form-control" type="date" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Opening Odometer Reading:</strong>
                        <asp:TextBox ID="edtopenOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Closing Odometer Reading:</strong>
                        <asp:TextBox ID="edtclosedOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Total Kilometres</strong>
                        <asp:TextBox ID="edttotalKilometres" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Fuel Drawn</strong>
                        <asp:TextBox ID="edtfuelDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>
                    <div class="form-group">
                        <strong>Oil drawn in Liters</strong>
                        <asp:TextBox ID="edtOilDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>

                    <div class="form-group">
                        <strong>ReceiptNo</strong>
                        <asp:TextBox ID="edtReceiptNo" CssClass="form-control" runat="server" />
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" ID="editItem" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
