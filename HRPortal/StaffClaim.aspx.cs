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
    public partial class StaffClaim : System.Web.UI.Page
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
                var allFundCodes = nav.FundCode;
                fundCode.DataSource = allFundCodes;
                fundCode.DataTextField = "Name";
                fundCode.DataValueField = "Code";
                fundCode.DataBind();
                var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
                List<Employee> allJobs = new List<Employee>();
                foreach (var myJob in jobs)
                {
                    Employee employee = new Employee();
                    employee.EmployeeNo = myJob.No;
                    employee.EmployeeName = myJob.No+" - "+myJob.Description;
                    allJobs.Add(employee);
                }
                job.DataSource = allJobs;
                job.DataValueField = "EmployeeNo";
                job.DataTextField = "EmployeeName";
                job.DataBind();
                LoadJobTasks();
                try
                {
                    String claimNo = Request.QueryString["claimNo"];
                    if (!String.IsNullOrEmpty(claimNo))
                    {
                        Boolean exists = false;
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var claim =nav.Payments.Where(r =>r.Account_No == employeeNo && r.No == claimNo &&r.Payment_Type == "Staff Claim");
                        foreach (var myClaim in claim)
                        {
                            exists = true;
                            fundCode.SelectedValue = myClaim.Shortcut_Dimension_2_Code;
                            description.Text = myClaim.Payment_Narration;
                            job.SelectedValue = myClaim.Job;
                            LoadJobTasks();
                            jobTaskno.SelectedValue = myClaim.Job_Task_No;
                        }
                        if (!exists)
                        {
                            Response.Redirect("StaffClaim.aspx");
                        }
                    }
                }
                catch (Exception)
                {

                }
                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"]);
                    if (step > 2 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch (Exception)
                {
                    step = 1;
                }
                if (step == 2)
                {

                    var voteItems = nav.ReceiptAndPaymentTypes.Where(r => r.Appear_on_Imprest == true);
                    voteItem.DataSource = voteItems;
                    voteItem.DataValueField = "Code";
                    voteItem.DataTextField = "Description";
                    voteItem.DataBind();
                    editVoteItem.DataSource = voteItems;
                    editVoteItem.DataValueField = "Code";
                    editVoteItem.DataTextField = "Description";
                    editVoteItem.DataBind();

                }
            }
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();
        }

        protected void LoadJobTasks()
        {
            var nav = new Config().ReturnNav();
            var myJob = job.SelectedValue;
            var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            jobTaskno.DataSource = jobTasks;
            jobTaskno.DataValueField = "Job_Task_No";
            jobTaskno.DataTextField = "Description";
            jobTaskno.DataBind();
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {

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
               
                String tFundCode = String.IsNullOrEmpty(fundCode.SelectedValue.Trim()) ? "" : fundCode.SelectedValue.Trim();
                String tJob = String.IsNullOrEmpty(job.SelectedValue.Trim()) ? "" : job.SelectedValue.Trim();
                String tJobTask = String.IsNullOrEmpty(jobTaskno.SelectedValue.Trim()) ? "" : jobTaskno.SelectedValue.Trim();
                String tDescription = String.IsNullOrEmpty(description.Text.Trim()) ? "" : description.Text.Trim();
                String status = Config.ObjNav.CreateStaffClaim(Convert.ToString(Session["employeeNo"]), requisitionNo,  tDescription,  tFundCode, tJob, tJobTask);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "StaffClaim.aspx?step=2&&claimNo=" + requisitionNo;
                    Response.Redirect(redirectLocation);

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["claimNo"];
            Response.Redirect("StaffClaim.aspx?step=1&&claimNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["claimNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav.SendStaffClaimApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

      
      

        protected void deleteLine_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeName = Convert.ToString(Session["employeeNo"]);
                    String requisitionNo = Request.QueryString["claimNo"];
                    String status = Config.ObjNav.DeleteStaffClaimLine(employeeName, requisitionNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-"+ info[0]+ "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            
        }
        protected void addItem_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            try
            {
                String tVoteItem = String.IsNullOrEmpty(voteItem.SelectedValue.Trim()) ? "" : voteItem.SelectedValue.Trim();
                String tDescription = String.IsNullOrEmpty(lineDescription.Text.Trim()) ? "" : lineDescription.Text.Trim();
                

                String tMyAmount = String.IsNullOrEmpty(amount.Text.Trim())
                   ? ""
                   : amount.Text.Trim();
                Decimal nAmount = 0;
                try
                {
                    nAmount = Convert.ToDecimal(tMyAmount);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for amount<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                if (!error)
                {
                    String requisitionNo = Request.QueryString["claimNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    String status = Config.ObjNav.CreateStaffClaimLine(Convert.ToString(Session["employeeNo"]),
                        requisitionNo,tVoteItem, tDescription, nAmount);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void editItem_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            try
            {
                String tVoteItem = String.IsNullOrEmpty(editVoteItem.SelectedValue.Trim()) ? "" : editVoteItem.SelectedValue.Trim();
                String tDescription = String.IsNullOrEmpty(editDescription.Text.Trim()) ? "" : editDescription.Text.Trim();


                String tMyAmount = String.IsNullOrEmpty(editAmount.Text.Trim())? "": editAmount.Text.Trim();
                String tLineNo = String.IsNullOrEmpty(editLineNo.Text.Trim())? "": editLineNo.Text.Trim();
                int mLineNo = 0;
                try
                {
                    mLineNo = Convert.ToInt32(tLineNo);
                }
                catch (Exception)
                {
                    mLineNo = 0;
                }
                Decimal nAmount = 0;
                try
                {
                    nAmount = Convert.ToDecimal(tMyAmount);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for amount<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                if (!error)
                {
                    String requisitionNo = Request.QueryString["claimNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    String status = Config.ObjNav.EditStaffClaimLine(mLineNo,Convert.ToString(Session["employeeNo"]),
                        requisitionNo, tVoteItem, tDescription, nAmount);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["claimNo"];
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
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
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
                                     Config.navExtender.AddLinkToRecord("Staff Claim", imprestNo, filename, "");
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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";
                String imprestNo = Request.QueryString["claimNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //removeNumber
            //removeWorkType



        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["claimNo"];
            Response.Redirect("StaffClaim.aspx?step=3&&claimNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["claimNo"];
            Response.Redirect("StaffClaim.aspx?step=2&&claimNo=" + requisitionNo);
        }
    }
}