using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeSurveyResponses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            //var nav = new Config().ReturnNav();
            //if (!IsPostBack)
            //{
            //    var surveyType = nav.ResearchSurveyType.ToList();
            //    surveytype.DataSource = surveyType;
            //    surveytype.DataTextField = "Description";
            //    surveytype.DataValueField = "Code";
            //    surveytype.DataBind();

            //    var tDirectorate = nav.ResponsibilitiesCenters.Where(x=> x.Research_Center == false).ToList();
            //    directorate.DataSource = tDirectorate;
            //    directorate.DataTextField = "Name";
            //    directorate.DataValueField = "Code";
            //    directorate.DataBind();

            //    var tDepartment = nav.ResponsibilitiesCenters.Where(x=> x.Research_Center == true).ToList();
            //    department.DataSource = tDepartment;
            //    department.DataTextField = "Name";
            //    department.DataValueField = "Code";
            //    department.DataBind();
            //}
        }
        //protected void next_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string tSurvetType = surveytype.SelectedValue;
        //        string tDepartment = department.SelectedValue;
        //        string tDirectorate = directorate.SelectedValue;
        //        string tDescription = description.Text.Trim();
        //        string message = "";
        //        bool error = false;
            

        //        if (string.IsNullOrEmpty(tSurvetType))
        //        {
        //            error = true;
        //            message = "Please select survey type";
        //        }
        //        if (string.IsNullOrEmpty(tDescription))
        //        {
        //            error = true;
        //            message = "Please select description";
        //        }
        //        if (error)
        //        {
        //            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {
        //            String surveyNo = "";
        //            Boolean newsurveyNo = false;
        //            try
        //            {

        //                surveyNo = Request.QueryString["surveyNo"];
        //                if (String.IsNullOrEmpty(surveyNo))
        //                {
        //                    surveyNo = "";
        //                    newsurveyNo = true;
        //                }
        //            }
        //            catch (Exception)
        //            {

        //                surveyNo = "";
        //                newsurveyNo = true;
        //            }
        //            String status = Config.ObjNav.FnCreateBusinessResearchResponse(surveyNo, Convert.ToString(Session["employeeNo"]), tSurvetType, tDepartment, tDirectorate, tDescription);
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                if (newsurveyNo)
        //                {
        //                    surveyNo = info[2];

        //                }
        //                Response.Redirect("BRResponseSection.aspx?&&surveyNo=" + surveyNo);
        //            }
        //            else
        //            {
        //                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }

        //    }
        //    catch(Exception ex)
        //    {
        //        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}
    }
}