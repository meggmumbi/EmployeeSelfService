using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TrainingFeedback : System.Web.UI.Page
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
                    ndocNo = Request.QueryString["feedbackNo"];
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

                        feedbackNo = Request.QueryString["feedbackNo"];
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
                    String status = Config.ObjNav.CreateNewTrainingFeedback(employeeno, feedbackNo, tApplicationCode);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newfeedbackNo)
                        {
                            feedbackNo = info[2];
                            Session["feedbackNo"] = feedbackNo;
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
            String feedbackNo = Convert.ToString(Session["feedbackNo"]);
            Response.Redirect("TrainingFeedback.aspx?step=2&&feedbackNo=" + feedbackNo);
        }

        //protected void addlinedetails_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        int tcategory = category.SelectedIndex;
        //        String trating = rating.Text.Trim();
        //        String tcomments = comments.Text.Trim();

        //        String feedbackNo = Convert.ToString(Session["feedbackNo"]);
        //        String staus = Config.ObjNav.CreateTrainingFeedbackLines(feedbackNo, tcategory, trating, tcomments);
        //        String[] info = staus.Split('*');
        //        if (info[0] == "success")
        //        {
        //            LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {
        //            LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception m)
        //    {
        //        LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        protected void backtostep1_Click(object sender, EventArgs e)
        {
            String feedbackNo = Convert.ToString(Session["feedbackNo"]);
            Response.Redirect("TrainingFeedback.aspx?step=1&&feedbackNo=" + feedbackNo);
        }

        protected void nexttostep3_Click(object sender, EventArgs e)
        {
            String feedbackNo = Convert.ToString(Session["feedbackNo"]);
            Response.Redirect("TrainingFeedback.aspx?step=3&&feedbackNo=" + feedbackNo);
        }

        protected void backtostep2_Click(object sender, EventArgs e)
        {
            String feedbackNo = Convert.ToString(Session["feedbackNo"]);
            Response.Redirect("TrainingFeedback.aspx?step=2&&feedbackNo=" + feedbackNo);
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                String feedbackNo = Convert.ToString(Session["feedbackNo"]);
                String staus = Config.ObjNav.CreateSubmitTrainingFeedback(feedbackNo);
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

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<ComponentModel> cmpitems)
        {
            string tdocNo = "", tLineNo = "", tRating = "", tComment = "", tCategory = "", tCategoryDesc = "", ttrainingcategory;
            string results_0 = (dynamic)null;
            int category = 0;
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
                    tCategory = oneitem.CategoryCode;
                    tCategoryDesc = oneitem.CategoryDescription;
                    ttrainingcategory = oneitem.TrainingCategory;

                    if (string.IsNullOrWhiteSpace(tComment))
                    {
                        results_0 = "Please enter comment";
                        return results_0;
                    }

                    if (tCategory == "Course Content")
                    {
                        category = 0;
                    }
                    if (tCategory == "Course Trainers")
                    {
                        category = 1;
                    }
                    if (tCategory == "Course Venue")
                    {
                        category = 2;
                    }
                    if (tCategory == "General Observations")
                    {
                        category = 3;
                    }

                    int nlineNo = Convert.ToInt32(tLineNo);
                    String status = Config.ObjNav.CreateTrainingFeedbackLines(tdocNo, nlineNo, tRating, tComment, category, tCategoryDesc, ttrainingcategory);
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

        protected void printfeedback_Click(object sender, EventArgs e)
        {
            String feedbackNo = Convert.ToString(Session["feedbackNo"]);
            Response.Redirect("TrainingFeedbackReport.aspx?feedbackNo=" + feedbackNo);
        }
    }
}