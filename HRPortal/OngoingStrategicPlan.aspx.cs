using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OngoingStrategicPlan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        //protected void attachdocument_Click(object sender, EventArgs e)
        //{
        //    string cspNo = cspcode.Text.Trim();
        //    Response.Redirect("CSPAttachment.aspx?&&cspNo=" + cspNo);
        //}

    }
}