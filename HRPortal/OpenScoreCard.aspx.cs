using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OpenScoreCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String applicationNo = approvedocNo.Text.Trim();
                String status = Config.ObjNav.FnSendIndividualScorecardApproval(applicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    approvalapplicationLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    approvalapplicationLines.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                approvalapplicationLines.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void canceapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String applicationNo = canceldocNo.Text.Trim();
                String status = Config.ObjNav.FnCancelIndividualScorecardApproval(applicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    approvalapplicationLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    approvalapplicationLines.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                approvalapplicationLines.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}