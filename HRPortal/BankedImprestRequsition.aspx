<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master" CodeBehind="BankedImprestRequsition.aspx.cs" Inherits="HRPortal.BankedImprestRequsition" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">
            Banked Imprest Requisition
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Imprest No</th>
                        <th>Date</th>
                        <th>Imprest Amount</th>
                        <th>Payee</th>
                        <th>Banked Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var banked = string.Empty;
                        var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Payment_Type == "Imprest" && r.Select==true);
                        foreach (var payment in payments)
                        {
                            if(payment.Select == true)
                            {
                                banked = "Yes";
                            }
                            else
                            {
                                banked = "No";
                            }
                    %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td><% =payment.Payee%> </td>
                        <td><% =banked%></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
