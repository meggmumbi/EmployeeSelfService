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
    public partial class IndividualScoreCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                loadAnnualReportingCodes();
                loadStrategicPlan();
                loadGoalTemplates();
                loadPerformanceContractHeader();
                loadfunctionalWorkPlan();
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";

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

                var sId = strategyId.SelectedValue;
                var wPlanId = fWorkPlanId.SelectedValue;
                var reportingCode = aReportingCode.Text;
                var templateId = gTemplateId.SelectedValue;
                var designat = designation.Text;
                var grd = grade.Text;
                var evaluationDate = lEvaluationDate.Text;

                if(string.IsNullOrEmpty(sId))
                {
                    error = true;
                    message = "Please select Strategy Plan Id";
                }
                if (string.IsNullOrEmpty(wPlanId))
                {
                    error = true;
                    message = "Please select Functional Work Plan";
                }
                if (string.IsNullOrEmpty(reportingCode))
                {
                    error = true;
                    message = "Please enter Annual Reporting Code";
                }
                if (string.IsNullOrEmpty(templateId))
                {
                    error = true;
                    message = "Please select Goal Template Id";
                }
                if (string.IsNullOrEmpty(designat))
                {
                    error = true;
                    message = "Please enter your designation ";
                }
                if (string.IsNullOrEmpty(evaluationDate))
                {
                    error = true;
                    message = "Please enter Last Evaluation Date ";
                }

                if(error ==false)
                {
                    var status = Config.ObjNav.CreateIndividualPerformanceContract(requisitionNo, Convert.ToString(Session["employeeNo"]), sId, wPlanId, reportingCode, templateId, designat, grd,Convert.ToDateTime( evaluationDate));
                    string[] info = status.Split('*');

                    if(info[0] == "success")
                    {
                        if(newRequisition == true)
                        {
                            requisitionNo = info[1];

                        }
                        
                        Response.Redirect("IndividualScoreCard.aspx?step=2&&requisitionNo=" + requisitionNo);

                    }
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }




            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

           // Response.Redirect("IndividualScoreCard.aspx?step=2");

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {

        }

        protected void GoBackStep2_Click(object sender, EventArgs e)
        {
           var requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("IndividualScoreCard.aspx?step=2&&requisitionNo=" + requisitionNo);
        }

        protected void GoStep3_Click(object sender, EventArgs e)
        {
            var requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("IndividualScoreCard.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            var requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("IndividualScoreCard.aspx?step=1&&requisitionNo=" + requisitionNo);

        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";
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

        }

        protected void loadAnnualReportingCodes()
        {
            var nav = new Config().ReturnNav();
            var query = nav.AnnualReportingCodes;
            foreach(var item in query)
            {
                aReportingCode.Text = item.Code;
            }
        }

        protected void loadStrategicPlan()
        {
            //strategyId
            var nav = new Config().ReturnNav();
            var query = nav.CorporateStrategicPlans;
            strategyId.DataSource = query;
            strategyId.DataTextField = "Code";
            strategyId.DataValueField = "Description";
            strategyId.DataBind();
        }
        protected void loadGoalTemplates()
        {
            //fWorkPlanId
            var nav = new Config().ReturnNav();
            var query = nav.GoalTemplates;
            gTemplateId.DataSource = query;
            gTemplateId.DataTextField = "Code";
            gTemplateId.DataValueField = "Description";
            gTemplateId.DataBind();
        }

        protected void loadfunctionalWorkPlan()
        {
            var nav = new Config().ReturnNav();
            var query = nav.PerfomanceContractHeader.Where(x=>x.Document_Type== "Functional/Operational PC" && x.Approval_Status=="Released");
            fWorkPlanId.DataSource = query;
            fWorkPlanId.DataTextField = "No";
            fWorkPlanId.DataValueField = "Description";
            fWorkPlanId.DataBind();
        }
        protected void loadPerformanceContractHeader()
        {
          var  requisitionNo = "";
            if(Request.QueryString["requisitionNo"] != null)
            {
                requisitionNo = Request.QueryString["requisitionNo"];
            }

            var empNo = "";

            if(Session["employeeNo"] != null)
            {
                empNo = Session["employeeNo"].ToString();
            }

            try
            {
                var nav = new Config().ReturnNav();
                var query = nav.PerfomanceContractHeader.Where(x => x.No == requisitionNo && x.Responsible_Employee_No == empNo);
                foreach (var item in query)
                {
                    strategyId.SelectedValue = item.Strategy_Plan_ID;
                    fWorkPlanId.SelectedValue = item.Functional_WorkPlan;
                    aReportingCode.Text = item.Annual_Reporting_Code;
                    gTemplateId.SelectedValue = item.Goal_Template_ID;
                    designation.Text = item.Designation;
                    grade.Text = item.Grade;
                    lEvaluationDate.Text = Convert.ToDateTime( item.Last_Evaluation_Date).ToString();

                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }

        }

        protected void deleteLine_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeName = Convert.ToString(Session["employeeNo"]);
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.DeleteObjectAndInitiativeLine( requisitionNo, tLineNo, employeeName);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                                        Config.navExtender.AddLinkToRecord("Standard Purchase Requisition", imprestNo, filename, "");
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
    }
}