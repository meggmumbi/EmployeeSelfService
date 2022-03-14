<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DailyWorkTicketRequest.aspx.cs" Inherits="HRPortal.DailyWorkTicketRequest" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
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

            <%--<div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Driver No:</strong>
                    <asp:TextBox runat="server" ID="drivers" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>--%>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Ticket No:</strong>
                    <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Vehicle Registration No:</strong>
                    <asp:TextBox runat="server" ID="TextBox2" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Date Requested:</strong>
                    <asp:TextBox runat="server" ID="registrationDate" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Authorized By:</strong>
                    <asp:TextBox runat="server" ID="TextBox4" CssClass="form-control" />
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
            <div id="linesFeedback" runat="server"></div>

            <div class="col-md-6 col-lg-">
                <div class="form-group">
                    <strong>Transport Requisition:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="transportRequisition" />
                </div>

            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Date of Journey :</strong>
                    <asp:TextBox ID="dateOfRequest" CssClass="form-control" type="date" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Speedo reading (start of journey ):</strong>
                    <asp:TextBox ID="openOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Speedo reading (end of journey ):</strong>
                    <asp:TextBox ID="closedOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Kilometers of journey</strong>
                    <asp:TextBox ID="totalKilometres" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Time In:</strong><br />
                    <asp:DropDownList runat="server" ID="hour1" Style="height: 34px;" />
                    :
                                <asp:DropDownList runat="server" ID="minute1" Style="height: 34px;" />
                    <asp:DropDownList runat="server" ID="amPM1" Style="height: 34px;" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Time Out:</strong><br />
                    <asp:DropDownList runat="server" ID="hour" Style="height: 34px;" />
                    :
                                <asp:DropDownList runat="server" ID="minute" Style="height: 34px;" />
                    <asp:DropDownList runat="server" ID="amPM" Style="height: 34px;" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Fuel drawn in Liters</strong>
                    <asp:TextBox ID="fuelDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Oil drawn in Liters</strong>
                    <asp:TextBox ID="oilDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>ReceiptNo</strong>
                    <asp:TextBox ID="receiptNo" CssClass="form-control" runat="server" />
                </div>
            </div>

            <div class="col-md-4 col-lg-4">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Daily Work Ticket" ID="AddDailyWorkTicket" OnClick="AddDailyWorkTicket_Click" />
            </div>

            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Transport Requisition</th>
                        <th>Driver Allocated</th>
                        <th>Driver Name</th>
                        <th>Commencement</th>
                        <th>Destination</th>
                        <th>Vehicle Allocated</th>
                        <th>Date of Journey </th>
                        <th>Speedo reading (start of journey )</th>
                        <th>Speedo reading (end of journey )</th>
                        <th>Total Kilometres</th>
                        <th>Timeout</th>
                        <th>Timein</th>
                        <th>Fuel Drawn(in litres)</th>
                        <th>Oil Drawn(in litres)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.DailyWorkTicketLines.Where(r => r.Daily_Work_Ticket == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Transport_Requisition_No %></td>
                        <td><% =line.Driver_Allocated %></td>
                        <td><% =line.Driver_Name %></td>
                        <td><% =line.Commencement %></td>
                        <td><% =line.Destination %></td>
                        <td><% =line.Vehicle_Allocated %></td>
                        <td><% =Convert.ToDateTime(line.Date_of_Request).ToShortDateString() %></td>
                        <td><% =line.Opening_Odometer_Reading %></td>
                        <td><% =line.Closing_Odometer_Reading %></td>
                        <td><% =line.Total_Kilometres %></td>
                        <td><% =line.Time_out %></td>
                        <td><% =line.Time_In %></td>
                        <td><% =line.Fuel_Drawn_Litres %></td>
                        <td><% =line.Oil_Drawn_Litres %></td>
                        <td>
                            <label class="btn btn-primary" onclick="editLine('<%=line.EntryNo %>', '<%=line.Daily_Work_Ticket %>', '<%=Convert.ToDateTime(line.Date_of_Request).ToString("mm/dd/yyyy") %>','<%=line.Opening_Odometer_Reading %>','<%=line.Closing_Odometer_Reading %>','<%=line.Total_Kilometres %>', '<%=Convert.ToDateTime( line.Time_In).Hour %>','<%=Convert.ToDateTime(line.Time_out).Minute %>','<%=line.Fuel_Drawn_Litres %>','<%=line.ReceiptNo %>','<%=line.Oil_Drawn_Litres %>');"><i class="fa fa-pencil-square-o"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<%=line.Daily_Work_Ticket %>','<%=line.EntryNo %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Next" ID="GoStep3" OnClick="GoStep3_Click" />

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
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click1" />
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Daily Work Ticket Card/";
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

                        <td><a href="<%=fileFolderApplication %>\Daily Work Ticket Card\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click1" />
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
            //document.getElementById("MainBody_edthour1").value = timeIn;
            //document.getElementById("MainBody_edthour").value = timeOut;
            document.getElementById("MainBody_edtfuelDrawn").value = fuelDrawn;
            document.getElementById("MainBody_edtReceiptNo").value = receiptNo;
            document.getElementById("MainBody_editLineNo").value = lineNo;
            document.getElementById("MainBody_edtOilDrawn").value = oilDrawn;
            //$('#MainBody_editVoteItem').val(voteItem).trigger('change');
            $("#editLineModal").modal();
        }
    </script>
    <script>
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
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

    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" ID="DeleteTicketLine" OnClick="DeleteTicketLine_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
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


                    <%--<div class="form-group">
                                <strong>Time In:</strong><br/>
                                 <asp:DropDownList runat="server" ID="edthour1" style="height: 34px;"/> :
                                <asp:DropDownList runat="server" ID="edtminute1" style="height: 34px;"/> 
                                <asp:DropDownList runat="server" ID="edtamPM1" style="height: 34px;"/> 
                            </div>
                    
                   
                            <div class="form-group">
                                <strong>Time Out:</strong><br/>
                                 <asp:DropDownList runat="server" ID="edthour" style="height: 34px;"/> :
                                <asp:DropDownList runat="server" ID="edtminute" style="height: 34px;"/> 
                                <asp:DropDownList runat="server" ID="edtamPM" style="height: 34px;"/> 
                            </div>--%>


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
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" ID="editItem" OnClick="editItem_Click" />
                </div>
            </div>

        </div>
    </div>


</asp:Content>
