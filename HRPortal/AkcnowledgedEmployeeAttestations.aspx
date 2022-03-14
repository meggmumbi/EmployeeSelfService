<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AkcnowledgedEmployeeAttestations.aspx.cs" Inherits="HRPortal.AkcnowledgedEmployeeAttestations" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">Aknowledged Employee Attestations</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable" id="example1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Policy</th>
                        <th>Policy Name</th>
                        <th>Document Date</th>
                        <th>Policy Goal</th>
                        <th>Employee No.</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <tbody>
                    <%
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var attestations = nav.EmployeeAttestations.Where(r => r.Employee_Signing_Status == "Pending" && r.Employee_No == employeeNo);
                        foreach (var attestation in attestations)
                        {
                    %>
                    <tr>
                        <td><% =attestation.Attestation_No %></td>
                        <td><% =attestation.Policy_No%></td>
                        <td><% =attestation.Policy_Name%></td>
                        <td><% =attestation.Document_Date%> </td>
                        <td><% =attestation.Policy_Goal%></td>
                        <td><% =attestation.Employee_No%></td>
                        <td><% =attestation.Employee_Signing_Status%></td>

                        <%} %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approverecordoNo").innerHTML = documentNumber;
            document.getElementById("MainBody_recordToApprove").value = documentNumber;
            $("#sendFileForApproval").modal();
        }
    </script>
    <script>
        function cancelApprovalRequest(documentNumber) {
            document.getElementById("approverecordoNo1s").innerHTML = documentNumber;
            document.getElementById("MainBody_approverecordoNo1s").value = documentNumber;
            $("#cancelileForApproval").modal();
        }
    </script>
    <div id="sendFileForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Aknowledged Employee Attestations for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="recordToApprove" type="hidden" />
                    Are you sure you want to Aknowledged Employee Attestations No <strong id="approverecordoNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelileForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Aknowledged Employee Attestations for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approverecordoNo1s" type="hidden" />
                    Are you sure you want to Cancel Aknowledged Employee Attestations No <strong id="approverecordoNo1s"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Cancel Approval" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
