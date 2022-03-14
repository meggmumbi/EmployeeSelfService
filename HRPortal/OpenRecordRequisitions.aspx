<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="OpenRecordRequisitions.aspx.cs" Inherits="HRPortal.OpenRecordRequisitions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">Open Record Requisitions</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Date Requested</th>
                        <th>Duration</th>
                        <th>Expected Return Date</th>
                        <th>Status</th>
                        <th>View Approval Entries</th>
                        <th>Send/Cancel Approval</th>
                        <th>View/edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String request = Request.QueryString["fileRequestNo"];
                        var filelines = nav.FileMovementHeader.Where(x => x.Status != "Approved" && x.Account_No == Session["employeeNo"].ToString()).ToList();
                        foreach (var file in filelines)
                        {
                    %>
                    <tr>
                        <td><%=file.No %></td>
                        <td><%=file.Date_Requested %></td>
                        <td><%=file.Duration_Requested %></td>
                        <td><%=file.Expected_Return_Date %></td>
                        <td><%=file.Status %></td>
                        <td><a href="RecordRequisitionApprovalEntries.aspx?fileRequestNo=<%=file.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>

                        <td>
                            <%
                                if (file.Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=file.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                            <%   
                                }
                                else if (file.Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=file.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                            <% 
                                }
                            %>
                        </td>
                        <td><a href="OpenRecordRequisitions.aspx?step=1&&fileRequestNo=<%=file.No %>" class="btn btn-success">View/Edit</a></td>
                    </tr>
                    <%
                        }
                    %>
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
                    <h4 class="modal-title">Send Record Requisition for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="recordToApprove" type="hidden" />
                    Are you sure you want to send Record Requisition No <strong id="approverecordoNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click" />
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
                    <h4 class="modal-title">Cancel Record Requisition for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approverecordoNo1s" type="hidden" />
                    Are you sure you want to Cancel Record Requisition No <strong id="approverecordoNo1s"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Cancel Approval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
