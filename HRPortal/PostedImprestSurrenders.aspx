<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PostedImprestSurrenders.aspx.cs" Inherits="HRPortal.PostedImprestSurrenders" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">
            Posted Imprest Surrender
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Surrender No</th>
                        <th>Date</th>
                        <th>Imprest Amount</th>
                        <th>Payee</th>
                        <th>Status</th>
                        <th>Approval Entries</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Payment_Type == "Surrender" && r.Posted==true);
                        foreach (var payment in payments)
                        {
                    %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>

                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td><% =payment.Payee%> </td>
                        <td><% =payment.Status%></td>
                        <td><a href="ImprestSurrenderApproverEntries.aspx?surrenderNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>

                       
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
