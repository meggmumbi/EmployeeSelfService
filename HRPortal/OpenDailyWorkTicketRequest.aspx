<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenDailyWorkTicketRequest.aspx.cs" Inherits="HRPortal.OpenDailyWorkTicketRequest" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Requisition No</th>
                        <th>Vehicle Allocated</th>
                        <th>Total KM Covered</th>
                        <th>Date Of Request</th>
                        <th>Status</th>
                        <th>View Approval Entries</th>
                        <th>Send/Cancel Approval</th>
                        <th>View/Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string ticketNo = Request.QueryString["ticketNo"];
                        var nav = new Config().ReturnNav();
                        var headers = nav.OpenDailyWorkTicket.Where(x => x.Daily_Work_Ticket == ticketNo && (x.Status == "Open" || x.Status == "Pending Approval") && x.Driver_Allocated == Convert.ToString(Session["employeeNo"])).ToList();
                        foreach (var header in headers)
                        {
                    %>
                    <tr>
                        <td><% =header.Daily_Work_Ticket %></td>
                        <td><% =header.Vehicle_Allocated %></td>
                        <td><% =header.Total_Km_s_Covered %></td>
                        <td><% =Convert.ToDateTime( header.Date_of_Request).ToShortDateString()%></td>
                        <td><% =header.Status%></td>
                        <td><a href="StoreRequisitionsApproverEntries.aspx?requisitionNo=<%=header.Daily_Work_Ticket %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>

                        <td>
                            <%
                                if (header.Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=header.Daily_Work_Ticket %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                            <%   
                                }
                                else if (header.Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=header.Daily_Work_Ticket %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                            <% 
                                }
                            %>
                        </td>
                        <td><a href="NewDailyWorkTicket.aspx?step=1&&requisitionNo=<%=header.Daily_Work_Ticket %>" class="btn btn-success">View/Edit</a></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approveWorkTicketNo").innerHTML = documentNumber;
            document.getElementById("MainBody_WorkTicketToApprove").value = documentNumber;

            $("#sendWorkTicketForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {

            document.getElementById("cancelWorkTicketText").innerHTML = documentNumber;
            document.getElementById("MainBody_cancelWorkTicketNo").value = documentNumber;

            $("#cancelWorkTicketForApprovalModal").modal();
        }
    </script>

    <div id="sendWorkTicketForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Work Ticket For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="WorkTicketToApprove" type="hidden" />
                    Are you sure you want to send Work Ticket No <strong id="approveWorkTicketNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendApproval" OnClick="sendApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelWorkTicketForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Work Ticket Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelWorkTicketNo" type="hidden" />
                    Are you sure you want to cancel approval of  Work Ticket No <strong id="cancelWorkTicketText"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelApproval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
