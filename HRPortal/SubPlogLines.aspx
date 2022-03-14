<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubPlogLines.aspx.cs" Inherits="HRPortal.SubPlogLines" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:content id="Content2" contentplaceholderid="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Sub Plog Lines
            <span class="pull-right"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
                 <table id="example5" class="table table-bordered table-striped  PlogsLines">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Initiative No</th>
                            <th>Sub-Initiative No</th>
                            <th>Objective/Initiative </th>
                            <th>Target</th>
                            <th>Achieved Target</th>
                            <th>Comments</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            string employeeNo5 = Convert.ToString(Session["employeeNo"]);
                            var tInitiativeNo = Request.QueryString["InitiativeNo"];
                            var tPlogNumber = Request.QueryString["PlogNumber"];
                            var nav = new Config().ReturnNav();
                            var jobs5 = nav.SubPlogLines.Where(x => x.Initiative_No == tInitiativeNo && x.Personal_Scorecard_ID == tPlogNumber).ToList();
                            foreach (var jobs in jobs5)
                            {
                        %>
                        <tr>
                            <td><% =jobs.EntryNo %></td>
                            <td><% =jobs.Initiative_No%></td>
                            <td><% =jobs.Sub_Initiative_No%></td>
                            <td><% =jobs.Description%></td>
                             <td><% =jobs.Target_Qty%></td>
                            <td><input type="number" id="txtannualtarget"  value="<%=jobs.Achieved_Target %>" /></td>
                            <td><input type="number" id="txtassignedweight"  value="<%=jobs.Comments %>"></td>
                            <td><label class="btn btn-danger" onclick="removeadditionalactivity('<%=jobs.EntryNo %>','<%=jobs.Initiative_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                 <center>
                    <input type="button" id="btn_SaveSubPlogLines" class="btn btn-success btn_SaveSubPlogLines" value="Save Sub Plogs" />      
                    <div class="clearfix"></div>
                </center>
        </div>  
    </div>
    </asp:content>
