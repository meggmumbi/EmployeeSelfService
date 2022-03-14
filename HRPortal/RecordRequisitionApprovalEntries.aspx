<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="RecordRequisitionApprovalEntries.aspx.cs" Inherits="HRPortal.RecordRequisitionApprovalEntries" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Record Requisition Approval Entries
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <table id="example2" class="table table-striped table-bordered">
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
                        <tbody>
                            <%
                                string docNo = Request.QueryString["fileRequestNo"];
                                var leaves = nav.ApprovalEntries.Where(r => r.Document_No == docNo);
                                foreach (var leave in leaves)
                                {
                            %>
                            <tr>
                                <td><%=leave.Sequence_No %> </td>
                                <td><%=leave.Status %> </td>
                                <td><%=leave.Sender_ID %> </td>
                                <td><%=leave.Approver_ID %> </td>
                                <td><%=leave.Amount %> </td>
                                <td><%=Convert.ToDateTime(leave.Due_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=Convert.ToDateTime(leave.Date_Time_Sent_for_Approval).ToString("dd/MM/yyyy") %> </td>
                                <td>
                                    <%
                                        if (leave.Comment == true)
                                        {
                                    %><a class="btn btn-success" href="RecordsRequisitionApprovalComments.aspx?DocumentNo=<%=leave.Document_No %>&&TableNo=<%=leave.Table_ID %>"><i class="fa fa-eye"></i>View Comments</a>
                                    <%
                                        }
                                        else if (leave.Comment == false)
                                        {

                                    %>
                                    <label class="btn btn-danger"><i class="fa fa-times"></i>No Comment</label>

                                    <% 
                                        }
                                    %>                                              

                                </td>
                            </tr>
                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
