using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsValidCaptcha())
                {

                    string tUsername = username.Text.Trim();
                    if (string.IsNullOrEmpty(tUsername))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>A valid Employee UserName is Required<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    string tPassword = password.Text.Trim();
                    if (string.IsNullOrEmpty(tPassword))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>A valid Employee Password is Required<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    var nav = new Config().ReturnNav();
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == tUsername && r.password == tPassword).ToList();
                    Boolean exists = false;
                    if (users != null)
                    {
                        foreach (var user in users)
                        {
                            exists = true;
                            Session["name"] = user.First_Name + " " + user.Middle_Name + " " + user.Last_Name;
                            Session["employeeNo"] = user.employeeNo;
                            Session["idNo"] = user.ID_Number;
                            Session["admin"] = user.isAdmin;
                            Session["region"] = user.Region;
                            Session["jobTitle"] = user.Job_ID;
                            Session["FundCode"] = user.Global_Dimension_2_Code;
                            Session["Directorate"] = user.Directorate_Code;
                            Session["Department"] = user.Department_Code;

                            var emp = nav.Employees.Where(x => x.No == Convert.ToString(Session["employeeNo"]));
                            foreach(var person in  emp)
                            {
                                Session["appraisalSupervisor"] = person.Appraisal_Supervisor;
                            }
                            Response.Redirect("Dashboard.aspx");
                        }
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>A user with the entered credentials could not be found.Kindly Try again later<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }

                    if (!exists)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>A user with the entered credentials does not exist<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }


                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Provide a valid captcha. Prove that you are not a robot<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        bool IsValidCaptcha()
        {
            try
            {
                string resp = Request["g-recaptcha-response"];
                var req = (HttpWebRequest)WebRequest.Create
                    ("https://www.google.com/recaptcha/api/siteverify?secret=6LdcwEQdAAAAABlfO293bt5GTrIHNYGtxI9480M1&response=" +
                     resp);
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        CaptchaResult data = js.Deserialize<CaptchaResult>(jsonResponse);
                        if (Convert.ToBoolean(data.success))
                        {
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            return false;
        }
    }
}