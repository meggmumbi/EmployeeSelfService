using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class IndividualScoreCardSubinitiatives : System.Web.UI.Page
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
                var tunitofmeasure = nav.UnitsOfMeasure.ToList();
                unitofmeasure.DataSource = tunitofmeasure;
                unitofmeasure.DataValueField = "Code";
                unitofmeasure.DataTextField = "Description";
                unitofmeasure.DataBind();

                var tdropunitofmeasure = nav.UnitsOfMeasure.ToList();
                dropunitofmeasure.DataSource = tdropunitofmeasure;
                dropunitofmeasure.DataValueField = "Code";
                dropunitofmeasure.DataTextField = "Description";
                dropunitofmeasure.DataBind();
            }
            
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Session["IndividualCardNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                string tsubinitiative = subinitiative.Text.Trim();
                int tpercentage = 0;
                    //Convert.ToInt32(percentage.Text.Trim());
                int tactivitytargets =Convert.ToInt32(activitytargets.Text.Trim());
                string ystartdate = startdate.Text.Trim();
                string yduedate = duedate.Text.Trim();
                DateTime tstartdates = new DateTime();
                DateTime tduedates = new DateTime();
                if (ystartdate.Length > 1)
                {
                    tstartdates = DateTime.ParseExact(ystartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                }
                if (yduedate.Length > 1)
                {
                    tduedates = DateTime.ParseExact(yduedate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                }
                var tunitofmeasure = unitofmeasure.SelectedValue;
                var ttxtsubindicator = txtsubindicator.Text.Trim();
                String status = Config.ObjNav.FnNewIndividualCardSubActivities(ScoreCardId, ActivityNo, tsubinitiative, tpercentage, tactivitytargets, tstartdates, tduedates, tunitofmeasure, ttxtsubindicator);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void Update_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Session["IndividualCardNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                string tsubinitiative = editsubobjective.Text.Trim();
                string selecteddropunitofmeasure = dropunitofmeasure.SelectedValue;
                int tpercentage = 0;
                int tentryNumber = Convert.ToInt32(entryNumber.Text.Trim());
                //Convert.ToInt32(percentage.Text.Trim());
                int tactivitytargets = Convert.ToInt32(editactivitytarget.Text.Trim());
                string ystartdate = editstartdate.Text.Trim();
                string yduedate = editduedate.Text.Trim();
                DateTime tstartdates = new DateTime();
                DateTime tduedates = new DateTime();
                if (ystartdate.Length > 1)
                {
                    tstartdates = DateTime.ParseExact(ystartdate, "mm/dd/yyyy", CultureInfo.InvariantCulture);
                }
                if (yduedate.Length > 1)
                {
                    tduedates = DateTime.ParseExact(yduedate, "mm/dd/yyyy", CultureInfo.InvariantCulture);
                }
                string ttxtsubindicator = editsubindicator.Text.Trim();
                String status = Config.ObjNav.FnUpdateIndividualCardSubActivities(ScoreCardId, ActivityNo, tsubinitiative, tpercentage, tactivitytargets, tstartdates, tduedates, tentryNumber, selecteddropunitofmeasure, ttxtsubindicator);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void deleteSubActity_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Session["IndividualCardNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                int tsubinitiativeEntry = Convert.ToInt32(subactivityEntryNo.Text.Trim());
                String status = Config.ObjNav.FnDeleteIndividualCardSubActivities((String)Session["employeeNo"], ScoreCardId, ActivityNo, tsubinitiativeEntry);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void BackToStep_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualCardNo"].ToString();
            var StrategicPlanNo = Request.QueryString["StrategicPlanNo"].ToString();
            var WorkploanNo = Request.QueryString["WorkploanNo"].ToString();
            var AnnualPlan = Request.QueryString["annualplan"].ToString();
            var Directorate = Request.QueryString["directorate"].ToString();
            Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualCardNo=" + IndividualPCNo + "&&StrategicPlanNo=" + StrategicPlanNo + "&&WorkploanNo=" + WorkploanNo + "&&annualplan=" + AnnualPlan + "&&directorate=" + Directorate);

        }
    }
   
}