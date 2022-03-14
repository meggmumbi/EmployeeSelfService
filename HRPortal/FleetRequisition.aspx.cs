using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class FleetRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                //loadImprestMemo();
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
                var nav = new Config().ReturnNav();
                var employees = nav.Employees;
                List<Employee> allEmployees = new List<Employee>();
                foreach (var eachEmployee in employees)
                {
                    Employee emp = new Employee();
                    emp.EmployeeNo = eachEmployee.No;
                    emp.EmployeeName = eachEmployee.No + " " + eachEmployee.First_Name + " " + eachEmployee.Middle_Name + " " +
                                       eachEmployee.Last_Name;
                    allEmployees.Add(emp);
                }
                employee.DataSource = allEmployees;
                employee.DataValueField = "EmployeeNo";
                employee.DataTextField = "EmployeeName";
                employee.DataBind();

                var itemCategories = nav.ItemCategories.Where(x => x.Parent_Category == "PRODUCTS");
                itemCategory.DataSource = itemCategories;
                itemCategory.DataValueField = "Code";
                itemCategory.DataTextField = "Description";
                itemCategory.DataBind();

                var project = nav.jobs.Where(x => x.Description != "").ToList().ToList().OrderBy(r => r.Description);
                List<Employee> allprojects = new List<Employee>();
                foreach (var projects in project)
                {
                    Employee generalprojects = new Employee();
                    generalprojects.EmployeeNo = projects.No;
                    generalprojects.EmployeeName = projects.No + " " + projects.Description;
                    allprojects.Add(generalprojects);
                }
                //txtprojectnumber.DataSource = allprojects;
                //txtprojectnumber.DataValueField = "EmployeeNo";
                //txtprojectnumber.DataTextField = "EmployeeName";
                //txtprojectnumber.DataBind();

            }
            try
            {
                Boolean exists = false;
                var nav = new Config().ReturnNav();
                String requisitionNo = Request.QueryString["requisitionNo"].Trim();
                String employeeNo = Convert.ToString(Session["employeeNo"]);

                if (!String.IsNullOrEmpty(requisitionNo))
                {
                    var transportRequisitions =
                        nav.TransportRequisition.Where(r => r.Transport_Requisition_No == requisitionNo && r.Employee_No == employeeNo);
                    foreach (var requisition in transportRequisitions)
                    {
                        exists = true;
                        if (!IsPostBack)
                        {
                            from.Text = requisition.Commencement;
                            destination.Text = requisition.Destination;
                            String myDate = Convert.ToDateTime(requisition.Date_of_Trip).ToString("dd/MM/yyyy");
                            //dd/mm/yyyy
                            myDate = myDate.Replace("-", "/");
                            dateofTrip.Text = myDate;
                            journeyRoute.Text = requisition.Journey_Route;
                            purposeOfTrip.Text = requisition.Purpose_of_Trip;
                            // comments.Text = requisition.Comments;
                            noOfDays.Text = requisition.No_of_Days_Requested + "";
                           // imprestNo.SelectedValue = requisition.Approved_Imprest_Memo;
                            //if(requisition.Travel_Type == "Local Travel")
                            //{
                            //    travelType.SelectedValue = "0";
                            //}
                            //else
                            //{
                            //    travelType.SelectedValue = "1";
                            //}
                            //String tTimeOut = requisition.Time_out;
                            //String[] nTime = tTimeOut.Split(':');
                            //try
                            //{
                            //    int mHour = Convert.ToInt32(nTime[0]);
                            //    int mMinute = Convert.ToInt32(nTime[1]);
                            //    if (mHour == 0)
                            //    {
                            //        hour.SelectedValue = "12";
                            //    }
                            //    if (mHour > 11)
                            //    {
                            //        amPM.SelectedValue = "PM";
                            //        if (mHour > 12)
                            //        {
                            //            hour.SelectedValue = (mHour - 12) + "";
                            //        }
                            //    }
                            //    if (mHour <= 12)
                            //    {
                            //        hour.SelectedValue = mHour + "";
                            //    }
                            //    minute.SelectedValue = mMinute + "";
                            // if 00 then its 12 Am

                            //}
                            //catch (Exception)
                            //{

                            //}
                            //String hourOut = hour.SelectedValue;
                            //String minuteOut = minute.SelectedValue;
                            //String amPMOut = amPM.SelectedValue;
                        }

                    }
                    if (!exists)
                    {
                        Response.Redirect("FleetRequisition.aspx");
                    }
                }

            }
            catch (Exception)
            {

            }
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
            if (step == 2)
            {
                if (String.IsNullOrEmpty(Request.QueryString["requisitionNo"]))
                {
                    Response.Redirect("FleetRequisition.aspx");
                }
            }
            if (!IsPostBack)
            {
                try
                {
                    String reqNo = Request.QueryString["requisitionNo"].Trim();
                    String entryNo = Request.QueryString["entry"].Trim();
                    if (!String.IsNullOrEmpty(reqNo))
                    {

                        int myEntry = Convert.ToInt32(entryNo);
                        String status = Config.ObjNav.RemoveStaffFromTravelRequisition(Convert.ToString(Session["employeeNo"]), reqNo, myEntry);
                        String[] info = status.Split('*');
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



                    }
                }
                catch (Exception)
                {
                }
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                String message = "";
                String tFrom = String.IsNullOrEmpty(from.Text.Trim()) ? "" : from.Text.Trim();
                if (String.IsNullOrEmpty(tFrom))
                {
                    error = true;
                    message = "Please specify the Origin/From";
                }
                String tDestination = String.IsNullOrEmpty(destination.Text.Trim()) ? "" : destination.Text.Trim();
                if (String.IsNullOrEmpty(tDestination))
                {
                    error = true;
                    message = "Please specify the Destination";
                }
                String tDateOfTrip = String.IsNullOrEmpty(dateofTrip.Text.Trim()) ? "" : dateofTrip.Text.Trim();
                if (String.IsNullOrEmpty(tDateOfTrip))
                {
                    error = true;
                    message = "Please specify the Date of the Trip";
                }
                String tJourneyRoute = String.IsNullOrEmpty(journeyRoute.Text.Trim()) ? "" : journeyRoute.Text.Trim();
                if (String.IsNullOrEmpty(tJourneyRoute))
                {
                    error = true;
                    message = "Please specify the Journey Route";
                }
                String tNoOfDays = String.IsNullOrEmpty(noOfDays.Text.Trim()) ? "" : noOfDays.Text.Trim();
                String tPurpose = String.IsNullOrEmpty(purposeOfTrip.Text.Trim()) ? "" : purposeOfTrip.Text.Trim();
                if (String.IsNullOrEmpty(tPurpose))
                {
                    error = true;
                    message = "Please specify the Purpose of the Trip";
                }
                String tComments = "";
                decimal ttriphours = 0;
                String requisitionNo = "";
                var imprest = "";
                var tTypes = travelType.SelectedValue;
                var ltriphours = triphours.Text.Trim();
                if (tTypes == "0")
                {
                    travelType.SelectedValue = "0";
                    imprest = "";
                    if (!string.IsNullOrEmpty(ltriphours))
                    {
                        ttriphours = Convert.ToDecimal(ltriphours);
                    }
                }
                else
                {
                    travelType.SelectedValue = "1";
                   // imprest = imprestNo.SelectedValue;
                }
                Decimal nDays = 0;
                //int myHour = Convert.ToInt32(hourOut);
                //if (amPMOut == "PM")
                //{
                //    myHour += 12;
                //}
                //else if (myHour == 12)
                //{
                //    myHour = 0;
                //}
                DateTime travelDate = new DateTime();
                DateTime ttimeoftrips = new DateTime();
                // DateTime timeOut = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, myHour, Convert.ToInt32(minuteOut), 0);
                string txttimeoftrip = timeoftrip.Text.Trim();
                //Session["type"] = tTypes;
                if (tTypes == "0")
                {
                    tTypes = "0";
                    if (!string.IsNullOrEmpty(txttimeoftrip))
                    {
                        ttimeoftrips = DateTime.ParseExact(txttimeoftrip, "HH:mm", CultureInfo.InvariantCulture);
                    }
                }
                else
                {
                    //tTypes = "1";
                    try
                    {
                        nDays = Convert.ToDecimal(tNoOfDays);
                    }
                    catch (Exception)
                    {
                        error = true;
                        message += message.Length > 0 ? "<br/>" : "";
                        message += "Please select a valid value for number of days";
                    }
                    try
                    {
                        travelDate = DateTime.ParseExact(tDateOfTrip, "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch (Exception)
                    {
                        error = true;
                        message = "Please select a valid value for date of trip";
                    }
                    //try
                    //{
                    //    timeoftrips = DateTime.ParseExact(timeoftrip.Text.Trim(), "HH:mm:ss", CultureInfo.InvariantCulture);
                    //}
                    //catch (Exception)
                    //{
                    //    error = true;
                    //    message = "Please select a valid value for date of trip";
                    //}
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.CreateFleetRequisition(Convert.ToString(Session["employeeNo"]),
                        requisitionNo, tFrom, tDestination, travelDate, ttimeoftrips, tJourneyRoute, nDays, tPurpose, tComments, imprest, Convert.ToInt32(tTypes), ttriphours, Convert.ToInt32(tTypes));
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["TravelType"] = Convert.ToInt32(tTypes);
                        Response.Redirect("FleetRequisition.aspx?step=2&&requisitionNo=" + info[2], false);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void previous1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step2&&requisitionNo=" + requisitionNo);
        }
        protected void previous3_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step4&&requisitionNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                String message = "";
                String requisitionNo = Request.QueryString["requisitionNo"];
                string travelType = Convert.ToString(Session["TravelType"]);
                if (travelType == "0")
                {
                    String empNo = Session["employeeNo"].ToString();
                    String status = Config.ObjNav.SendFleetRequisitionApproval(empNo, requisitionNo);
                    String[] info = status.Split('*');
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string[] allFiles = new string[0];
                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
                    String applicationNumber = Request.QueryString["requisitionNo"];
                    applicationNumber = applicationNumber.Replace('/', '_');
                    applicationNumber = applicationNumber.Replace(':', '_');
                    String documentDirectory = filesFolder + applicationNumber;
                    if (Directory.Exists(documentDirectory))
                    {
                        allFiles = Directory.GetFiles(documentDirectory);
                        if (allFiles.Length < 1)
                        {
                            error = true;
                            message = "Please attach supporting documents for Fleet Approval";
                        }
                    }
                    else
                    {
                        error = true;
                        message = "Please attach supporting documents for Fleet Approval";
                    }
                    if (error)
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        String empNo = Session["employeeNo"].ToString();
                        String status = Config.ObjNav.SendFleetRequisitionApproval(empNo, requisitionNo);
                        String[] info = status.Split('*');
                        documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }


        protected void addTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String tEmployee = employee.SelectedValue;
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.AddFleetRequisitionStaff(Convert.ToString(Session["employeeNo"]), requisitionNo, tEmployee);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void addNonStaffMembers_Click(object sender, EventArgs e)
        {
            try
            {
                String tEmployee = employee.SelectedValue;
                int tidnumber = Convert.ToInt32(idnumber.Text.Trim());
                string tnames = names.Text.Trim();
                int tphonumber = Convert.ToInt32(phonumber.Text.Trim());
                string torganization = organization.Text.Trim();
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.AddFleetRequisitioNonStaff(Convert.ToString(Session["employeeNo"]), requisitionNo, tidnumber, tphonumber, torganization, tnames);
                String[] info = status.Split('*');
                linesFeedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback1.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void addLoadDetails_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                String message = "";
                String titemCategory = itemCategory.SelectedValue;
                string ttxtserialNumber = txtserialNumber.Text.Trim();
                string tdescription = description.Text.Trim();
                string tpurpose = purpose.Text.Trim();
                decimal tquantity = Convert.ToDecimal(quantity.Text.Trim());
                bool treturnable = false;
                DateTime treturndate = new DateTime();

                if (returnable.Checked == true)
                {
                    try
                    {
                        treturndate = Convert.ToDateTime(returndate.Text.Trim());
                        treturnable = true;
                    }
                    catch (Exception)
                    {
                        error = true;
                        message += message.Length > 0 ? "<br/>" : "";
                        message += "Please enter a valid value for Return Date";
                    }
                }
                if (treturnable == true)
                {
                    if (String.IsNullOrEmpty(returndate.Text.Trim()))
                    {
                        error = true;
                        message += message.Length > 0 ? "<br/>" : "";
                        message += "Please enter a valid value for Return Date";
                    }
                }
                if (error)
                {
                    generalFeedback1.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string torganization = organization.Text.Trim();
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.AddFleetRequisitioLoadItems(Convert.ToString(Session["employeeNo"]), requisitionNo, titemCategory, tdescription, tquantity, treturndate, tpurpose, treturnable, ttxtserialNumber);
                    String[] info = status.Split('*');
                    generalFeedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                generalFeedback1.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void addFuel_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    int texpensetypes = expensetypes.SelectedIndex ;
            //    string ttxtprojectnumber = txtprojectnumber.Text.Trim();
            //    string ttxtbudgetline = txtbudgetline.Text.Trim();
            //    decimal ttxtamount = Convert.ToDecimal(txtamount.Text.Trim());
            //    string torganization = organization.Text.Trim();
            //    String requisitionNo = Request.QueryString["requisitionNo"];
            //    String status = Config.ObjNav.SubmitVehicleFuelRequestDetails(Convert.ToString(Session["employeeNo"]), requisitionNo, texpensetypes, ttxtprojectnumber, ttxtbudgetline, ttxtamount);
            //    String[] info = status.Split('*');
            //    if (info[0] =="success")
            //    {
            //        fuelfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //    else
            //    {
            //        fuelfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //catch (Exception t)
            //{
            //    fuelfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";

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
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
                String imprestNo = Request.QueryString["requisitionNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
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
        protected void deletefuel_Click(object sender, EventArgs e)
        {
            try
            {
                int tentryNumber = Convert.ToInt32(txtfuel.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.RemoveFuelDetails(requisitionNo, tentryNumber);
                String[] info = status.Split('*');
                fuelfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                fuelfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void deleteStaffClick(object sender, EventArgs e)
        {
            try
            {
                int tentryNumber = Convert.ToInt32(staffid.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.RemoveStaffFromTravelRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tentryNumber);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void deleteStaff_Click(object sender, EventArgs e)
        {
            try
            {
                int tnonstaffnumber = Convert.ToInt32(nonstaffnumber.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.RemoveNonStaffTravelRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tnonstaffnumber);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void deleteLoad_Click(object sender, EventArgs e)
        {
            try
            {
                int tentry = Convert.ToInt32(entrynumber.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.RemoveLoadItemsTravelRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tentry);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        //protected void loadImprestMemo()
        //{
        //    // imprestNo
        //    var nav = new Config().ReturnNav();
        //    var query = nav.ApprovedImprestMemo.Where(x => x.Status == "Released" && x.Requestor == Convert.ToString(Session["employeeNo"]));
        //    List<Item> list = new List<Item>();
        //    foreach (var item in query)
        //    {
        //        Item it = new Item();
        //        it.No = item.No;
        //        it.Description = item.No + " :" + item.Project + " :" + item.Requestor_Name;
        //        list.Add(it);
        //    }
        //    imprestNo.DataSource = list;
        //    imprestNo.DataTextField = "Description";
        //    imprestNo.DataValueField = "No";
        //    imprestNo.DataBind();
        //}

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed3_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=4&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed4_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=5&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed5_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=6&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=4&&requisitionNo=" + requisitionNo);
        }

        protected void travelType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (travelType.SelectedValue == "0")
                {
                    //imprestNo.Visible = false;
                    //ImprestMemo.Visible = false;
                    noOfDays.Visible = false;
                    daysrequested.Visible = false;
                    timeout.Visible = true;
                    timeoftrip.Visible = true;
                    houresoftrip.Visible = true;
                    triphours.Visible = true;
                    //hour.Visible = true;
                    //minute.Visible = true;
                    //amPM.Visible = true;
                }
                else
                {
                    //imprestNo.Visible = false;
                    //ImprestMemo.Visible = false;
                    timeout.Visible = false;
                    timeoftrip.Visible = false;
                    noOfDays.Visible = true;
                    daysrequested.Visible = true;
                    timeout.Visible = false;
                    houresoftrip.Visible = false;
                    triphours.Visible = false;
                    //hour.Visible = false;
                    //minute.Visible = false;
                    //amPM.Visible = false;
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        //protected void imprestselected_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        var nav = new Config().ReturnNav();
        //        var memmoNumber = imprestNo.SelectedValue;
        //        var imprest = nav.ImprestMemo.Where(r => r.No == memmoNumber);
        //        foreach (var myJob in imprest)
        //        {
        //            dateofTrip.Text = Convert.ToString(myJob.Start_Date);
        //            noOfDays.Text = Convert.ToString(myJob.No_of_days);
        //            purposeOfTrip.Text = Convert.ToString(myJob.Imprest_Naration);
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //    }

        //}
        //protected void job_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //    LoadJobTasks();

        //}
        //protected void LoadJobTasks()
        //{
        //    var nav = new Config().ReturnNav();
        //    var myJob = txtprojectnumber.SelectedValue;
        //    var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
        //    txtbudgetline.DataSource = jobTasks;
        //    txtbudgetline.DataValueField = "Job_Task_No";
        //    txtbudgetline.DataTextField = "Description";
        //    txtbudgetline.DataBind();
        //}
    }
}