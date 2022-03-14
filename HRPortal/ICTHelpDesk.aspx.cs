using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ICTHelpDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                //var nav = new Config().ReturnNav();
                //var IctDepartmentCategory = nav.IcT_DepartmentCategory;
                //categoryDepartment.DataSource = IctDepartmentCategory;
                //categoryDepartment.DataValueField = "Issue_Category_Department_Code";
                //categoryDepartment.DataTextField = "Issue_Category_Department_Code";
                //categoryDepartment.DataBind();
                //categoryDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                //getCategories();






                //  categoryDepartment
            }

        }

        protected void addICTHelpDeskRequest_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            //string ictCategories = category.SelectedValue.Trim();
            string desc = Description.Text.ToString();
            string tDepartment = categoryDepartment.SelectedValue.Trim();
            string tcategory = category.SelectedValue.Trim();


            String requisitionNo = "";
            Boolean newRequisition = false;
            try
            {
                requisitionNo = Request.QueryString["claimNo"];
                if (String.IsNullOrEmpty(requisitionNo))
                {
                    requisitionNo = "";
                    newRequisition = true;
                }
            }
            catch (Exception)
            {
                newRequisition = true;
                requisitionNo = "";
            }

            if (string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description ";

            }
            if (error == true)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    string empNo = Session["employeeNo"].ToString();
                    string region = Session["region"].ToString();
                    var status = Config.ObjNav.CreateIctRequest(empNo, desc, tcategory);
                    //var status = Config.ObjNav.CreateIctRequest(empNo, desc);

                    string[] info = status.Split('*');
                    //if(info[0]=="success")
                    //{

                    //    ictFeedback.InnerHtml = "<div class='alert alert-success'> '"+info[1]+"' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    //    Response.Redirect("MyHelpDeskRequests.aspxs");
                    //}
                    if (info[0] == "success")
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        String redirectLocation = "ICTHelpDesk.aspx?step=2&&applicationNo=" + requisitionNo;
                        Response.Redirect(redirectLocation);

                    }
                    else
                    {
                        ictFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }


                }
                catch (Exception ex)
                {

                    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }



            }



        }

        public void getCategories()
        {
            var nav = new Config().ReturnNav();
            var categories = nav.ICTHelpDeskCategory.ToList();
            category.DataSource = categories;
            category.DataValueField = "Code";
            category.DataTextField = "Description";
            category.DataBind();
            category.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {


        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["applicationNo"];
            Response.Redirect("MyHelpDeskRequests.aspx?step=2&&applicationNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            Response.Redirect("MyHelpDeskRequests.aspx");
        }

        protected void categoryDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string dpt = categoryDepartment.SelectedValue.Trim();
            //var nav = new Config().ReturnNav();
            //var categories = nav.ICTHelpDeskCategory.Where(r => r.Issue_Category_Department_Code == dpt).ToList();
            //category.DataSource = categories;
            //category.DataValueField = "Code";
            //category.DataTextField = "Description";
            //category.DataBind();
            //category.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

        }
    }
}
