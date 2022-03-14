<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TransportRequisitionTrips.aspx.cs" Inherits="HRPortal.TransportRequisitionTrips" %>

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
            Trip Requisition General Details
       <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-">
                <div class="form-group">
                    <strong>Trip Date:</strong>
                    <asp:TextBox ID="tripdate" CssClass="form-control" runat="server" />
                </div>

            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Details of Journey and Route in Full :</strong>
                    <asp:TextBox runat="server" ID="detailsofjourney" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Kilometers of Journey :</strong>
                    <asp:TextBox runat="server" ID="kilometers" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Oil Drawn(Litres) :</strong>
                    <asp:TextBox runat="server" ID="oildrwan" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Fuel Drawn(Litres):</strong>
                    <asp:TextBox runat="server" ID="fueldrawn" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>P.O.L (S15) Voucher No LPO No. or Cash Receipt No:</strong>
                    <asp:TextBox runat="server" ID="voucherno" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Speedo Reading Beginning of Journey:</strong>
                    <asp:TextBox runat="server" ID="opsodometer" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Speedo Reading end of Journey:</strong>
                    <asp:TextBox runat="server" ID="endodometer" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Authorized By:</strong>
                    <asp:DropDownList runat="server" ID="authorizedby" CssClass="form-control" />
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
            Trip Incidences and Accidents
          <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-">
                <div class="form-group">
                    <strong>Accident Date:</strong>
                    <asp:TextBox ID="accidentdate" CssClass="form-control" runat="server" />
                </div>

            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Accident Details :</strong>
                    <asp:TextBox ID="accidentdetails" CssClass="form-control" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Police Abstract No:</strong>
                    <asp:TextBox ID="policeabstract" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Remarks:</strong>
                    <asp:TextBox ID="remarks" CssClass="form-control" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Incident" ID="AddIncidencesDetails" OnClick="accidentDetails_Click" />
            </div>

            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Transport Requisition</th>
                        <th>Driver No.</th>
                        <th>Accident Date</th>
                        <th>Abstract No</th>
                        <th>Remarks</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.VehicleAccidentDetails.Where(r => r.RegNo == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.RegNo %></td>
                        <td><% =line.Driver %></td>
                        <td><% =line.Accident_date %></td>
                        <td><% =line.Police_Obstract_No %></td>
                        <td><% =line.Remarks %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removetripLine('<%=line.Entry_Number %>','<%=line.Police_Obstract_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Requisition" OnClick="sendApproval_Click" />
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Incident" OnClick="deleteLineIncidents_Click" />
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
