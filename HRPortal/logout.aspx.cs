﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["name"] = "";
            Session["employeeNo"] = "";
            Session["idNo"] = "";
            Session["type"] = 0;
            Session["PerformanceLogNo"] = "";
            Response.Redirect("Login.aspx");
        }
    }
}