using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TrainingNeedsRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                string ndocNo = "";
                try
                {
                    ndocNo = Request.QueryString["NeedsRequestNo"];
                }
                catch
                {
                    ndocNo = "";
                }
                if (!string.IsNullOrEmpty(ndocNo))
                {
                    var data = nav.Trainingneedsrequests.Where(x => x.Code == ndocNo);
                    foreach (var item in data)
                    {
                        ndescription.Text = item.Description;
                    }
                }
            }
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                String message = "";
                string tDescription = ndescription.Text.Trim();
                if (String.IsNullOrEmpty(tDescription))
                {
                    error = true;
                    message = "Please enter description";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String NeedsRequestNo = "";
                    Boolean newNeedsRequestNo = false;
                    try
                    {

                        NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                        if (String.IsNullOrEmpty(NeedsRequestNo))
                        {
                            NeedsRequestNo = "";
                            newNeedsRequestNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        NeedsRequestNo = "";
                        newNeedsRequestNo = true;
                    }
                    String empno = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateNewTrainingRequest(empno, NeedsRequestNo, tDescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newNeedsRequestNo)
                        {
                            NeedsRequestNo = info[2];

                        }
                        Response.Redirect("TrainingNeedsRequest.aspx?step=2&&NeedsRequestNo=" + NeedsRequestNo);
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

        protected void submirequest_Click(object sender, EventArgs e)
        {
            try
            {
                String message = "";
                Boolean error = false;
                String tdescription = linedescription.Text.Trim();
                //String tRequired = requiredfor.SelectedValue;
                //String tSource = source.SelectedValue;
                String tComment = comments.Text.Trim();
                int mRequired = requiredfor.SelectedIndex;
                int mSource = source.SelectedIndex;
                int mCategory = trainingcategory.SelectedIndex;
                string mCourse = course.SelectedValue;
                if (String.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please enter description";
                }
                if (String.IsNullOrEmpty(tComment))
                {
                    error = true;
                    message = "Please enter comment";
                }
                if (error)
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                    String empNo = Request.QueryString["employeeNo"];
                    String status = Config.ObjNav.CreateNewTrainingNeedsLines(NeedsRequestNo, tdescription, mSource, tComment, mRequired, mCategory, mCourse);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String needsNo = Request.QueryString["NeedsRequestNo"];
                String status = Config.ObjNav.SendTrainingNeedsApproval(Convert.ToString(Session["employeeNo"]), needsNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeneedsrequest_Click(object sender, EventArgs e)
        {
            try
            {
                //String tlinenumber = removeLineNumber.Text.Trim();
                int ylinenumber = Convert.ToInt32(removeLineNumber.Text.Trim());
                String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                String status = Config.ObjNav.FnDeleteTrainingNeedsLines(NeedsRequestNo, ylinenumber);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void editneedsrequest_Click(object sender, EventArgs e)
        {
            try
            {
                int teditsource = editSource.SelectedIndex;
                String teditdescription = editDescription.Text.Trim();
                String teditcomments = editComments.Text.Trim();
                int mLine = Convert.ToInt32(originalNo.Text.Trim());

                String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                String staus = Config.ObjNav.FnEditTrainingNeedsRequestLines(NeedsRequestNo, mLine, teditdescription, teditsource, teditcomments);
                String[] info = staus.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void trainingcategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string category = trainingcategory.SelectedValue;
            var nav = new Config().ReturnNav();
            var cou = nav.TrainingCoursesSetup.Where(x => x.Training_Category == category);
            course.DataSource = cou;
            course.DataValueField = "Code";
            course.DataTextField = "Descritpion";
            course.DataBind();
            course.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }
    }
}