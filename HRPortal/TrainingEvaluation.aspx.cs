using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TrainingEvaluation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                String employeeno = Convert.ToString(Session["employeeNo"]);
                var myApplicationcode = nav.Trainingrequests.Where(x => x.Employee_No == employeeno).ToList();
                applicationcode.DataSource = myApplicationcode;
                applicationcode.DataValueField = "Code";
                applicationcode.DataTextField = "Description";
                applicationcode.DataBind();

                string ndocNo = "";
                try
                {
                    ndocNo = Request.QueryString["evalNo"];
                }
                catch
                {
                    ndocNo = "";
                }
                if (!string.IsNullOrEmpty(ndocNo))
                {
                    var data = nav.Trainingfeedback.Where(x => x.No == ndocNo);
                    foreach (var item in data)
                    {
                        coursetitle.Text = item.Course_Title;
                        venue.Text = item.Venue;
                        startdate.Text = Convert.ToDateTime(item.Start_DateTime).ToString("d/MM/yyyy");
                        enddate.Text = Convert.ToDateTime(item.End_DateTime).ToString("d/MM/yyyy");
                        justification.Text = item.Course_Justification;
                        participants.Text = Convert.ToString(item.No_of_Participants);
                        applicationcode.Text = item.Application_Code;
                    }
                }
            }
        }
        protected void applicationcode_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                String tApplicationCode = applicationcode.Text;
                Boolean error = false;
                String message = "";
                if (String.IsNullOrEmpty(tApplicationCode))
                {
                    error = true;
                    message = "Please select application code";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String feedbackNo = "";
                    Boolean newfeedbackNo = false;
                    try
                    {

                        feedbackNo = Request.QueryString["evalNo"];
                        if (String.IsNullOrEmpty(feedbackNo))
                        {
                            feedbackNo = "";
                            newfeedbackNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        feedbackNo = "";
                        newfeedbackNo = true;
                    }
                    String employeeno = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateNewTrainingEvaluation(employeeno, feedbackNo, tApplicationCode);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newfeedbackNo)
                        {
                            feedbackNo = info[2];
                            Session["evalNo"] = feedbackNo;
                        }
                        var nav = new Config().ReturnNav();
                        var trainingDetails = nav.Trainingfeedback.Where(x => x.No == feedbackNo).ToList();
                        foreach (var item in trainingDetails)
                        {
                            coursetitle.Text = item.Course_Title;
                            venue.Text = item.Venue;
                            startdate.Text = Convert.ToDateTime(item.Start_DateTime).ToString("d/MM/yyyy");
                            enddate.Text = Convert.ToDateTime(item.End_DateTime).ToString("d/MM/yyyy");
                            justification.Text = item.Course_Justification;
                            participants.Text = Convert.ToString(item.No_of_Participants);
                        }
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

        protected void NextToStep2_Click(object sender, EventArgs e)
        {
            String evalNo = Convert.ToString(Session["evalNo"]);
            Response.Redirect("TrainingEvaluation.aspx?step=2&&evalNo=" + evalNo);
        }

        protected void backtostep1_Click(object sender, EventArgs e)
        {
            String evalNo = Convert.ToString(Session["evalNo"]);
            Response.Redirect("TrainingEvaluation.aspx?step=1&&evalNo=" + evalNo);
        }

        protected void nexttostep3_Click(object sender, EventArgs e)
        {
            String evalNo = Convert.ToString(Session["evalNo"]);
            Response.Redirect("TrainingEvaluation.aspx?step=3&&evalNo=" + evalNo);
        }

        protected void backtostep2_Click(object sender, EventArgs e)
        {
            String evalNo = Convert.ToString(Session["evalNo"]);
            Response.Redirect("TrainingEvaluation.aspx?step=2&&evalNo=" + evalNo);
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                String evalNo = Convert.ToString(Session["evalNo"]);
                String staus = Config.ObjNav.CreateSubmitTrainingFeedback(evalNo);
                String[] info = staus.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addevaluationdetails_Click(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<ComponentModel> cmpitems)
        {
            string tdocNo = "", tLineNo = "", tRating = "", tComment = "";
            string results_0 = (dynamic)null;
            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<ComponentModel>();

                //Loop and insert records.
                foreach (ComponentModel oneitem in cmpitems)
                {
                    tdocNo = oneitem.docNo;
                    tLineNo = oneitem.LineNo;
                    tRating = oneitem.Rating;
                    tComment = oneitem.Comment;

                    if (string.IsNullOrWhiteSpace(tComment))
                    {
                        results_0 = "Please enter comment";
                        return results_0;
                    }
                    int nlineNo = Convert.ToInt32(tLineNo);
                    String status = Config.ObjNav.FnInsertEvaluationLines(tdocNo, nlineNo, tRating, tComment);
                    string[] info = status.Split('*');
                    results_0 = info[0];
                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void printevaluation_Click(object sender, EventArgs e)
        {
            String evalNo = Convert.ToString(Session["evalNo"]);
            Response.Redirect("TrainingEvaluationReport.aspx?evalNo=" + evalNo);
        }
    }
}