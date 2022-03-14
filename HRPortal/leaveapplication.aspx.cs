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
    public partial class leaveapplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                var nav = new Config().ReturnNav();
                var leaveTypes = nav.LeaveTypes;
                leaveType.DataSource = leaveTypes;
                leaveType.DataValueField = "Code";
                leaveType.DataTextField = "Description";
                leaveType.DataBind();
                String leaveNo = "";
                try
                {
                    leaveNo = Request.QueryString["leaveno"];
                    }
                catch (Exception)
                {
                    
                }
                if (!String.IsNullOrEmpty(leaveNo))
                {
                    Boolean exists = false;
                    var leaves = nav.LeaveApplications.Where(r => r.Employee_No == (String)Session["employeeNo"]&&r.Application_Code== leaveNo);
                    foreach (var leave in leaves)
                    {
                        exists = true;
                        leaveType.SelectedValue = leave.Leave_Type;
                        daysApplied.Text = leave.Days_Applied.ToString();
                        String myDate = Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        myDate = myDate.Replace("-", "/");
                        leaveStartDate.Text = myDate;
                        //phoneNumber.Text = leave.Cell_Phone_Number;
                        //emailAddress.Text = leave.E_mail_Address;
                        examDetails.Text = leave.Details_of_Examination;
                        String examDate = Convert.ToDateTime(leave.Date_of_Exam).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        examDate = myDate.Replace("-", "/");
                        dateOfExam.Text = examDate;
                        previousAttempts.Text = leave.Number_of_Previous_Attempts.ToString();
                    }

                    if (!exists)
                    {
                      Response.Redirect("leaveapplication.aspx");  
                    }
                }

            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            String tLeaveType = leaveType.SelectedValue;
            String mAnnualLeaveType = annualLeaveType.SelectedValue;
            String tDaysApplied = daysApplied.Text.Trim();
            String tLeaveStartDate = leaveStartDate.Text.Trim();
            String tPhoneNumber = "";
            String tEmailAddress ="";
            String tExamDetails = examDetails.Text.Trim();
            String tDateOfExam = dateOfExam.Text.Trim();
            String tPreviousAttempts = previousAttempts.Text.Trim();

            if(tLeaveType != "ANNUAL")
            {
                annualLeaveType.Visible = false;

            }

            Boolean error = false;
            int dApplied = 0, pAttempts = 0;
            DateTime lStartDate = new DateTime(),
            dOfExam = new DateTime();
            try
            {
                dApplied = Convert.ToInt32(tDaysApplied);
                if (dApplied < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid number of days applied<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                if (!String.IsNullOrEmpty(tPreviousAttempts))
                {
                    pAttempts = Convert.ToInt32(tPreviousAttempts);
                }
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml =
                    "<div class='alert alert-danger'>Please provide a valid number of previous attempts<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                CultureInfo culture = new CultureInfo("ru-RU");
                lStartDate = DateTime.ParseExact(tLeaveStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);

            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid leave start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                if (!String.IsNullOrEmpty(tDateOfExam))
                {
                    CultureInfo culture = new CultureInfo("ru-RU");
                    dOfExam = DateTime.ParseExact(tDateOfExam, "d/M/yyyy", CultureInfo.InvariantCulture);
                }

            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid exam date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            if (!error)
            {
                try
                {
                    String myLeaveNo = "";
                    try
                    {
                        myLeaveNo = Request.QueryString["leaveno"];
                        myLeaveNo = String.IsNullOrEmpty(myLeaveNo) ? "" : myLeaveNo;
                    }
                    catch (Exception)
                    {
                        myLeaveNo = "";
                    }
                    if(tLeaveType == "ANNUAL")
                    {
                        String status = Config.ObjNav.LeaveApplication(myLeaveNo, (String)Session["employeeNo"], tLeaveType, Convert.ToInt32(mAnnualLeaveType), dApplied,
                         lStartDate, tPhoneNumber, tEmailAddress, tExamDetails, dOfExam, pAttempts);
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        if (info[0] == "success")
                        {
                            String leaveNo = info[2];
                            Response.Redirect("leaveapplication.aspx?leaveno=" + leaveNo + "&step=2");
                        }
                    }
                    else
                    {
                        int annual_leave_type = 0;
                        String status = Config.ObjNav.LeaveApplication(myLeaveNo, (String)Session["employeeNo"], tLeaveType, annual_leave_type, dApplied,
                         lStartDate, tPhoneNumber, tEmailAddress, tExamDetails, dOfExam, pAttempts);
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        if (info[0] == "success")
                        {
                            String leaveNo = info[2];
                            Response.Redirect("leaveapplication.aspx?leaveno=" + leaveNo + "&step=2");
                        }

                    }
                    
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String leaveNo = Request.QueryString["leaveno"];
                String tLeaveNo = leaveNo;
                String status = Config.ObjNav.SendRecordForApproval((String)Session["employeeNo"], tLeaveNo, "leave");
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["leaveNo"];
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
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                            "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again" +
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
                                        Config.navExtender.AddLinkToRecord("Leave Application Card", imprestNo, filename, "");
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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //The document could not be uploaded
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";
                String imprestNo = Request.QueryString["leaveNo"];
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
        }

        protected void Unnamed10_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["leaveno"];
            Response.Redirect("leaveapplication.aspx?step=1&&leaveno=" + imprestNo);
        }

        protected void leaveType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(leaveType.SelectedValue =="ANNUAL")
            {
                annualtypes.Visible = true;
                detailExam.Visible = false;
                dateExam.Visible = false;
                noAttempts.Visible = false;
            }
            else
            {
                annualtypes.Visible = false;
                detailExam.Visible = false;
                dateExam.Visible = false;
                noAttempts.Visible = false;
            }

            if (leaveType.SelectedValue == "EXAM LEAVE")
            {
                detailExam.Visible = true;
                dateExam.Visible = true;
                noAttempts.Visible = true;
            }
            else 
            {
                detailExam.Visible = false;
                dateExam.Visible = false;
                noAttempts.Visible = false;
            }
        }
    }
}