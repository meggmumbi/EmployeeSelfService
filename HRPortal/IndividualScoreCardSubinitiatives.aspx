<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="IndividualScoreCardSubinitiatives.aspx.cs" Inherits="HRPortal.IndividualScoreCardSubinitiatives" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Sub Initiatives
            <span class="pull-right"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Sub Objective/Initiative:</strong>
                        <asp:TextBox runat="server" ID="subinitiative" CssClass="form-control" placeholder="" />
                    </div>
                      <div class="form-group">
                        <strong>Sub Activity Target:</strong>
                        <asp:TextBox runat="server" ID="activitytargets" type="number" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Start Date:</strong>
                        <asp:TextBox runat="server" ID="startdate" CssClass="form-control"  TextMode="Date" />
                    </div>
                    <div class="form-group">
                        <strong>Due Date:</strong>
                        <asp:TextBox runat="server" ID="duedate" CssClass="form-control"  TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Unit of Measure:</strong>
                        <asp:DropDownList runat="server" ID="unitofmeasure" CssClass="form-control" AppendDataBoundItems="true">
                             <asp:ListItem>--Select Unit Of Measure--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Sub-Indicator:</strong>
                        <asp:TextBox runat="server" ID="txtsubindicator" CssClass="form-control"  />
                    </div>
                </div>
                <div class="col-md-12 col-lg-12">
                    <center>
                    <asp:Button runat="server" ID="apply" CssClass="btn btn-success" Text="Submit Details" OnClick="apply_Click"/>
                <div class="clearfix"></div>
                </center>
                </div>
            </div>
        </div>
        <table id="example3" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Activity No</th>
                    <th>Objective/Initiative</th>
                    <th>Sub Targets</th>
                    <th>Unit of Measure</th>
                    <th>Start Date</th>
                    <th>Due Date</th>
                    <th>Sub-Indicator</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String ScoreCardId = Convert.ToString(Request.QueryString["IndividualCardNo"]);
                    string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                    var subactivities = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                    foreach (var subactivity in subactivities)
                    {
                %>
                <tr>
                    <td><%=subactivity.Initiative_No %></td>
                    <td><%=subactivity.Objective_Initiative %></td>
                    <td><%=subactivity.Sub_Targets %></td>
                    <td><%=subactivity.Unit_of_Measure %></td>
                    <td><% =Convert.ToDateTime(subactivity.Start_Date).ToString("dd/MM/yyyy")%></td>
                    <td><% =Convert.ToDateTime(subactivity.Due_Date ).ToString("dd/MM/yyyy")%></td>
                    <td><% =subactivity.Outcome_Perfomance_Indicator%></td>
                    <td> <label class="btn btn-success" onclick="EditSubInitiatives('<%=subactivity.Entry_Number%>','<%=subactivity.Objective_Initiative %>','<%=subactivity.Sub_Targets%>','<%=subactivity.Start_Date%>','<%=subactivity.Due_Date %>','<%=subactivity.Outcome_Perfomance_Indicator %>','<%=subactivity.Unit_of_Measure %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                    <td> <label class="btn btn-danger" onclick="DeleteSubInitiative('<%=subactivity.Entry_Number %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                     

                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
     <div class="panel-footer">
            <asp:Button runat="server" ID="BackToStep" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep_Click"/>
            <span class="clearfix"></span>
        </div>  
    <div id="removeSubActivity" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Individual Score Card Sub Activity</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="subactivityEntryNo" type="hidden" />
                    Are you sure you want to send Remove Sub Activity ? 
                </div>

                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Sub-Activity" OnClick="deleteSubActity_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="editSubInitiativeModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Sub Initiative</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="entryNumber" type="hidden" />
                   
                    <div class="form-group">
                        <strong>Sub Objective/Initiative:</strong>
                        <asp:TextBox runat="server" ID="editsubobjective" CssClass="form-control" placeholder="" />
                    </div>
                      <div class="form-group">
                        <strong>Sub Activity Target:</strong>
                        <asp:TextBox runat="server" ID="editactivitytarget" type="number" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <strong>Start Date:</strong>
                        <asp:TextBox runat="server" ID="editstartdate" CssClass="form-control bootstrapdatepicker" />
                    </div>
                    <div class="form-group">
                        <strong>Due Date:</strong>
                        <asp:TextBox runat="server" ID="editduedate" CssClass="form-control bootstrapdatepicker" />
                    </div>
                    <div class="form-group">
                        <strong>Unit of Measure:</strong>
                        <asp:DropDownList runat="server" ID="dropunitofmeasure" CssClass="form-control" AppendDataBoundItems="true" >
                            <asp:ListItem>--Select Unit Of Measure--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                      <div class="form-group">
                        <strong>Sub-Indicator:</strong>
                        <asp:TextBox runat="server" ID="editsubindicator" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Sub Initiative" OnClick="Update_Click"  />
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.cdnjs.com/ajax/libs/json2/20110223/json2.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"></script>
    <script>
        function EditSubInitiatives(entrynumber, subobjective, activitytarget, startdate, enddate,performanceindicator,unitofmeasure) {
         document.getElementById("MainBody_entryNumber").value = entrynumber;
        document.getElementById("MainBody_editactivitytarget").value = activitytarget;
        document.getElementById("MainBody_editsubobjective").value = subobjective;
        //document.getElementById("MainBody_editduedate").value = enddate;
        //document.getElementById("MainBody_editstartdate").value = startdate;
        document.getElementById("MainBody_dropunitofmeasure").value = unitofmeasure;
        document.getElementById("MainBody_editsubindicator").value = performanceindicator;
        var nowstartdate = startdate.split(' ')[0];
        var nowenddate = enddate.split(' ')[0];
        $('#MainBody_editstartdate').datepicker({ dateFormat: 'mm/dd/yyyy' }, "update").val(nowstartdate);
        $('#MainBody_editduedate').datepicker({ dateFormat: 'mm/dd/yyyy' }, "update").val(nowenddate);
        $("#editSubInitiativeModal").modal();
    }
        function DeleteSubInitiative(entryNumber) {
            document.getElementById("MainBody_subactivityEntryNo").value = entryNumber;
            $("#removeSubActivity").modal();
        }
    </script>
</asp:Content>
