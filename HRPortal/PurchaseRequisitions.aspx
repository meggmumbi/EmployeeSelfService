﻿<%@ Page Title="Purchase Requisitions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseRequisitions.aspx.cs" Inherits="HRPortal.PurchaseRequisitions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content" ContentPlaceHolderID="MainBody" runat="server">
    <%

        string employeeNo = Convert.ToString(Session["employeeNo"]);
        string status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "open" : Request.QueryString["status"];
        string myStatus = "Open";
        var nav = new Config().ReturnNav();
        var headers = nav.PurchaseHeader.Where(r => r.Status != "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
        if (status == "approved")
        {
            myStatus = "Approved";
            headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Purchase Requisitions
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Approval Entries</th>
                        <th>Send/Cancel Approval</th>
                        <th>View/Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        foreach (var header in headers)
                        {
                    %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% =header.Location_Code %></td>
                        <td><% =header.Description%></td>
                        <td><% =header.Status%></td>
                        <td><a href="PurchaseRequisitionsApproverEntries.aspx?requisitionNo=<%=header.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>
                        <td>
                            <%
                                if (header.Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=header.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                            <%   
                                }
                                else if (header.Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=header.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                            <% 
                                }
                            %>
                        </td>
                        <td><a href="PurchaseRequisition.aspx?step=1&&requisitionNo=<%=header.No %>" class="btn btn-success">View/Edit</a></td>
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
                    <h4 class="modal-title">Purchase Requisition <strong id="myRecordId"></strong>Approval Entries</h4>
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

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Purchase Requisition For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden" />
                    Are you sure you want to send Purchase Requisition No <strong id="approveImprestMemoNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelImprestMemoForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Purchase Requisition Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden" />
                    Are you sure you want to cancel approval of  Purchase Requisition No <strong id="cancelImprestMemoText"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
