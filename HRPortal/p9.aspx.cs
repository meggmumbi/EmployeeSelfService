using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class p9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            feedback.InnerHtml = "";
            
            DateTime mStartDate = new DateTime();
            DateTime mEndDate = new DateTime();
            Boolean Error = false;
                try
                {
                    String tStartDate = Convert.ToDateTime(startDate.Text).ToString("M/d/yyyy");
                    String tEndDate = Convert.ToDateTime(endDate.Text).ToString("M/d/yyyy");
                    String status = Config.ObjNav.GenerateP9((String) Session["employeeNo"],
                     Convert.ToDateTime(  tStartDate), Convert.ToDateTime(tEndDate));
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