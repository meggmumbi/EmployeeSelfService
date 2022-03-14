<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PurchaseRequisitionsApproverEntries.aspx.cs" Inherits="HRPortal.PurchaseRequisitionsApproverEntries" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
        <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary">
             <div class="panel-heading">
                 My Approver Entries
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
                    String docNo = Request.QueryString["requisitionNo"];
                    var leaves = nav.ApprovalEntries.Where(r => r.Document_No == docNo).ToList();
                    foreach (var leave in leaves)
                    {
                        %>
                       <tr>
                    <td> <%=leave.Sequence_No %> </td>
                    <td> <%=leave.Status %> </td>
                    <td> <%=leave.Sender_ID %> </td>
                     <td> <%=leave.Approver_ID %> </td>
                     <td> <%=leave.Amount %> </td>
                    <td> <%=Convert.ToDateTime(leave.Due_Date).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=Convert.ToDateTime(leave.Date_Time_Sent_for_Approval).ToString("dd/MM/yyyy") %> </td>
                    <td>
                        <%
                            if (leave.Comment == true)
                            {
                            %>
                         <a class="btn btn-success" href="PurchaseRequisitionsApprovalComments.aspx?DocumentNo=<%=leave.Document_No %>&&Approver=<%=leave.Approver_ID %>"><label class="fa fa-eye">View Comment</label></a>
                    <%
                        }
                        else if (leave.Comment == false)
                        {

                               %>
                         <label class="btn btn-danger"('<%=leave.Table_ID %>');"><i class="fa fa-times"></i> No Comment</label>
                        
                        <% 
                            } %>                                              

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
     
<div id="ApprvalModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">   
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Approval Comments</h4>
      </div>
      <div class="modal-body">
              <table class="table table-striped table-bordered"  style="width:100%">
                <thead>
                  <tr>
                    <th>Comment</th>
                    <th> Date And Time</th>            
                  </tr>
                </thead>
                <tbody>
                <asp:TextBox runat="server" ID="txttableId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtapproverId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtworkflowId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtrecordToapprove" type="hidden"/>
                <%
                    string mtableId = Convert.ToString(Session["tableid"]);
                    int ytableid = 0;
                    try
                    {
                        ytableid = Convert.ToInt32(mtableId);
                    }
                    catch
                    { }
                    string mapproverId = Convert.ToString(Session["approver"]);
                    var ncomment = nav.ApprovalCommentLine.Where(x => x.Table_ID == ytableid && x.User_ID == mapproverId && x.Record_ID_to_Approve == "Purchase Header: Purchase Requisition," + docNo);
                    foreach (var tComment in ncomment)
                    {
                        %>
                       <tr>
                    <td> <%=tComment.Comment %> </td>
                    <td> <%=Convert.ToDateTime(tComment.Date_and_Time).ToString("dd/MM/yyyy HH:mm") %> </td>
                  </tr>
                    <%                        
                        }
                     %>                            
                
                </tbody>
              </table>
      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
<script>
    function ViewComment(tableId, approverId, workflowId) {
        document.getElementById("MainBody_txttableId").value = tableId;
        document.getElementById("MainBody_txtapproverId").value = approverId;
        document.getElementById("MainBody_txtworkflowId").value = workflowId;
        document.getElementById("MainBody_txtrecordToapprove").value = workflowId;
        $("#ApprvalModal").modal();
    }
</script>  
</asp:Content>



