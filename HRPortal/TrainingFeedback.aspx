<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingFeedback.aspx.cs" Inherits="HRPortal.TrainingFeedback" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <%
    int step = 1;
    try
    {
        step = Convert.ToInt32(Request.QueryString["step"]);
        if (step>3||step<1)
        {
            step = 1;
        }
    }
    catch (Exception)
    {
        step = 1;
    }
    if (step==1)
    {
        %>

        <div class="panel panel-primary">
        <div class="panel-heading">
            Training Feedback
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
          <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>                    
                    </div>
                </div>
            </div>    
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Department</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["Department"] %></asp:Label>                   
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Application Description</strong>                     
                        <asp:DropDownList runat="server" ID="applicationcode" CssClass="form-control select2" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="applicationcode_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>        
        </div>
        <div class="panel-heading">
            Training Details
        </div>
        <div class="panel-body">
            <div id="Div1" runat="server"></div>
          <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Course Title</label>
                        <asp:TextBox runat="server" ID="coursetitle" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Venue</label>
                        <asp:TextBox runat="server" ID="venue" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
            </div>    
            <div class="row">
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <label class="control-label">Start Date</label>
                        <asp:TextBox runat="server" ID="startdate" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">End Date</label>
                        <asp:TextBox runat="server" ID="enddate" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
            </div>    
            <div class="row">
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <label class="control-label">Justification</label>
                        <asp:TextBox runat="server" ID="justification" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <label class="control-label">No. of Participants</label>
                        <asp:TextBox runat="server" ID="participants" CssClass="form-control" ReadOnly="true"/>
                    </div>
                </div>
            </div>       
        </div>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="NextToStep2" OnClick="NextToStep2_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


                <% 
}else if (step==2)
{
        %>


   <div class="panel panel-primary">
        <div class="panel-heading">
            Training Feedback Lines
            <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>         
        </div>
        <div class="panel-body">
            <div id="feedback" style="display: none"></div>
            <div id="LinesFeedback" runat="server"></div>
            <table id="example1" class="table table-bordered table-striped RatingTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th style="display:none">#</th>
                    <th style="display:none">#</th>
                    <th style="display:none">#</th>
                    <th style="display:none">#</th>
                    <th>Category</th>
                    <th>Rating</th>
                    <th>Comments</th>
                    <th style="display:none">#</th>
                </tr>
                </thead>
<%--                 <tfoot>
                        <tr>                          
                            <th></th>
                            <th></th>
                            <th></th>  
                            <th><button type="submit" class="btn btn-success btnInsertCmps" id="btnAddSubcomponent">Save Training Feedback Details</button></th>                      
                        </tr>
                    </tfoot>--%>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String feedbackNo = Request.QueryString["feedbackNo"];
                    var needrequests = nav.TrainingFeedbackSuggestions.Where(r => r.Training_Application_No == feedbackNo);
                    int counter = 0;
                    string mCategory = "";
                    foreach (var request in needrequests)
                    {
                        mCategory = request.Training_Category;

                       var rat = nav.CategoryRatingScale.Where(x=> x.Category_Code == mCategory).ToList();

                        List<Item> list = new List<Item>();

                        foreach (var item in rat)
                        {
                            Item itm = new Item();
                            itm.Description = item.Rating_Code + "_" + item.Rating_Description;
                            itm.No = item.Rating_Code;
                            list.Add(itm);
                        }

                        ratingItemsD.DataSource = list;
                        ratingItemsD.DataValueField = "No";
                        ratingItemsD.DataTextField = "Description";
                        ratingItemsD.DataBind();

                        counter++;

                        %>
                    <tr>
                        <td style="display:none"><input class="form-control" type="text" value="<%=request.Training_Application_No %>" disabled="disabled" style="width: 5em;"/></td>
                        <td style="display:none"><input class="form-control" type="text" value="<%=request.Entry_No %>" disabled="disabled" style="width: 5em;"/></td>
                        <td style="display:none"><input class="form-control" type="text" value="<%=request.Category %>" disabled="disabled" style="width: 5em;"/></td>                       
                        <td style="display:none"><input class="form-control" type="text" value="<%=request.Category_Description %>" disabled="disabled" style="width: 5em;"/></td>
                        <td><%=counter %></td>                    
                        <td><textarea  disabled="disabled" style="width: 25em; word-wrap: break-word!important;"  id="subcomponent"><%=request.Category_Description %></textarea></td>
                        <td>
                             <select id="ratingItemsD" runat="server" style="width: 15em; height: 3em; word-wrap: break-word!important;" CssClass="form-control select2" name="D1">
                                <option></option>
                             </select>
                        </td>
                        <td><input runat="server" type="text" style="width: 20em; word-wrap: break-word!important;" class="form-control"/></td>
                         <td style="display:none"><input class="form-control" type="text" value="<%=request.Training_Category %>" disabled="disabled" style="width: 5em;"/></td>
                    </tr>
                            <%
                    }

                     %>
                </tbody>
            </table>
                <center>
                <input type="button" id="btnInsertCmps" class="btn btn-success btnInsertCmps" value="Save feedback" />                        
            <div class="clearfix"></div>
        </center>
        </div>
       <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep1" OnClick="backtostep1_Click"/>
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nexttostep3" OnClick="nexttostep3_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step==3)
        {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Attach Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
           <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <strong>Select file to upload:</strong>
                       <asp:FileUpload runat="server" ID="document" CssClass="form-control" style="padding-top: 0px;"/>
                   </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <br/>
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument"/>
                   </div>
               </div>
           </div>
           <table class="table table-bordered table-striped">
               <thead>
               <tr>
                   <th>Document Title</th>
                   <th>Download</th>
                   <th>Delete</th>
               </tr>
               </thead>
               <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Training Feedback/";
                            String feedbackNo = Request.QueryString["feedbackNo"];
                            feedbackNo = feedbackNo.Replace('/', '_');
                            feedbackNo = feedbackNo.Replace(':', '_');
                            String documentDirectory = filesFolder + feedbackNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Training Feedback\<% =feedbackNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
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
            <center>
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Print Feedback Report" ID="printfeedback" OnClick="printfeedback_Click"/>
            </center>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backtostep2" OnClick="backtostep2_Click"/>
             
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit FeedBack" ID="submit" OnClick="submit_Click"/>
            <div class="clearfix"></div>
        </div>
        </div>


        <%
    }
        %>
</asp:Content>