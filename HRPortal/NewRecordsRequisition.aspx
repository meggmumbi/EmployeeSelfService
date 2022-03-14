<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewRecordsRequisition.aspx.cs" Inherits="HRPortal.NewRecordsRequisition" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <%
        int step = 1;
        String filerequest = "";
        try
        {
            filerequest = Request.QueryString["fileRequestNo"].Trim();
        }
        catch (Exception)
        {

        }
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            New Records Requsition(General Details)
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Account No:</strong>
                        <input type="text" name="UserId" class="form-control" value="<%=Session["employeeNo"] %>" readonly />
                    </div>
                    <div class="form-group">
                        <strong>Account Name:</strong>
                        <input type="text" name="UserId" class="form-control" value="<%=Session["name"] %>" readonly />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Days Requested:</strong>
                        <asp:TextBox runat="server" ID="daysrequested" CssClass="form-control" TextMode="Number" min="1" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addGeneralDetails" OnClick="CreateFileRequest_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            New Records Requsition(File Types)
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>File Class:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="fileclassess" OnSelectedIndexChanged="FileClass_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem Text="--Select File Class--" Value="0" />
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>File Number:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="filenumber" AppendDataBoundItems="true">
                            <asp:ListItem Text="--Select File Number--" Value="0" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>File Purpose/Description:</strong>
                        <asp:TextBox runat="server" ID="filedescription" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                </div>

            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add File" OnClick="AddfileLines_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading">All Requested Files</div>
            <div class="panel-body">
                <table id="example2" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>File Class</th>
                            <th>File Reference</th>
                            <th>File Number</th>
                            <th>File Name</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = new Config().ReturnNav();
                            string requestNumber = Request.QueryString["fileRequestNo"].ToString().Trim();
                            var filelines = nav.FileMovementLine.Where(x => x.Document_No == requestNumber).ToList();
                            foreach (var file in filelines)
                            {
                        %>
                        <tr>
                            <td><%=file.File_Type %></td>
                            <td><%=file.File_Description %></td>
                            <td><%=file.File_Number %></td>
                            <td><%=file.Account_Name %></td>

                            <td>
                                <label class="btn btn-success" onclick="editfilelines('<%=file.Document_No %>','<%=file.Line_No %>','<%=file.File_Number %>', '<%=file.File_Type %>','<%=file.Purpose_Description %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="removeRecordFile('<%=file.Document_No %>','<%=file.Line_No %>','<%=file.File_Description %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendapproval" OnClick="sendApproval_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
    <script>
        function editfilelines(Document_No, Line_No, File_Number, File_Type, Purpose_Description) {
            document.getElementById("MainBody_editFileline").value = Line_No;
            document.getElementById("MainBody_editdocnumber").value = Document_No;
            document.getElementById("MainBody_editFileClass").value = File_Type;
            document.getElementById("MainBody_editFileNumber").value = File_Number;
            document.getElementById("MainBody_editdescription").value = Purpose_Description;
            $("#editRecordsModal").modal();
        }
    </script>
    <script>

        function removeRecordFile(Document_No, Line_No, File_Description) {
            document.getElementById("filetoDeleteName").innerText = File_Description;
            document.getElementById("MainBody_fileDocNumber").value = Document_No;
            document.getElementById("MainBody_lineNumber").value = Line_No;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="editRecordsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Record Requisition</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editFileline" type="hidden" />
                    <asp:TextBox runat="server" ID="editdocnumber" type="hidden" />
                    <div class="form-group">
                        <strong>File Class</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editFileClass" OnSelectedIndexChanged="FileClass_SelectedIndexChanged" AutoPostBack="true" />
                    </div>
                    <div class="form-group">
                        <strong>File Number:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editFileNumber" />
                    </div>

                    <div class="form-group">
                        <strong>Purpose/Descriptions:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Description" ID="editdescription" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit File Requisition" />
                </div>
            </div>

        </div>
    </div>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileDocNumber" type="hidden" />
                    <asp:TextBox runat="server" ID="lineNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="DeleteFile_Onclick" />
                </div>
            </div>

        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').DataTable({
                responsive: true
            });
        });
    </script>
    <script type="text/javascript">
        var date = new Date();
        date.setDate(date.getDate() + 1);
    </script>
    <%
        }
    %>
</asp:Content>
