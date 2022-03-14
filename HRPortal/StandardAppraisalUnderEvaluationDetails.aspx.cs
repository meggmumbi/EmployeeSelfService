using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class StandardAppraisalUnderEvaluationDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var pip = nav.EvaluationPIPCategory;
                pipcategory.DataSource = pip;
                pipcategory.DataTextField = "Desription";
                pipcategory.DataValueField = "Code";
                pipcategory.DataBind();

                var nc = nav.EvaluationNeedsCategory;
                needcategory.DataSource = nc;
                needcategory.DataTextField = "Desription";
                needcategory.DataValueField = "Code";
                needcategory.DataBind();
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertStandardAppraisalActivities(List<StandardAppraisal> primarydetails)
        {
            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            bool error = false;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<StandardAppraisal>();
                }
                foreach (StandardAppraisal primarydetail in primarydetails)
                {

                    string entrynumber = primarydetail.entrynumber;
                    string appQty = primarydetail.appraiserQty;
                    string cmts = primarydetail.comments;
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    string docno = primarydetail.docNo;
                    decimal tQty = Convert.ToDecimal(appQty);
                    int tentrynumber = Convert.ToInt32(entrynumber);

                    if (string.IsNullOrEmpty(cmts))
                    {
                        error = true;
                        results = "Kindly input the comments to proceed!";
                    }
                    if (error)
                    {
                        results = "Kindly input the comments to proceed!";
                    }
                    else
                    {
                        String status = Config.ObjNav.FnSubmitStandardAppraisalObj(docno, tentrynumber, tQty, cmts);
                        String[] info = status.Split('*');
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

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertStandardAppraisalPE(List<StandardAppraisal> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<StandardAppraisal>();
                }
                foreach (StandardAppraisal primarydetail in primarydetails)
                {

                    int entrynumber = Convert.ToInt32(primarydetail.docNo);
                    string appQty = primarydetail.appraiserQty;
                    string cmts = primarydetail.comments;
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    string docno = primarydetail.entrynumber;
                    decimal tQty = Convert.ToDecimal(appQty);

                    String status = Config.ObjNav.FnSubmitStandardAppraisalPE(docno, entrynumber, tQty, cmts);
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

        protected void NextToStep2_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=2&&docNo=" + docNo);
        }


        protected void nexttostep3_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=3&&docNo=" + docNo);
        }

        protected void backtostep1_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=1&&docNo=" + docNo);
        }

        protected void backtostep2_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=2&&docNo=" + docNo);
        }

        protected void nexttostep4_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=4&&docNo=" + docNo);
        }

        protected void backtostep3_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=3&&docNo=" + docNo);
        }

        protected void nexttostep5_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=5&&docNo=" + docNo);
        }

        protected void backtostep4_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("StandardAppraisalUnderEvaluationDetails.aspx?step=4&&docNo=" + docNo);
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;

                if (employeeconfirm.Checked == false)
                {
                    flag = true;
                    sms = "The responsible employee should check the confirmation checkbox before submitting the appraisal";
                }
                if (supervisorconfirm.Checked == false)
                {
                    flag = true;
                    sms = "The supervisor should check the confirmation checkbox before submitting the appraisal";
                }

                if (flag)
                {
                    confirmfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.FnSubmitStandardAppraisalConfirmation(docNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        confirmfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("StandardAppraisalReport.aspx?docNo=" + docNo);
                        //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                        //"setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                    }
                    else
                    {
                        confirmfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                confirmfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addEvaluationImprovementPlan_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttype = pipcategory.SelectedValue;
                String tdesc = description.Text;

                if (flag)
                {
                    pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.FnInsertStandardAppraisalPIP(docNo, ttype, tdesc);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        pipFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addtrainingneeds_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttype = needcategory.SelectedValue;
                String tdesc = mDesc.Text;

                if (flag)
                {
                    needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.FnInsertStandardAppraisalTrainigNeeds(docNo, ttype, tdesc);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        needsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removePIPline_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;

                if (flag)
                {
                    pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    int tlineno = Convert.ToInt32(removePIPLineNo.Text);
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.FnRemoveStandardAppraisalPIP(docNo, tlineno);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        pipFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                pipFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeNeedLine_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;

                if (flag)
                {
                    needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    int tlineno = Convert.ToInt32(removeNeedLineNo.Text);
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.FnRemoveStandardAppraisalTrainigNeeds(docNo, tlineno);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        needsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                needsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}