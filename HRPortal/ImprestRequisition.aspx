<%@ Page Title="Imprest Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestRequisition.aspx.cs" Inherits="HRPortal.ImprestRequisition" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
        string employeeNo = Convert.ToString(Session["employeeNo"]);
        string status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "open" : Request.QueryString["status"];
        string myStatus = "Open";
        var nav = new Config().ReturnNav();
        var payments = nav.Payments.Where(r => r.Status != "Released" && r.Account_No == employeeNo && r.Payment_Type == "Imprest");
        if (status == "approved")
        {
            myStatus = "Approved";
            payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == false && r.Payment_Type == "Imprest");
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Imprest Requisition
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Imprest No</th>
                        <th>Date</th>
                        <th>Imprest Amount</th>
                        <th>Payee</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        foreach (var payment in payments)
                        {
                    %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>

                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td><% =payment.Payee%> </td>
                        <td><% =payment.Status%></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
