using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class DailyWorkTicketRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                loadDrivers();
                loadTimes();
                LoadApprovedTransportRequisition();
                loadFleetVehicles();
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            var emp = "";
            if(Session["employeeNo"] != null)
            {
                emp = Session["employeeNo"].ToString();
            }
            String requisitionNo = "";
            Boolean newRequisition = false;
            try
            {
                requisitionNo = Request.QueryString["requisitionNo"];
                if (String.IsNullOrEmpty(requisitionNo))
                {
                    requisitionNo = "";
                    newRequisition = true;
                }
            }
            catch (Exception)
            {
                newRequisition = true;
                requisitionNo = "";
            }
            
            try
            {

                var status = Config.ObjNav.CreateDailyWorkTicketRequest(Convert.ToString(Session["employeeNo"]),requisitionNo);
                string[] info = status.Split('*');

                if(info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[1];
                    }
                    Response.Redirect("DailyWorkTicketRequest.aspx?step=2&&requisitionNo=" + requisitionNo);


                }
                

            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }

        protected void loadTimes()
        {
            List<String> hours = new List<string>();
            for (int i = 1; i < 13; i++)
            {
                hours.Add(i + "");
            }
            List<String> minutes = new List<string>();
            for (int i = 0; i < 60; i++)
            {
                minutes.Add(i + "");
            }
            List<String> amAndPm = new List<string>();
            amAndPm.Add("AM");
            amAndPm.Add("PM");
            hour.DataSource = hours;
            hour.DataBind();
            minute.DataSource = minutes;
            minute.DataBind();
            amPM.DataSource = amAndPm;
            amPM.DataBind();

            //edthour.DataSource = hours;
            //edthour.DataBind();
            //edtminute.DataSource = minutes;
            //edtminute.DataBind();
            //edtamPM.DataSource = amAndPm;
            //edtamPM.DataBind();

            hour1.DataSource = hours;
            hour1.DataBind();
            minute1.DataSource = minutes;
            minute1.DataBind();
            amPM1.DataSource = amAndPm;
            amPM1.DataBind();

            //edthour1.DataSource = hours;
            //edthour1.DataBind();
            //edtminute1.DataSource = minutes;
            //edtminute1.DataBind();
            //edtamPM1.DataSource = amAndPm;
            //edtamPM1.DataBind();
        }
        protected void loadDrivers()
        {
            // var 
            var nav = new Config().ReturnNav();
            var query = nav.Drivers;

            List<Driver> list = new List<Driver>();
            foreach(var item in query)
            {
                Driver dr = new Driver();
                dr.driver = item.Driver;
                dr.DriverName = item.Driver +" :"+ item.Driver_Name;
                list.Add(dr);
            }
            //drivers.DataSource = list;
            //drivers.DataTextField = "DriverName";
            //drivers.DataValueField = "driver";
            //drivers.DataBind();
        }

        protected void AddDailyWorkTicket_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            var tReq = transportRequisition.SelectedValue;
            
            var txtdateOfRequest = dateOfRequest.Text;
            var txtopenOdometer = openOdometer.Text;
            var txtclosedOdometer = closedOdometer.Text;
            var txttotalKilometres = totalKilometres.Text;
            var txthour1 = hour1.SelectedValue;
            var txtminute1 = minute1.SelectedValue;
            var txtamPM1 = amPM1.SelectedValue;

            var txthour = hour.SelectedValue;
            var txtminute = minute.SelectedValue;
            var txtamPM = amPM.SelectedValue;
            var txtfuelDrawn = fuelDrawn.Text;
            var rNo = string.IsNullOrEmpty(receiptNo.Text) ? "" : receiptNo.Text;
            var fuelD = string.IsNullOrEmpty(oilDrawn.Text) ? "" : oilDrawn.Text;
            if(fuelD == "")
            {
                fuelD = "0";
            }

            int myHour = Convert.ToInt32(txthour1);
            if (txtamPM == "PM")
            {
                myHour += 12;
            }
            else if (myHour == 12)
            {
                myHour = 0;
            }
            int myHour1 = Convert.ToInt32(txthour);
            if (txtamPM == "PM")
            {
                myHour1 += 12;
            }
            else if (myHour == 12)
            {
                myHour1 = 0;
            }
            DateTime timeOut = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, myHour1, Convert.ToInt32(txtminute), 0);
            DateTime timeIn = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, myHour, Convert.ToInt32(txtminute1), 0);
            if (string.IsNullOrEmpty(tReq))
            {
                error = true;
                message = "Please select transport requisition number";

            }
            
            if (string.IsNullOrEmpty(txthour1))
            {
                error = true;
                message = "Please enter time in";
            }
            if (string.IsNullOrEmpty(txthour))
            {
                error = true;
                message = "Please enter time out";
            }
            if (string.IsNullOrEmpty(txtdateOfRequest))
            {
                error = true;
                message = "Please choose  date";
            }
            if (string.IsNullOrEmpty(txtopenOdometer))
            {
                error = true;
                message = "Please enter  open odometer reading";
            }
            if (string.IsNullOrEmpty(txtclosedOdometer))
            {
                error = true;
                message = "Please enter  closed odometer reading";
            }
            if (string.IsNullOrEmpty(txttotalKilometres))
            {
                error = true;
                message = "Please enter  closed total kilo meters";
            }
            if (string.IsNullOrEmpty(txtfuelDrawn))
            {
                error = true;
                message = "Please enter  fuel drawned";
            }
           
            if( error == true)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" +message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {
                try
                {
                    var requisitionNo = Request.QueryString["requisitionNo"];
                    var status = Config.ObjNav.CreateDailyWorkTicketLine(requisitionNo, tReq, "", "", Convert.ToDateTime(txtdateOfRequest), Convert.ToDecimal(txtopenOdometer), Convert.ToDecimal(txtclosedOdometer), Convert.ToDecimal(txttotalKilometres), timeOut, timeIn, Convert.ToDecimal(txtfuelDrawn),rNo,Convert.ToDecimal(fuelD));
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }


                }
                catch (Exception ex)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            

        }
        protected void LoadApprovedTransportRequisition()
        {
            //Approved|Closed
            var empNo = "";
            if(Session["employeeNo"] != null)
            {
                empNo = Session["employeeNo"].ToString();

            }
                var nav = new Config().ReturnNav();
            var query = nav.ApprovedTransportRequisitions.Where(x =>(x.Status== "Approved" || x.Status== "Closed") && x.Driver_Allocated == empNo);
            List<Item> list = new List<Item>();

            foreach( var item in query)
            {
                Item it = new Item();
                it.No = item.Transport_Requisition_No;
                it.Description = item.Transport_Requisition_No + " " + item.Commencement + " " + item.Destination;
                list.Add(it);
            }

            transportRequisition.DataSource = list;
            transportRequisition.DataTextField = "Description";
            transportRequisition.DataValueField = "No";
            transportRequisition.DataBind();

            edtTransportRequisition.DataSource = list;
            edtTransportRequisition.DataTextField = "Description";
            edtTransportRequisition.DataValueField = "No";
            edtTransportRequisition.DataBind();
        }

        protected void loadFleetVehicles()
        {
            var nav = new Config().ReturnNav();
            List<Driver> list = new List<Driver>();
            var query = nav.FleetVehicles;
            foreach(var item in query)
            {
                Driver dr = new Driver();
                dr.driver = item.Registration_No;
                dr.DriverName = item.Registration_No + " " + item.No + " " + item.Description;
                list.Add(dr);


            }
            //vehicleAllocated.DataSource = list;
            //vehicleAllocated.DataTextField = "DriverName";
            //vehicleAllocated.DataValueField = "driver";
            //vehicleAllocated.DataBind();




        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void previous_Click(object sender, EventArgs e)
        {
           string requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("DailyWorkTicketRequest.aspx?step=1&&requisitionNo=" + requisitionNo);

        }

        

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            

            try
            {
                string requisitionNo = Request.QueryString["requisitionNo"];
                var status = Config.ObjNav.SendDailyWorkTicketForApproval(requisitionNo);
                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            string requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("DailyWorkTicketRequest.aspx?step=2&&requisitionNo=" + requisitionNo);

        }

        protected void Unnamed_Click2(object sender, EventArgs e)
        {

        }

        protected void DeleteTicketLine_Click(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(lineNo.Text);
                var requisitionNo = Request.QueryString["requisitionNo"];
                var status = Config.ObjNav.DeleteDailyWorkTicketLine(requisitionNo, id);

                string[] info = status.Split('*');

                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {

                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        protected void editItem_Click(object sender, EventArgs e)
        {
            var treq = edtTransportRequisition.SelectedValue;
            var rDate = edtdateOfRequest.Text;
            var openOdometer = edtopenOdometer.Text;
            var closedOdometer = edtclosedOdometer.Text;
            var tKM = edttotalKilometres.Text;
            var fuelDrawn = edtfuelDrawn.Text;
            var rNo = string.IsNullOrEmpty(edtReceiptNo.Text) ? "" : edtReceiptNo.Text ;

            var oDrawn = string.IsNullOrEmpty(edtOilDrawn.Text) ? "" : edtOilDrawn.Text;

            string message = "";
            Boolean error = false;

            if(string.IsNullOrEmpty(rDate))
            {
                error = true;
                message = "Please enter date of requesting";
            }
            if (string.IsNullOrEmpty(openOdometer))
            {
                error = true;
                message = "Please enter open Odometer reading";
            }
            if (string.IsNullOrEmpty(closedOdometer))
            {
                error = true;
                message = "Please enter closed Odometer reading";
            }
            if (string.IsNullOrEmpty(tKM))
            {
                error = true;
                message = "Please enter total kilometres";
            }
            if (string.IsNullOrEmpty(fuelDrawn))
            {
                error = true;
                message = "Please enter  fuel drawn";
            }
            if(error == true)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" +message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    var requisitionNo = Request.QueryString["requisitionNo"];
                    int id = Convert.ToInt32(editLineNo.Text);
                    var status = Config.ObjNav.UpdateDailyWorkTicketLine(requisitionNo, treq, Convert.ToDateTime(rDate), Convert.ToDecimal(openOdometer), Convert.ToDecimal(closedOdometer), Convert.ToDecimal(tKM), Convert.ToDecimal(fuelDrawn), id,rNo,Convert.ToDecimal(oDrawn));

                    string[] info = status.Split('*');

                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {

                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
        }

        protected void sendForApproval_Click(object sender, EventArgs e)
        {
            string requisitionNo = Request.QueryString["requisitionNo"];

        }

        protected void GoStep3_Click(object sender, EventArgs e)
        {
            string requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("DailyWorkTicketRequest.aspx?step=3&&requisitionNo=" + requisitionNo);


        }

        protected void uploadDocument_Click1(object sender, EventArgs e)
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
                            String imprestNo = Request.QueryString["requisitionNo"];
                            
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                                        Config.navExtender.AddLinkToRecord("Daily Work Ticket Card", imprestNo, filename, "");
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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        
    }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Daily Work Ticket Card/";
                String imprestNo = Request.QueryString["requisitionNo"];
                
                String documentDirectory = filesFolder + imprestNo + "/";
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

            //removeNumber
            //removeWorkType



        }
    }
}