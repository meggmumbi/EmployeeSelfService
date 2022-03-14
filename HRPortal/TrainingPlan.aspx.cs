using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TrainingPlan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void generate_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = Convert.ToString(Session["planNo"]);
                String status = Config.ObjNav.FnGenerateTrainingPlanReport(docNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    p9form.Attributes.Add("src", ResolveUrl(info[2]));
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
    }
}