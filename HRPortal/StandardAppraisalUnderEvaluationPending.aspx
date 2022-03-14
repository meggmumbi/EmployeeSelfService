<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardAppraisalUnderEvaluationPending.aspx.cs" Inherits="HRPortal.StandardAppraisalUnderEvaluationPending" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Standard Appraisal Under Evaluation
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Evaluation No</th>
                            <th>Employee Name</th>
                            <th>Description</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Cancel Submission</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceEvaluation.Where(r => r.Employee_No == employeeNo && r.Closed == false && r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Approval_Status == "Released" && r.Document_Type == "Performance Appraisal" && r.Document_Status == "Evaluation");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                                               
                        <td><% =item.No %></td>
                        <td><% =item.Employee_Name%></td>
                        <td><% =item.Description%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_End_Date).ToString("dd/MM/yyyy")%></td>
                         <td><label class="btn btn-danger" onclick="sendApprovalRequest('<%=item.No %>');"><i class="fa fa-times"></i>Cancel Submission</label></td>
                        <%
                            }
                      %>
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
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel submission to supervisor</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to Cancel submission of appraisal No <strong id="approvedocName"></strong> to your supervisor? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Cancel Submission To Supervisor" ID="sendapproval" OnClick="sendapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div> 
</asp:Content>
