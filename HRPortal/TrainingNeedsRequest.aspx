<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingNeedsRequest.aspx.cs" Inherits="HRPortal.TrainingNeedsRequest" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
        int step = 1;
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
            Training Needs General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Department.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["Department"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Job Title.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["jobTitle"] %></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" class="form-control" placeholder="Please enter description" ID="ndescription"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>



    <% 
        }
        else if (step == 2)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Training Needs Request  
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="LinesFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Need/Gap:</strong>
                        <asp:TextBox runat="server" ID="linedescription" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Identified Through:</strong>
                        <asp:DropDownList runat="server" ID="source" CssClass="form-control select2" AutoPostBack="true">
                            <asp:ListItem Value="0">Appraisal</asp:ListItem>
                            <asp:ListItem Value="1">Government Directive</asp:ListItem>
                            <asp:ListItem Value="2">Other</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Required For:</strong>
                        <asp:DropDownList runat="server" ID="requiredfor" CssClass="form-control select2" AutoPostBack="true">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Academic&Professional Qualifications</asp:ListItem>
                            <asp:ListItem Value="2">Perfoamnce Improvement</asp:ListItem>
                            <asp:ListItem Value="3">Career Development </asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Comments/Justification:</strong>
                        <asp:TextBox runat="server" ID="comments" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Training Category:</strong>
                        <asp:DropDownList runat="server" ID="trainingcategory" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="trainingcategory_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem>Academic Qualifications</asp:ListItem>
                            <asp:ListItem>Professional Qualifications</asp:ListItem>
                            <asp:ListItem>Skills & Competencies</asp:ListItem>
                            <asp:ListItem>Career Developement</asp:ListItem>
                            <asp:ListItem>Performance Improvement</asp:ListItem>
                            <asp:ListItem> Leadership/Management </asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Course:</strong>
                        <asp:DropDownList runat="server" ID="course" CssClass="form-control select2" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Training Needs" ID="addlinedetails" OnClick="submirequest_Click" />
                <div class="clearfix"></div>
            </div>
            <hr />
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Need/Gap</th>
                        <th>Identified Through</th>
                        <th>Required For</th>
                        <th>Comments</th>
                         <th>Category</th>
                         <th>Course</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                        var needrequests = nav.TrainingNeedsLines.Where(r => r.Training_Header_No == NeedsRequestNo);
                        foreach (var request in needrequests)
                        {
                    %>
                    <tr>
                        <td><%=request.Description %></td>
                        <td><%=request.Source %></td>
                        <td><%=request.Required_For %></td>
                        <td><%=request.Comments %></td>
                        <td><%=request.Training_Category %></td>
                        <td><%=request.Course_Name %></td>
                        <td>
                            <label class="btn btn-success" onclick="editNeedsRequest( '<%=request.Entry_No %>', '<%=request.Description %>','<%=request.Source %>','<%=request.Comments %>');"><i class="fa fa-trash-o"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeNeedsRequest('<%=request.Entry_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="sendapproval" OnClick="sendapproval_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
    %>
    <script>
        function removeNeedsRequest(LineNo) {
            document.getElementById("MainBody_removeLineNumber").value = LineNo;
            $("#removeNeedsRequestModal").modal();
        }
    </script>

    <script>
        function editNeedsRequest(entryno, description, source, comments) {
            document.getElementById("MainBody_editDescription").value = description;
            document.getElementById("MainBody_editSource").value = source;
            document.getElementById("MainBody_editComments").value = comments;
            document.getElementById("MainBody_originalNo").value = entryno;
            $("#editNeedsRequestModal").modal();
        }
    </script>

    <div id="removeNeedsRequestModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Needs Request</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the needs request line?</p>
                    <asp:TextBox runat="server" ID="removeLineNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Needs Request" ID="removeneedsrequest" OnClick="removeneedsrequest_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editNeedsRequestModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Training Needs Request</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalNo" type="hidden" />
                    <div class="form-group">
                        <strong>Description</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editDescription" />
                    </div>
                    <div class="form-group">
                        <strong>Source:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" AutoPostBack="true" ID="editSource" Style="width: 570px">
                            <asp:ListItem>Appraisal</asp:ListItem>
                            <asp:ListItem>Government Directive</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                            <asp:ListItem>Career Development</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Comments:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editComments" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Needs Request" ID="editneedsrequest" OnClick="editneedsrequest_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
