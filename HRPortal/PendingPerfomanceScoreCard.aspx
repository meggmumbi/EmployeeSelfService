<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PendingPerfomanceScoreCard.aspx.cs" Inherits="HRPortal.PendingPerfomanceScoreCard" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Pending Approval Individual Performance  ScoreCard</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Strategy Plan</th>
                        <th>Annual Reporting</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Description</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var performancelogs = nav.PerfomanceContractHeader.Where(r => r.Approval_Status == "Pending Approval" && r.Responsible_Employee_No == employeeNo);
                        foreach (var performancelog in performancelogs)
                        {
                    %>
                    <tr>
                        <td><% =performancelog.No %></td>
                        <td><% =performancelog.Strategy_Plan_ID%></td>
                        <td><% =performancelog.Annual_Reporting_Code%></td>
                        <td><% =performancelog.Start_Date%> </td>
                        <td><% =performancelog.End_Date%></td>
                        <td><% =performancelog.Description%></td>
                        <td><% =performancelog.Approval_Status%></td>
                        <td><% =performancelog.Status%></td>
                        <td>
                            <%
                                if (performancelog.Approval_Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=performancelog.No %>');"><i class="fa fa-times"></i>Cancel Approval</label>

                            <%   
                                    }
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
                    <h4 class="modal-title">Send Individual Performance for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="recordToApprove" type="hidden" />
                    Are you sure you want to Send Individual Performance No <strong id="approverecordoNo"></strong>for approval ? 
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
                    <h4 class="modal-title">Cancel Individual Performance for Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approverecordoNo1s" type="hidden" />
                    Are you sure you want to Cancel Individual Performance No <strong id="approverecordoNo1s"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Cancel Approval" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

