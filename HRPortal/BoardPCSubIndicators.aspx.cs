﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class BoardPCSubIndicators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("BoardPerformanceContract.aspx");

        }
    }
}