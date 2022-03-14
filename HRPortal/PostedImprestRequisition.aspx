<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PostedImprestRequisition.aspx.cs" Inherits="HRPortal.PostedImprestRequisition" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">
            Posted Imprest Requisition
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Imprest No</th>
                        <th>Date</th>
                        <th>Imprest Amount</th>
                        <th>Payee</th>
                        <th>Surrendered</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var surrenderd = string.Empty;
                        var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Payment_Type == "Imprest" && r.Posted==true);
                        foreach (var payment in payments)
                        {
                            if(payment.Surrendered == true)
                            {
                                surrenderd = "Yes";
                            }
                            else
                            {
                                surrenderd = "No";
                            }
                    %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td><% =payment.Payee%> </td>
                        <td><% =surrenderd%></td>
                        <td><% =payment.Status%></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
