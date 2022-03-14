<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenTrainingNeedsRequests.aspx.cs" Inherits="HRPortal.OpenTrainingNeedsRequests" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Training Needs Requests</div>
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Date Requested</th>
                        <th>Edit</th>
                        <th>Send/Cancel Approval</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var trainingRequests = nav.Trainingneedsrequests.Where(r => r.Employee_No == employeeNo  && r.Status != "Released");
                        foreach (var myTrainingRequests in trainingRequests)
                        {
                    %>
                    <tr>
                        <td><% =myTrainingRequests.Code %></td>
                        <td><% =myTrainingRequests.Description%></td>
                        <td><% = Convert.ToDateTime(myTrainingRequests.Created_On).ToString("dd/MM/yyyy")%></td>
                        <td>
                            <%
                                if (myTrainingRequests.Status == "Pending")
                                {
                            %>
                             <label class="btn btn-default"><i class="fa fa-pencil"></i>Edit</label>

                            <%   
                                }
                                else if (myTrainingRequests.Status == "Open")
                                {
                            %>
                           <a href="TrainingNeedsRequest.aspx?NeedsRequestNo=<%=myTrainingRequests.Code %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit</a> 
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (myTrainingRequests.Status == "Pending")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=myTrainingRequests.Code %>');"><i class="fa fa-check"></i>Cancel Approval Request</label>
                            <%   
                                }
                                else if (myTrainingRequests.Status == "Open")
                                {
                            %>
                           <label class="btn btn-success" onclick="sendApprovalRequest('<%=myTrainingRequests.Code %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                            <% 
                                }
                            %>
                        </td>

                            <%   

                                }
                            %>
                        </tr>
                </tbody>
            </table>
        </div>
    </div>

  <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("MainBody_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {
            document.getElementById("canceldocname").innerHTML = documentNumber;
            document.getElementById("MainBody_canceldocNo").value = documentNumber;
            $("#cancelImprestMemoForApprovalModal").modal();
        }
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Training Needs For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to send Training Needs No <strong id="approvedocName"></strong> for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendapproval" OnClick="sendapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelImprestMemoForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Training Needs approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="canceldocNo" type="hidden" />
                    Are you sure you want to cancel approval of Training Needs No <strong id="canceldocname"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
