using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewPerformanceLogEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                var workplans = nav.PerfomanceContractHeader.Where(x => x.Approval_Status == "Released" && x.Responsible_Employee_No == Convert.ToString(Session["employeeNo"]) && x.Document_Type == "Individual Scorecard").ToList();
                personalscorecardno.DataSource = workplans;
                personalscorecardno.DataValueField = "No";
                personalscorecardno.DataTextField = "Description";
                personalscorecardno.DataBind();

                string ScoreCard = Convert.ToString(Session["ScoreCard"]);
                string StartDate = Convert.ToString(Session["StartDate"]);
                string EndDate = Convert.ToString(Session["EndDate"]);
                if (ScoreCard != "")
                {
                    personalscorecardno.SelectedValue = ScoreCard;
                }
                if (StartDate != "")
                {
                    tr_StartDate.Text = StartDate;
                }
                if (EndDate != "")
                {
                    tr_EndDate.Text = EndDate;
                }
                string PerformanceLogNo = "";
                try
                {
                    PerformanceLogNo = Request.QueryString["PerformanceLogNo"].ToString();
                }
                catch (Exception)
                {
                    PerformanceLogNo = "";
                }
                if (!string.IsNullOrEmpty(PerformanceLogNo))
                {
                    var pc = nav.PerformanceDiaryLog.Where(x => x.No == PerformanceLogNo);
                    foreach (var item in pc)
                    {

                        Session["ScoreCard"] = item.Personal_Scorecard_ID;
                        Session["StartDate"] = item.Activity_Start_Date;
                        Session["EndDate"] = item.Activity_End_Date;
                        Session["PerformanceLogNo"] = item.No;
                        Session["CSPNo"] = item.CSP_ID;
                        Session["ScoreCardNo"] = item.Personal_Scorecard_ID;
                    }
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertTergets(List<PlogsEntries> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<PlogsEntries>();
                }
                foreach (PlogsEntries primarydetail in primarydetails)
                {

                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber);
                    decimal agreedtarget = 0;
                    if (!string.IsNullOrEmpty(primarydetail.agreedtarget))
                    {
                        agreedtarget = Convert.ToDecimal(primarydetail.agreedtarget);
                    }
                    DateTime achievedDate = new DateTime();
                    string tachievedDate = primarydetail.achievedDate;
                    if (!string.IsNullOrEmpty(tachievedDate))
                    {
                        achievedDate = DateTime.ParseExact(tachievedDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    var Comments = primarydetail.allcomments;
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var tPerformanceLogNo = HttpContext.Current.Session["PerformanceLogNo"].ToString();
                    String status = Config.ObjNav.FnUpdatePerformanceTargetLinesDetails(tPerformanceLogNo,entrynumber, agreedtarget, Comments, achievedDate);
                    String[] info = status.Split('*');
                    results = info[0];
                    if (info[0] == "success")
                    {
                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[0];
                    }
                    else
                    {
                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[0];
                    }
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        protected void DeleteActity_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                string tPerformanceLogNo = Convert.ToString(Request.QueryString["PerformanceLogNo"]);
                int tinitiativeEntry = Convert.ToInt32(additionalnumber.Text.Trim());
                string initiativeNumbers = initiativenumber.Text.Trim();
                String status = Config.ObjNav.FnDeletePlogLines(tPerformanceLogNo, tinitiativeEntry, initiativeNumbers);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                //feedbackdetails.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                //  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {

                string tpersonalscorecardno = personalscorecardno.SelectedValue.Trim();
                string tStartDate = tr_StartDate.Text.Trim();
                string tEndDate = tr_EndDate.Text.Trim();
                string ttextdescription = textdescription.Text.Trim();
                DateTime yStartDate = new DateTime();
                DateTime yEndDate = new DateTime();

                try
                {
                    yStartDate = DateTime.ParseExact(tStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch
                {

                }
                try
                {
                    yEndDate = DateTime.ParseExact(tEndDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch
                {

                }
                string PerformanceLogNo = "";
                try
                {
                    PerformanceLogNo = Request.QueryString["PerformanceLogNo"].ToString();
                }
                catch (Exception)
                {
                    PerformanceLogNo = "";
                }
                if (string.IsNullOrEmpty(PerformanceLogNo))
                {
                    String status = Config.ObjNav.FnNewPerformanceLogEntry(Convert.ToString(Session["employeeNo"]), tpersonalscorecardno, yStartDate, yEndDate, ttextdescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["ScoreCard"] = tpersonalscorecardno;
                        Session["StartDate"] = yStartDate;
                        Session["EndDate"] = yEndDate;
                        Session["PerformanceLogNo"] = info[2];
                        Session["CSPNo"] = info[3];
                        Session["ScoreCardNo"] = info[4];
                        generalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("NewPerformanceLogEntry.aspx?step=2&&PerformanceLogNo=" + info[2] + "&&CSPNo=" + info[3] + "&&ScoreCardNo=" + info[4]);
                    }
                    else
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    var tPerformanceLogNo = Request.QueryString["PerformanceLogNo"].ToString();
                    var tCSPNo = Request.QueryString["CSPNo"].ToString();
                    var tScoreCardNo = Request.QueryString["ScoreCardNo"].ToString();
                    Response.Redirect("NewPerformanceLogEntry.aspx?step=2&&PerformanceLogNo=" + tPerformanceLogNo + "&&CSPNo=" + tPerformanceLogNo + "&&ScoreCardNo=" + tScoreCardNo);
                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedCategories(List<Targets> ActivityCategory)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (ActivityCategory == null)
                {
                    ActivityCategory = new List<Targets>();
                }
                foreach (Targets target in ActivityCategory)
                {
                    var tPerformanceLogNo = "";
                    var tStrategicPlanNumber = "";
                    var tScoreCardNumber = "";
                    if (HttpContext.Current.Request.QueryString["PerformanceLogNo"].ToString() != null)
                    {
                        tPerformanceLogNo = HttpContext.Current.Request.QueryString["PerformanceLogNo"].ToString();

                    }
                    if (HttpContext.Current.Request.QueryString["CSPNo"].ToString() != null)
                    {
                        tStrategicPlanNumber = HttpContext.Current.Request.QueryString["CSPNo"].ToString();

                    }
                    if (HttpContext.Current.Request.QueryString["ScoreCardNo"].ToString() != null)
                    {
                        tScoreCardNumber = HttpContext.Current.Request.QueryString["ScoreCardNo"].ToString();

                    }
                    var ttPerformanceLogNo = HttpContext.Current.Session["PerformanceLogNo"].ToString();
                    string InitiativeNumber = target.TargetNumber;
                    //var status = Config.ObjNav.FnSubmitSelectedPLogCategories(tStrategicPlanNumber, tScoreCardNumber, ttPerformanceLogNo, InitiativeNumber);
                    //string[] info = status.Split('*');
                    //NewControl.ID = "feedback";
                    //NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        protected void SubmitPlogs_Click(object sender, EventArgs e)
        {
            try
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-success'>The Performance logs activities have been submitted successfully<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //string PerformanceLogNo = Convert.ToString(Session["PerformanceLogNo"]);
                Response.Redirect("NewPerformanceLogEntry.aspx?step=1");
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Performance Logs Card/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String PlogNo = Convert.ToString(Session["PerformanceLogNo"]);
                            string nPlogNo = PlogNo;
                            PlogNo = PlogNo.Replace('/', '_');
                            PlogNo = PlogNo.Replace(':', '_');
                            String documentDirectory = filesFolder + PlogNo + "/";
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

                                        //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
                                        Config.navExtender.AddLinkToRecord("Performance Logs Card", nPlogNo, filename, "");
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

        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Performance Logs Card/";
                String PlogNo = Convert.ToString(Session["PerformanceLogNo"]);
                PlogNo = PlogNo.Replace('/', '_');
                PlogNo = PlogNo.Replace(':', '_');
                String documentDirectory = filesFolder + PlogNo + "/";
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
        protected void NextToStep3_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewPerformanceLogEntry.aspx?step=3");
        }
        protected void BackToStep1_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewPerformanceLogEntry.aspx?step=1");
        }
        protected void BackToStep2_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewPerformanceLogEntry.aspx?step=2");
        }
    }
}