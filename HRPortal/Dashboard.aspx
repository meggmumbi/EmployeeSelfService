<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HRPortal.Dashboard" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav();
    %>
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row" style="width: 98%;">
                    <div class="col-md-6 col-lg-6">
                        <div class="widget">
                            <div class="widget-header">
                                <i class="icon-file"></i>
                                <h3>Welcome: <b><%=Session["name"]%></h3></b>
                            </div>
                             <div runat="server" id="photosize"></div>
                            <div class="widget-content">
                                <div style="width: 100%; display: block; margin: auto;">
                                    <img id="passportimage" runat="server" />
                                </div>
                                <div runat="server" id="documentsfeedback"></div>
                                <button type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target="#myModal">Upload Image</button>
                               <br />
                                
                                <table class="table table-striped table-bordered">

                                    <tbody>
                                        <%

                                            var employees = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                                            foreach (var employee in employees)
                                            {

                                        %>
                                        <tr>
                                            <td><b>Employee Number:</b></td>
                                            <td><%= employee.No %></td>
                                        </tr>
                                        <tr>
                                            <td><b>Name:</b></td>
                                            <td><%= Session["name"] %></td>
                                        </tr>
                                        <tr>
                                            <td><b>ID Number:</b></td>
                                            <td><%= employee.ID_Number %> </td>
                                        </tr>
                                        <tr>
                                            <td><b>Email:</b></td>
                                            <td><%= employee.Company_E_Mail %> </td>
                                        </tr>
                                        <tr>
                                            <td><b>Phone Number:</b></td>
                                            <td><%= employee.Phone_No %> </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>
                                       
                                        <% 
                                             string employeeNo = Convert.ToString(Session["employeeNo"]);
                                            var employeesLeaves = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                                            Decimal leaveBalance = 0;
                                            try
                                            {
                                                foreach (var employee in employeesLeaves)
                                                {
                                                    leaveBalance = Convert.ToDecimal(employee.Leave_Outstanding_Bal);

                                                    break;
                                                }
                                            }
                                            catch (Exception)
                                            {
                                                leaveBalance = 0;
                                            }
                                        %>
                                        <% = leaveBalance %>
                                    </h3>

                                    <p>Outstanding Leave Balance</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-sign-out"></i>
                                </div>
                                <a href="leavebalances.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        
                          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            int openPositions = 0;
                                            var today = DateTime.Today;
                                            var time24 = DateTime.Now.ToString("HH:mm:ss");
                                            DateTime now = DateTime.Now;
                                            DateTime secondschanged = new DateTime(now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second);
                                            var query = nav.AdvertisedVacancies.Where(x => x.Document_Type == "Job Vacancy" && x.Vacancy_Status == "Published" && x.Approval_Status == "Released" && x.Application_Closing_Date >= today && x.Target_Candidate_Source == "Limited-Internal Staff").ToList();
                                            foreach (var openjobs in query)
                                            {
                                                var jobEndDate = Convert.ToDateTime(openjobs.Application_Closing_Date).ToString("MM/dd/yyyy");
                                                TimeSpan time = new TimeSpan(17, 0, 0);
                                                DateTime closingDate = Convert.ToDateTime(jobEndDate) + time;

                                                DateTime TimeNow = new DateTime(now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second);

                                                if (closingDate >= TimeNow)
                                                {
                                                    openPositions++;
                                                }
                                            }
                                        %>
                                        <% = openPositions %>
                                    </h3>

                                    <p>Internal Adverts</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-folder-open"></i>
                                </div>
                                <a href="InternalAdverts.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var imprests = nav.ImprestMemo.Where(r => r.Status == "Released" && r.Requestor == employeeNo && r.Posted == false); ;
                                            int approvedImprestMemos = 0;
                                            try
                                            {
                                                foreach (var imprest in imprests)
                                                {
                                                    approvedImprestMemos++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestMemos = 0;
                                            }
                                        %>
                                        <% = approvedImprestMemos %>
                                    </h3>

                                    <p>Approved Imprest Memo</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="ImprestMemo.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == true && r.Payment_Type == "Imprest");
                                            int approvedImprestRequisitions = 0;
                                            try
                                            {
                                                foreach (var imprest in payments)
                                                {
                                                    approvedImprestRequisitions++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestRequisitions = 0;
                                            }
                                        %>
                                        <% = approvedImprestRequisitions %>
                                    </h3>

                                    <p>Posted Imprest Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="PostedImprestRequisition.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == true && r.Payment_Type == "Surrender");
                                            int approvedImprestSurrenders = 0;
                                            try
                                            {
                                                foreach (var imprest in payments)
                                                {
                                                    approvedImprestSurrenders++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestSurrenders = 0;
                                            }
                                        %>
                                        <% = approvedImprestSurrenders %>
                                    </h3>

                                    <p>Posted Imprest Surrender</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="PostedImprestSurrenders.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                                            int approvedPurchaseReq = 0;
                                            try
                                            {
                                                foreach (var header in headers)
                                                {
                                                    approvedPurchaseReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedPurchaseReq = 0;
                                            }
                                        %>
                                        <% = approvedPurchaseReq %>
                                    </h3>

                                    <p>Approved Purchase Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-shopping-cart"></i>
                                </div>
                                <a href="PurchaseRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Store Requisition" && r.Request_By_No == employeeNo);
                                            int approvedStoreReq = 0;
                                            try
                                            {
                                                foreach (var header in headers)
                                                {
                                                    approvedStoreReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedStoreReq = 0;
                                            }
                                        %>
                                        <% = approvedStoreReq %>
                                    </h3>

                                    <p>Approved Store Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-building"></i>
                                </div>
                                <a href="StoreRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var transportReq = nav.TransportRequisition.Where(r => r.Status == "Approved" && r.Employee_No==employeeNo);
                                            int approvedFleetReq = 0;
                                            try
                                            {
                                                foreach (var header in transportReq)
                                                {
                                                    approvedFleetReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedFleetReq = 0;
                                            }
                                        %>
                                        <% = approvedFleetReq %>
                                    </h3>

                                    <p>Approved Fleet Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-car"></i>
                                </div>
                                <a href="FleetRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="myModal" class="modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Upload your passport Size Photo</h4>
                </div>
                <div class="modal-body">
                    <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Image" OnClick="UPloadImage_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
