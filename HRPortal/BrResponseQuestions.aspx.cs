using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class BrResponseQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void back_Click(object sender, EventArgs e)
        {
            
            string surveyNo = Request.QueryString["surveyNo"];
            Response.Redirect("BRResponseSection.aspx?surveyNo=" + surveyNo);
        }
       
    }
}