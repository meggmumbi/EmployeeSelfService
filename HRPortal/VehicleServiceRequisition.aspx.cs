using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class VehicleServiceRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                var nav = new Config().ReturnNav();
                var fleets = nav.FleetVehicles.ToList().OrderBy(r => r.Description);
                registrationNumber.DataSource = fleets;
                registrationNumber.DataValueField = "Registration_No";
                registrationNumber.DataTextField = "Description";
                registrationNumber.DataBind();

                var funsingsources = nav.DimensionValues.ToList().OrderBy(r => r.Name);
                fundingsource.DataSource = funsingsources;
                fundingsource.DataValueField = "Code";
                fundingsource.DataTextField = "Name";
                fundingsource.DataBind();

                var project = nav.jobs.Where(x => x.Description != "").ToList().ToList().OrderBy(r => r.Description);
                List<Employee> allprojects = new List<Employee>();
                foreach (var projects in project)
                {
                    Employee generalprojects = new Employee();
                    generalprojects.EmployeeNo = projects.No;
                    generalprojects.EmployeeName = projects.No + " " + projects.Description;
                    allprojects.Add(generalprojects);
                }
                projectnumber.DataSource = allprojects;
                projectnumber.DataValueField = "EmployeeNo";
                projectnumber.DataTextField = "EmployeeName";
                projectnumber.DataBind();
                
                var vendors = nav.Dealers.Where(x=>x.Name!="").ToList().OrderBy(r => r.Name);
                vendornumber.DataSource = vendors;
                vendornumber.DataValueField = "No";
                vendornumber.DataTextField = "Name";
                vendornumber.DataBind();

                var servicetypes = nav.ServiceTypeItems.ToList().OrderBy(r => r.Service_Name);
                servicecode.DataSource = servicetypes;
                servicecode.DataValueField = "Service_Code";
                servicecode.DataTextField = "Service_Name";
                servicecode.DataBind();

                LoadJobTasks();
            }
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {

            LoadJobTasks();

        }
        protected void LoadJobTasks()
        {
            var nav = new Config().ReturnNav();
            var myJob = projectnumber.SelectedValue;
            var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            voteitemline.DataSource = jobTasks;
            voteitemline.DataValueField = "Job_Task_No";
            voteitemline.DataTextField = "Description";
            voteitemline.DataBind();
        }
        protected void next_Click(object sender, EventArgs e)
        {
            var emp = "";
            if (Session["employeeNo"] != null)
            {
                emp = Session["employeeNo"].ToString();
            }
            string tregistrationNumber = registrationNumber.SelectedValue.Trim();
            string tdescription = description.Text.Trim();
            decimal todometerreading =Convert.ToDecimal( odometerreading.Text.Trim());
            string tfundingsource = fundingsource.SelectedValue.Trim();
            string tprojectnumber = projectnumber.SelectedValue.Trim();
            string tvoteitemline = voteitemline.SelectedValue.Trim();
            string tvendornumber =vendornumber.SelectedValue;
            string tservicecode = servicecode.SelectedValue.Trim();
            decimal tmaintenancecost = Convert.ToDecimal(maintenancecost.Text.Trim());
                var status =Config.ObjNav.AddVehicleMaintenanceRequestDetails(Convert.ToString(Session["employeeNo"]), tregistrationNumber, todometerreading, tservicecode, tdescription, tfundingsource, tprojectnumber, tvoteitemline, tmaintenancecost, tvendornumber);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                Response.Redirect("VehicleServiceRequisition.aspx?step=2&&requisitionNo=" + info[2]);
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("VehicleServiceRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["requisitionNo"];
                            string imprest = imprestNo;
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =  "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {

                                        //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
                                        Config.navExtender.AddLinkToRecord("Imprest Memo", imprest, filename, "");
                                        documentsfeedback.InnerHtml =
                                        "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //The document could not be uploaded
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                String empNo = Session["employeeNo"].ToString();
                String status = Config.ObjNav.SendVehicleMaintenancetforApproval(requisitionNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}