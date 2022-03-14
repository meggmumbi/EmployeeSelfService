<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="OpenTransportRequisitionTrips.aspx.cs" Inherits="HRPortal.OpenTransportRequisitionTrips" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Open Transport Reqisition Trips
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Requisition No</th>
                        <th>Commencement</th>
                        <th>Vehicle Allocated</th>
                        <th>Driver No.</th>
                        <th>Driver Name</th>
                        <th>Date of Request</th>
                        <th>Purpose of Trip</th>
                        <th>Status</th>
                        <th>View/edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var filelines = nav.TransportTrips.Where(x => x.Status == "Open" && x.Driver_Allocated == employeeNo).ToList();
                        foreach (var file in filelines)
                        {
                    %>
                    <tr>
                        <td><% =file.Transport_Requisition_No %></td>
                        <td><% =file.Commencement%></td>
                        <td><% =file.Vehicle_Allocated%></td>
                        <td><% =file.Driver_Allocated%> </td>
                        <td><% =file.Driver_Name%></td>
                        <td><% =Convert.ToDateTime(file.Date_of_Request).ToString("dd/MM/yyyy")%></td>
                        <td><% =file.Purpose_of_Trip%></td>
                        <td><% =file.Status%></td>
                        <td><a href="TransportRequisitionTrips.aspx?step=1&&requisitionNo=<%=file.Transport_Requisition_No %>" class="btn btn-success">View/Edit</a></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
    <div id="showApprovalEntriesModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Fleet Requisition <strong id="myRecordId"></strong>Approval Entries</h4>
                </div>
                <div class="modal-body">
                    <div class="overlay" id="myLoading">
                        <i class="fa fa-refresh fa-spin" id="refreshBar"></i>

                        <table class="table table-bordered table-striped" id="entriesTable" style="display: none;">
                            <thead>
                                <tr>
                                    <th>Sequence No.</th>
                                    <th>Status</th>
                                    <th>Sender Id</th>
                                    <th>Approver Id</th>
                                    <th>Amount</th>
                                    <th>Date Sent for Approval</th>
                                    <th>Due Date</th>
                                    <th>Comment(s)</th>
                                </tr>
                            </thead>
                            <tbody id="approvalEntries"></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function showApprovalEntries(recordId, tableId, recordType) {
            //   
            $("#myLoading").addClass("overlay");
            $('#entriesTable').hide();
            $('#refreshBar').show();
            document.getElementById("myRecordId").innerHTML = recordId;

            $.ajax({
                url: "receiver/api/values",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify({
                    'TableId': tableId,
                    'DocumentType': recordType,
                    'DocumentNo': recordId
                }),
                dataType: "json"
            })
      .done(function (response) {
          var table = $("#entriesTable tbody");
          for (var i = document.getElementById("entriesTable").rows.length; i > 1; i--) {
              document.getElementById("entriesTable").deleteRow(i - 1);
          }

          for (var i = 0; i < response.length; i++) {
              var obj = response[i];//obj.enrolmentId
              table.append("<tr>" +
                  "<td>" + obj.SequenceNo + "</td>"
                  + "<td>" + obj.Status + "</td>"
                  + "<td>" + obj.SenderId + "</td>"
                  + "<td>" + obj.ApproverId + "</td>"
                  + "<td>" + obj.Amount + "</td>"
                  + "<td>" + obj.DateSentforApproval + "</td>"
                  + "<td>" + obj.DueDate + "</td>"
                  + "<td>" + obj.Comment + "</td>"
                   + " </tr>");

          }
          $("#myLoading").removeClass("overlay");
          $('#entriesTable').show();
          $('#refreshBar').hide();

      })

            $("#showApprovalEntriesModal").modal();
        }

    </script>

    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approveImprestMemoNo").innerHTML = documentNumber;
            document.getElementById("MainBody_imprestMemoToApprove").value = documentNumber;

            $("#sendImprestMemoForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {

            document.getElementById("cancelImprestMemoText").innerHTML = documentNumber;
            document.getElementById("MainBody_cancelImprestMemoNo").value = documentNumber;

            $("#cancelImprestMemoForApprovalModal").modal();
        }
    </script>


</asp:Content>
