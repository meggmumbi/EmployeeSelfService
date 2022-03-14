<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ImprestSurenderComments.aspx.cs" Inherits="HRPortal.ImprestSurenderComments" %>

<%@ Import Namespace="HRPortal" %>
<asp:content id="Content2" contentplaceholderid="MainBody" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Approver Comments
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <table id="example2" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Approver</th>
                                <th>Comment(s)</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                string docNo = Request.QueryString["DocumentNo"];
                                string RecordId = "Payments:" + docNo;
                                var leaves = nav.ApprovalCommentLine.Where(r => r.Record_ID_to_Approve == RecordId).ToList();
                                foreach (var leave in leaves)
                                {
                            %>
                            <tr>
                                <td><%=leave.User_ID %> </td>
                                <td><%=leave.Comment %> </td>
                                <td><%=leave.Date_and_Time %> </td>
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
</asp:content>
