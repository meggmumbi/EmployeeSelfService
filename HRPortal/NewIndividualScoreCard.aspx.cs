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
    public partial class NewIndividualScoreCard : System.Web.UI.Page
    {
        bool ScoreCardEditing = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                var nav = new Config().ReturnNav();
                var cpsplan = nav.CorporateStrategicPlan.Where(r => r.Implementation_Status == "Ongoing" && r.Approval_Status == "Released");
                strategicplanno.DataSource = cpsplan;
                strategicplanno.DataValueField = "Code";
                strategicplanno.DataTextField = "Description";
                strategicplanno.DataBind();

                var annualreportingcodes = nav.AnnualReporingCodes.Where(r => r.Current_Year == true);
                annualreportingcode.DataSource = annualreportingcodes;
                annualreportingcode.DataValueField = "Code";
                annualreportingcode.DataTextField = "Description";
                annualreportingcode.DataBind();
                if (annualreportingcodes != null)
                {
                    var ReportingDescription = string.Empty;
                    foreach (var item in annualreportingcodes)
                    {
                        ReportingDescription = item.Description;
                    }
                    var EmployeeName = Convert.ToString(Session["name"]).ToString();
                     txtdescription.Text = EmployeeName + " " + "PC For" + " " + ReportingDescription;
                }


                var year = annualreportingcode.SelectedValue;
                var workplans = nav.PerfomanceContractHeader.Where(r => r.Document_Type == "Individual Scorecard" && r.Approval_Status == "Released" && r.Score_Card_Type == "Departmental" && r.Annual_Reporting_Code == year);
                List<DropDownItems> resources = new List<DropDownItems>();
                foreach (var workplan in workplans)
                {
                    DropDownItems items = new DropDownItems();
                    items.Code = workplan.No;
                    items.Description = workplan.Responsible_Employee_No + " " + workplan.Employee_Name + " " + workplan.Description;
                    resources.Add(items);
                }
                funcionalworkplan.DataSource = resources;
                funcionalworkplan.DataValueField = "Code";
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataBind();

                string txtstrategicplanno = Convert.ToString(Session["selectedvalue"]);
                if (txtstrategicplanno != "")
                {
                    funcionalworkplan.SelectedValue = txtstrategicplanno;
                }
                string IndividualPCNo = "";
                try
                {
                    IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
                }
                catch (Exception)
                {
                    IndividualPCNo = "";
                }
                if (!string.IsNullOrEmpty(IndividualPCNo))
                {
                    var pc = nav.PerfomanceContractHeader.Where(x => x.No == IndividualPCNo);
                    foreach (var item in pc)
                    {

                        funcionalworkplan.SelectedValue = item.Department_Center_PC_ID;
                        Session["selectedvalue"] = item.No;
                        Session["IndividualCardNo"] = item.No;
                        Session["StrategicPlanNo"] = item.Strategy_Plan_ID;
                        Session["WorkploanNo"] = item.Functional_WorkPlan;
                        Session["annualplan"] = item.Annual_Workplan;
                        Session["directorate"] = item.Directorate;
                        txtdescription.Text = item.Description;
                    }
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertScoreCard(List<PrimaryInitiative> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<PrimaryInitiative>();
                }
                foreach (PrimaryInitiative primarydetail in primarydetails)
                {

                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber);
                    DateTime startdate = new DateTime();
                    string tstartdate = primarydetail.startdate;
                    if (!string.IsNullOrEmpty(tstartdate ))
                    {
                        startdate = DateTime.ParseExact(tstartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    DateTime enddate = new DateTime();
                    string tenddate = primarydetail.enddate;
                    if (!string.IsNullOrEmpty(tenddate))
                    {
                        enddate = DateTime.ParseExact(tenddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    decimal agreedtarget = 0;
                    if (!string.IsNullOrEmpty(primarydetail.agreedtarget))
                    {
                        agreedtarget = Convert.ToDecimal(primarydetail.agreedtarget);
                    }
                    decimal assignedweight = agreedtarget;
                    if (!string.IsNullOrEmpty(primarydetail.assignedweight))
                    {
                        assignedweight = Convert.ToDecimal(primarydetail.assignedweight);
                    }
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var IndividualCardNo = HttpContext.Current.Session["IndividualCardNo"].ToString();
                    String status = Config.ObjNav.FnUpdateObjectiveLinesDetails(IndividualCardNo,entrynumber, startdate, enddate, agreedtarget, assignedweight);
                    String[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        public void apply_Click(object sender, EventArgs e)
        {
            try
            {
                string IndividualPCNo = "";
                try
                {
                    IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
                }
                catch (Exception)
                {
                    IndividualPCNo = "";
                }
                if (string.IsNullOrEmpty(IndividualPCNo))
                {
                    var nav = new Config().ReturnNav();
                    var ReportingDescription = string.Empty;
                    var annualreportingcodes = nav.AnnualReporingCodes.Where(r => r.Current_Year == true);
                    if(annualreportingcodes != null)
                    {

                       foreach(var item in annualreportingcodes)
                        {
                            ReportingDescription = item.Description;
                        }
                    }
                    string tstrategicplanno = strategicplanno.SelectedValue.Trim();
                    string tfuncionalworkplan = funcionalworkplan.SelectedValue.Trim();
                    string tannualreportingcode = annualreportingcode.SelectedValue.Trim();
                    var EmployeeName = Convert.ToString(Session["name"]).ToString();
                    string ttxtdescription = EmployeeName +" "+ "PC For" + " " + ReportingDescription;
                    //txtdescription.Text.Trim();
                    var EmployeeNo = Convert.ToString(Session["employeeNo"]).ToString();
                    if (string.IsNullOrEmpty(ttxtdescription))
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please key in the Description" + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        String status = Config.ObjNav.FnNewIndividualPerformanceContract(EmployeeNo, tstrategicplanno, tfuncionalworkplan, tannualreportingcode, "", ttxtdescription);
                        String[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            Session["selectedvalue"] = tfuncionalworkplan;
                            Session["IndividualCardNo"] = info[2];
                            Session["StrategicPlanNo"] = info[3];
                            Session["WorkploanNo"] = info[4];
                            Session["annualplan"] = info[5];
                            Session["directorate"] = info[6];
                            generalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=" + info[2] + "&&StrategicPlanNo=" + info[3] + "&&WorkploanNo=" + info[4] + "&&annualplan=" + info[5] + "&&directorate=" + info[6]);

                        }
                        else
                        {
                            generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                }
                else
                {
                    var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
                    var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
                    var AnnualPlan = Request.QueryString["annualplan"].ToString();
                    var Directorate = Request.QueryString["directorate"].ToString();
                    Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedCategories(List<Targets> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<Targets>();
                }
                foreach (Targets target in targetNumber)
                {

                    //if (System.Web.HttpContext.Current.Request.QueryString["WorkploanNo"].ToString() != null)
                    //{
                    //    WorkploanNo = System.Web.HttpContext.Current.Request.QueryString["WorkploanNo"].ToString();

                    //}
                    //if (HttpContext.Current.Request.QueryString["StrategicPlanNo"].ToString() != null)
                    //{
                    //    tStrategyPlanId = HttpContext.Current.Request.QueryString["StrategicPlanNo"].ToString();

                    //}
                    //if (HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString() != null)
                    //{
                    //    IndividualCardNo = HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString();

                    //}
                    var WorkploanNo = HttpContext.Current.Session["WorkploanNo"].ToString();
                    var tStrategyPlanId = HttpContext.Current.Session["StrategicPlanNo"].ToString();
                    var IndividualCardNo = HttpContext.Current.Session["IndividualCardNo"].ToString();
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnSubmitSelectedPerformanceContractCategories(tStrategyPlanId, IndividualCardNo, WorkploanNo, InitiativeNumber);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertJDTergets(List<JDTargets> primiarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primiarydetails == null)
                {
                    primiarydetails = new List<JDTargets>();
                }
                foreach (JDTargets JDTarget in primiarydetails)
                {

                    string entrynumber = JDTarget.entrynumber;
                    var tannualtarget = Convert.ToInt32(JDTarget.annualtarget);
                    var tassignedweight = Convert.ToInt32(JDTarget.assignedweight);
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var tworkplan = JDTarget.workplanno;
                    String status = Config.ObjNav.FnInsertJDTargets(entrynumber, tworkplan, tannualtarget, tassignedweight);
                    String[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string submitannualplan(List<initiativeselections> annualNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (annualNumber == null)
                {
                    annualNumber = new List<initiativeselections>();
                }
                foreach (initiativeselections target in annualNumber)
                {
                    //var WorkploanNo = "";
                    //var tStrategyPlanId = "";
                    //var IndividualCardNo = "";
                    //if (HttpContext.Current.Request.QueryString["WorkploanNo"].ToString() != null)
                    //{
                    //    WorkploanNo = HttpContext.Current.Request.QueryString["WorkploanNo"].ToString();

                    //}
                    //if (HttpContext.Current.Request.QueryString["StrategicPlanNo"].ToString() != null)
                    //{
                    //    tStrategyPlanId = HttpContext.Current.Request.QueryString["StrategicPlanNo"].ToString();

                    //}
                    //if (HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString() != null)
                    //{
                    //    IndividualCardNo = HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString();

                    //}
                    var tWorkploanNo = HttpContext.Current.Session["WorkploanNo"].ToString();
                    var tStrategyPlanId = HttpContext.Current.Session["StrategicPlanNo"].ToString();
                    var IndividualCardNo = HttpContext.Current.Session["IndividualCardNo"].ToString();
                    string txtannualNumber = target.annualNumber;
                    var status = Config.ObjNav.FnSubmitSelectedAdditionalInitiatives(tStrategyPlanId, txtannualNumber, IndividualCardNo, tWorkploanNo);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        protected void DeleteSubActity_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Request.QueryString["IndividualCardNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                int tinitiativeEntry = Convert.ToInt32(activityNumber.Text.Trim());
                if (!string.IsNullOrEmpty(activityNumber.Text))
                {
                    String status = Config.ObjNav.FnDeleteIndividualActivities((String)Session["employeeNo"], ScoreCardId, tinitiativeEntry);
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
            }
            catch (Exception t)
            {
                //feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                //  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void DeleteAdditionalSubActity_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Request.QueryString["IndividualCardNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                int tinitiativeEntry = Convert.ToInt32(additionalnumber.Text.Trim());
                string initiativeNumbers = initiativenumber.Text.Trim();
                String status = Config.ObjNav.FnDeleteAdditionalActivities((String)Session["employeeNo"], ScoreCardId, tinitiativeEntry, initiativeNumbers);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedbackdetails.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    feedbackdetails.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                //feedbackdetails.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                //  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string PCNo = "";
                            // Convert.ToString(Session["IndividualCardNo"]);
                            if (HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString() != null)
                            {
                                PCNo = HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString();

                            }
                            string myPCNo = PCNo;
                            PCNo = PCNo.Replace('/', '_');
                            PCNo = PCNo.Replace(':', '_');
                            String documentDirectory = filesFolder + PCNo + "/";
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
                                        Config.navExtender.AddLinkToRecord("Individual Scorecard", myPCNo, filename, "");
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";
                string PCNo = "";
                //Convert.ToString(Session["IndividualCardNo"]);
                if (HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString() != null)
                {
                    PCNo = HttpContext.Current.Request.QueryString["IndividualCardNo"].ToString();

                }
                PCNo = PCNo.Replace('/', '_');
                PCNo = PCNo.Replace(':', '_');
                String documentDirectory = filesFolder + PCNo + "/";
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

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertAdditionalActivities(List<addActivities> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<addActivities>();
                }
                foreach (addActivities primarydetail in primarydetails)
                {

                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber1);
                    DateTime startdate = new DateTime();
                    string tstartdate = primarydetail.startdate1;
                    if (!string.IsNullOrEmpty(tstartdate))
                    {
                        startdate = DateTime.ParseExact(tstartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    DateTime enddate = new DateTime();
                    string tenddate = primarydetail.enddate1;
                    if (!string.IsNullOrEmpty(tenddate))
                    {
                        enddate = DateTime.ParseExact(tenddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    decimal agreedtarget = 0;
                    decimal assignedweight = 0;
                    agreedtarget = primarydetail.agreedtarget1;
                    assignedweight = primarydetail.assignedweight1;
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var IndividualCardNo = HttpContext.Current.Session["IndividualCardNo"].ToString();
                    String status = Config.ObjNav.FnAddAditionalInitiativesTargets(IndividualCardNo,entrynumber, agreedtarget, assignedweight, startdate, enddate);
                    String[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertAdditionalActivities(List<AdditionalInitiatives> primarydetailsData)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetailsData == null)
                {
                    primarydetailsData = new List<AdditionalInitiatives>();
                }
                foreach (AdditionalInitiatives primarydetail in primarydetailsData)
                {
                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber);
                    DateTime startdate = new DateTime();
                    string tstartdate = primarydetail.startdate;
                    if (tstartdate.Length > 1)
                    {
                        startdate = DateTime.ParseExact(tstartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    DateTime enddate = new DateTime();
                    string tenddate = primarydetail.enddate;
                    if (tenddate.Length > 1)
                    {
                        enddate = DateTime.ParseExact(tenddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    decimal agreedtarget = 0;
                    if (!string.IsNullOrEmpty(primarydetail.agreedtarget))
                    {
                        agreedtarget = Convert.ToDecimal(primarydetail.agreedtarget);
                    }
                    decimal assignedweight = 0;
                    if (!string.IsNullOrEmpty(primarydetail.assignedweight))
                    {
                        assignedweight = Convert.ToDecimal(primarydetail.assignedweight);
                    }

                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var IndividualCardNo = HttpContext.Current.Session["IndividualCardNo"].ToString();
                    String status = Config.ObjNav.FnAddAditionalInitiativesTargets(IndividualCardNo,entrynumber, agreedtarget, assignedweight, startdate, enddate);
                    String[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        //[System.Web.Services.WebMethod(EnableSession = true)]
        //public static string InsertJDTergets(List<JDTargets> primiarydetails)
        //{

        //    HtmlGenericControl NewControl = new HtmlGenericControl();
        //    var results = (dynamic)null;
        //    try
        //    {
        //        if (primiarydetails == null)
        //        {
        //            primiarydetails = new List<JDTargets>();
        //        }
        //        foreach (JDTargets JDTarget in primiarydetails)
        //        {

        //            var entrynumber = Convert.ToInt32(JDTarget.entrynumber);
        //            var tannualtarget = Convert.ToInt32(JDTarget.annualtarget);
        //            var tassignedweight = Convert.ToInt32(JDTarget.assignedweight);
        //            var userCode = HttpContext.Current.Session["employeeNo"].ToString();
        //            var tworkplan = JDTarget.workplanno;
        //            String status = Config.ObjNav.FnInsertJDTargets(entrynumber, tworkplan, tannualtarget, tassignedweight);
        //            String[] info = status.Split('*');
        //            results = info[0];
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        results = ex.Message;
        //    }
        //    return results;
        //}

        protected void NextToStep3_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void BackToStep1_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=1&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void NextToStep4_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void BackToStep2_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void NextToStep5_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=5&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void BackToStep3_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=3&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void BackTostep4_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=4&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }

        protected void submitPC_Click(object sender, EventArgs e)
        {
            try
            {
                string IndividualCardNo = Request.QueryString["IndividualCardNo"].ToString();
                String status = Config.ObjNav.FnSendIndividualScorecardApproval(IndividualCardNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    //Response.Redirect("OpenScoreCard.aspx");
                    feedbacks.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedbacks.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                feedbacks.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        //public void GenerateCSPReport(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string IndividualPCNo = Request.QueryString["IndividualCardNo"];
        //        string status = Config.ObjNav.FnGeneratePCReport(IndividualPCNo);
        //        string[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            cspreport.Attributes.Add("src", ResolveUrl(info[2]));
        //        }
        //        else
        //        {
        //            feedbacks.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception t)
        //    {
        //        feedbacks.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}
        protected void print_Click(object sender, EventArgs e)
        {
            string IndividualPCNo = Request.QueryString["IndividualCardNo"];
            Response.Redirect("NewIndividualScoreCardReport.aspx?IndividualCardNo=" + IndividualPCNo);
        }
        protected void printsubindicators_Click(object sender, EventArgs e)
        {
            string IndividualPCNo = Request.QueryString["IndividualCardNo"];
            Response.Redirect("SubIndicatorsReport.aspx?IndividualCardNo=" + IndividualPCNo);
        }
        
    }
}