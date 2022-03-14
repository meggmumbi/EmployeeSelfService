<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ICTHelpDesk.aspx.cs" Inherits="HRPortal.ICTHelpDesk" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

          <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 2 || step < 1)
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
           Send Request to ICT Help Desk
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                        <li class="breadcrumb-item active">Help Desk Request</li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>ICT Issue Category Department:</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="categoryDepartment" OnSelectedIndexChanged="categoryDepartment_SelectedIndexChanged" AutoPostBack="true" />
                    </div>
                    <div class="form-group">
                        <strong>ICT Issue Category:</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="category" />
                    </div>


                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Clear Description of the challenge you are facing:</strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Description" TextMode="MultiLine" Rows="4" />
                    </div>
                </div>
            </div>


        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addICTHelpDeskRequest" OnClick="addICTHelpDeskRequest_Click" OnClientClick="if(this.value === 'Saving...') { return false; } else { this.value = 'Saving...'; }" />
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
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">ICTHelpDesk</a></li>
                        <li class="breadcrumb-item active">ICTHelpDesk Supporting Documents </li>
                    </ol>
                </div>
                </div>
                 <div runat="server" id="Div1"></div>
                  <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%--   <th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                                   <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Training Requisition/";
                       String imprestNo = Request.QueryString["docNo"];
                       imprestNo = imprestNo.Replace('/', '_');
                       imprestNo = imprestNo.Replace(':', '_');
                       String documentDirectory = filesFolder + imprestNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               //String myfile = Convert.ToString(file);
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                       <td><a href="DownLoadFile.aspx?fileName=<%=file.Replace(documentDirectory, "")%>&&docNo=<%=imprestNo %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>    
                      <%-- <td><a href="imprest.aspx?&&myfile=<%=Request.QueryString["url"] %>"></a></td>  --%>               
                   </tr>
                  
                   <%
                                }
                            }
                   }
                   catch (Exception)
                   {
                       
                   }%>
                   
          
                </tbody>
            </table>
            
            </div>
          <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" id="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Request" ID="sendApproval" OnClick="sendApproval_Click"/><div class="clearfix"></div>
        </div>
        </div>
    
    <%
        }
    %>
     <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="Unnamed_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
