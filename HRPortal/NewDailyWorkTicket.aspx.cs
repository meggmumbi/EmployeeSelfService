using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Configuration;
using System.IO;

namespace HRPortal
{
    public partial class NewDailyWorkTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                getPayPeriods();
                getVehicleLists();
                getDriverLists();
                getTransportRequisitionNo();
                getDrivers();
            }
        }
        public void getPayPeriods()
        {
            var nav = new Config().ReturnNav();
            var venue = nav.PayPeriod.ToList();
            monthdate.DataSource = venue;
            monthdate.DataValueField = "Starting_Date";
            monthdate.DataTextField = "Starting_Date";
            monthdate.DataBind();
        }
        public void getVehicleLists()
        {
            var nav = new Config().ReturnNav();
            var vehicle = nav.FleetVehicleLists.ToList();
                vehiclenumber.DataSource = vehicle;
                vehiclenumber.DataValueField = "Registration_No";
                vehiclenumber.DataTextField = "Registration_No";
                vehiclenumber.DataBind();
        }
        public void getDriverLists()
        {
            var nav = new Config().ReturnNav();
            var driver = nav.FleetDriversList.ToList();
            authorizedBy.DataSource = driver;
            authorizedBy.DataValueField = "Driver";
            authorizedBy.DataTextField = "Driver_Name";
            authorizedBy.DataBind();
        }
        public void getTransportRequisitionNo()
        {
            var nav = new Config().ReturnNav();
            var req = nav.ApprovedFleetRequestsList.ToList();
            requisitionNo.DataSource = req;
            requisitionNo.DataValueField = "Transport_Requisition_No";
            requisitionNo.DataTextField = "Transport_Requisition_No";
            requisitionNo.DataBind();
        }
        public void getDrivers()
        {
            var nav = new Config().ReturnNav();
            var driver = nav.FleetDriversList.ToList();
            driverNo.DataSource = driver;
            driverNo.DataValueField = "Driver";
            driverNo.DataTextField = "Driver_Name";
            driverNo.DataBind();
        }
        //public void getAuthorizer()
        //{
        //    var nav = new Config().ReturnNav();
        //    var driver = nav.FleetDriversList.ToList();
        //    authorizername.DataSource = driver;
        //    authorizername.DataValueField = "Driver";
        //    authorizername.DataTextField = "Driver_Name";
        //    authorizername.DataBind();
        //}

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                //DateTime datetime = DateTime.ParseExact(monthdate.SelectedValue, "dd/MM/yyyy", null);
                //datetime = Convert.ToDateTime(datetime, System.Globalization.CultureInfo.GetCultureInfo("hi-IN").DateTimeFormat);
                string dValue = string.Format("{0:dd-MM-yyyy}", monthdate.SelectedValue);
                String tTicketNo = ticketno.Text.Trim();
                String tPreviousTicketNo = previousticketNo.Text.Trim();
                String tVehicleNo = vehiclenumber.SelectedValue.Trim();
                String tDateclosed = em_EndDate.Text.Trim();
                String tAuthorizedBy = authorizedBy.SelectedValue.Trim();
                DateTime myDateClosed = new DateTime();
                DateTime myMonthdate = new DateTime();
                String message = "";
                Boolean error = false;

                //if (String.IsNullOrEmpty(tTicketNo))
                //{
                //    error = true;
                //    message = "Please enter ticket number";
                //}
                //if (String.IsNullOrEmpty(tPreviousTicketNo))
                //{
                //    error = true;
                //    message = "Please enter previous ticket number";
                //}
                //if (String.IsNullOrEmpty(tVehicleNo))
                //{
                //    error = true;
                //    message = "Please enter vehicle number";
                //}
                try
                {
                    myDateClosed = DateTime.ParseExact(tDateclosed, "dd/mm/yyyy", CultureInfo.InvariantCulture);

                }
                catch
                {
                    //error = true;
                    //message = "Please enter closing date";
                }
                //try
                //{
                //    myMonthdate = DateTime.ParseExact (tMonthdate, "dd/mm/yyyy", null);
                //}
                //catch
                //{
                //    //error = true;
                //    //message = "Please enter month date";
                //}
                //if (String.IsNullOrEmpty(tAuthorizedBy))
                //{
                //    error = true;
                //    message = "Please enter authorizer";
                //}
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String ticketNo = "";
                    Boolean newticketNo = false;
                    try
                    {

                        ticketNo = Request.QueryString["ticketNo"];
                        if (String.IsNullOrEmpty(ticketNo))
                        {
                            ticketNo = "";
                            newticketNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        ticketNo = "";
                        newticketNo = true;
                    }
                    myMonthdate = Convert.ToDateTime(dValue).Date;
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateNewDailyWorkTicket(employeeNo, ticketNo, myMonthdate, tTicketNo, tPreviousTicketNo, tVehicleNo, myDateClosed, tAuthorizedBy);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newticketNo)
                        {
                            ticketNo = info[2];

                        }
                        Response.Redirect("NewDailyWorkTicket.aspx?step=2&&ticketNo=" + ticketNo);
                    }
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Previous_Click(object sender, EventArgs e)
        {
            String ticketNo = Request.QueryString["ticketNo"];
            Response.Redirect("NewDailyWorkTicket.aspx?step=1&&ticketNo=" + ticketNo);
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Daily Work Ticket Card/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String ticketNo = Request.QueryString["ticketNo"];
                            ticketNo = ticketNo.Replace('/', '_');
                            ticketNo = ticketNo.Replace(':', '_');
                            String documentDirectory = filesFolder + ticketNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                            "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //We could not create a directory for your documents

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        Config.navExtender.AddLinkToRecord("Daily Work Ticket Card", ticketNo, filename, "");
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //The document could not be uploaded
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }

        protected void BackToStep2_Click(object sender, EventArgs e)
        {
            String ticketNo = Request.QueryString["ticketNo"];
            Response.Redirect("NewDailyWorkTicket.aspx?step=2&&ticketNo=" + ticketNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String ticketNo = Request.QueryString["ticketNo"];
                String status = Config.ObjNav.SendDailyWorkTicketForApproval(ticketNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addlines_Click(object sender, EventArgs e)
        {
            try
            {
                String tRequisitionNo = requisitionNo.SelectedValue.Trim();
                String trequisitiondate = tr_StartDate.Text.Trim();
                String tDriverno = driverNo.SelectedValue.Trim();
                String tJourneyDetails = journeydetails.Text.Trim();
                String tOildrawn = oildrawn.Text.Trim();
                String tFueldrawn = fueldrawn.Text.Trim();
                String tCashreceiptno = cashreceiptNo.Text.Trim();
                //String tTimeout = em_timeout.Text.Trim();
                //String tTimein = em_timein.Text.Trim();
                String tOpenOdometer = openodometerreading.Text.Trim();
                String tClosingOdometer = closingodometerreading.Text.Trim();
                String tTotalKM = totalkilometers.Text.Trim();
                //String tAuthorizer = authorizername.SelectedValue.Trim();
                //String tAuthorizerGOK = AuthorizedByGOK.Text.Trim();
                //String tDesignation = designation.Text.Trim();
                Decimal yopeinodometer = 0;
                Decimal yclosingodometer = 0;
                Decimal ytotalkm = 0;
                Decimal yoildrawn = 0;
                Decimal yfueldrawn = 0;
                DateTime yrequisitiondate = new DateTime();
                //DateTime ytimein = new DateTime();
                //DateTime ytimeout = new DateTime();
                String message = "";
                Boolean error = false;

                if (String.IsNullOrEmpty(tRequisitionNo))
                {
                    error = true;
                    message = "Please enter requisition number";
                }
                if (String.IsNullOrEmpty(tDriverno))
                {
                    error = true;
                    message = "Please enter driver number";
                }
                try
                {
                    yrequisitiondate = DateTime.ParseExact(trequisitiondate, "dd/mm/yyyy", CultureInfo.InvariantCulture);
                }
                catch
                {
                    error = true;
                    message = "Please enter date";
                }
                //try
                //{
                //    ytimein = DateTime.ParseExact(tTimein, "hh:mm:ss tt", CultureInfo.InvariantCulture);
                //}
                //catch
                //{
                //    //error = true;
                //    //message = "Please enter time in";
                //}
                //try
                //{
                //    ytimeout = DateTime.ParseExact(tTimeout, "hh:mm:ss tt", CultureInfo.InvariantCulture);
                //}
                //catch
                //{
                //    //error = true;
                //    //message = "Please enter time out";
                //}
                try
                {
                    yoildrawn = Convert.ToDecimal(tOildrawn);
                }
                catch
                {
                    error = true;
                    message = "Please enter oil drawn";
                }
                try
                {
                    yfueldrawn = Convert.ToDecimal(tFueldrawn);
                }
                catch
                {
                    error = true;
                    message = "Please enter fuel drawn";
                }
                try
                {
                    yopeinodometer = Convert.ToDecimal(tOpenOdometer);
                }
                catch
                {
                    error = true;
                    message = "Please enter opening odometer reading";
                }
                try
                {
                    yclosingodometer = Convert.ToDecimal(tClosingOdometer);
                }
                catch
                {
                    error = true;
                    message = "Please enter closing odometer reading";
                }
                try
                {
                    ytotalkm = Convert.ToDecimal(tTotalKM);
                }
                catch
                {
                    error = true;
                    message = "Please enter total kilometers";
                }
                if (error)
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String ticketNo = Request.QueryString["ticketNo"];
                    String status = Config.ObjNav.CreateNewDailyWorkTicketLines(ticketNo, tRequisitionNo, yrequisitiondate, tDriverno, tJourneyDetails, yoildrawn, yfueldrawn, yopeinodometer, yclosingodometer, ytotalkm, tCashreceiptno);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Daily Work Ticket Card/";
                String ticketNo = Request.QueryString["ticketNo"];

                String documentDirectory = filesFolder + ticketNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void nextpage_Click(object sender, EventArgs e)
        {
            String ticketNo = Request.QueryString["ticketNo"];
            Response.Redirect("NewDailyWorkTicket.aspx?step=3&&ticketNo=" + ticketNo);
        }

        protected void editdailyticketline_Click(object sender, EventArgs e)
        {
            try
            {
                Decimal tkm = Convert.ToDecimal(editKm.Text.Trim());
                Decimal toil = Convert.ToDecimal(editOil.Text.Trim());
                Decimal tfuel = Convert.ToDecimal(editFuel.Text.Trim());
                String treceipt = editreceiptno.Text.Trim();
                int tlineno = Convert.ToInt32(entryno.Text.Trim());

                String ticketNo = Request.QueryString["ticketNo"];
                String status = Config.ObjNav.FnEditDailyWorkTicketLines(ticketNo, tlineno, tkm, toil, tfuel, treceipt);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {                  
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch(Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeticketline_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = Convert.ToInt32(removeLineNumber.Text.Trim()); 

                String ticketNo = Request.QueryString["ticketNo"];
                String status = Config.ObjNav.FnDeleteDailyTicketLines(ticketNo, tLineNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}