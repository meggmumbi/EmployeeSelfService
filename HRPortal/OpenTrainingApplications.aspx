<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenTrainingApplications.aspx.cs" Inherits="HRPortal.OpenTrainingApplications" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Open Training Applications
            </div>
            <div class="panel-body">
                <div runat="server" id="linesfeedback"></div>
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Location</th>
                            <th>Provider</th>
                            <th>Duration</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Approvals</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody> 
                     <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.Trainingrequests.Where(r => r.Employee_No == employeeNo && r.Status != "Approved" && r.Status != "Rejected");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                                               
                        <td><% =item.Description %></td>
                        <td><% =item.Location%></td>
                        <td><% =item.Provider_Name%></td>
                         <td><% =item.Duration%></td>
                        <td><% = Convert.ToDateTime(item.Start_DateTime).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.End_DateTime).ToString("dd/MM/yyyy")%></td>
                        <td>
                            <%
                                if (item.Status == "Pending")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=item.Code %>');"><i class="fa fa-times"></i>Cancel Approval</label>

                            <%   
                                }
                                else if (item.Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=item.Code%>');"><i class="fa fa-check"></i>Send Approval</label>
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (item.Status == "Pending")
                                {
                            %>
                            <label class="btn btn-default"><i class="fa fa-times"></i>Edit Application</label>

                            <%   
                                }
                                else if (item.Status == "Open")
                                {
                            %>
                           <a href="TrainingApplication.aspx?docNo=<%=item.Code %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit Application</a> 
                            <% 
                                }
                            %>
                        </td>
                        <%
                            }
                      %>
                    </tbody>
                </table>
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
                    <h4 class="modal-title">Send Training Application For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden" />
                    Are you sure you want to send Training Application No <strong id="approveImprestMemoNo"></strong>for approval ? 
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
                    <h4 class="modal-title">Cancel Training Application Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden" />
                    Are you sure you want to cancel approval of  Training Application No <strong id="cancelImprestMemoText"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
