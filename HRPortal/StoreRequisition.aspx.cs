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
    public partial class StoreRequisition : System.Web.UI.Page
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
                var locations = nav.Locations.Where(c=>c.Code== "NAIROBI");
                location.DataSource = locations;
                location.DataTextField = "Name";
                location.DataValueField = "Code";
                location.DataBind();

                //var allFundCodes = nav.FundCode;
                //fundCode.DataSource = allFundCodes;
                //fundCode.DataTextField = "Name";
                //fundCode.DataValueField = "Code";
                //fundCode.DataBind();
                //var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
                //List<Employee> allJobs = new List<Employee>();
                //foreach (var myJob in jobs)
                //{
                //    Employee employee = new Employee();
                //    employee.EmployeeNo = myJob.No;
                //    employee.EmployeeName = myJob.No + " - " + myJob.Description;
                //    allJobs.Add(employee);
                //}
                //job.DataSource = allJobs;
                //job.DataValueField = "EmployeeNo";
                //job.DataTextField = "EmployeeName";
                //job.DataBind();
                //LoadJobTasks();
                try
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    if (!String.IsNullOrEmpty(requisitionNo))
                    {
                        Boolean exists = false;
                        var requsition =
                            nav.PurchaseHeader.Where( r => (r.Document_Type == "Purchase Requisition" || r.Document_Type == "Store Requisition") && r.No == requisitionNo && r.Request_By_No == Convert.ToString(Session["employeeNo"]));
                        foreach (var myRequisition in requsition)
                        {
                            exists = true;
                           // fundCode.SelectedValue = myRequisition.Shortcut_Dimension_2_Code;
                            location.SelectedValue = myRequisition.Location_Code;
                            description.Text = myRequisition.Description;
                           // job.SelectedValue = myRequisition.Job;
                          //  LoadJobTasks();
                            //jobTaskno.SelectedValue = myRequisition.Job_Task_No;
                        }
                        if (!exists)
                        {
                            Response.Redirect("StoreRequisition.aspx");
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

                    var itemCategories = nav.ItemCategories;                  

                    itemCategory.DataSource = itemCategories;
                    itemCategory.DataValueField = "Code";
                    itemCategory.DataTextField = "Description";
                    itemCategory.DataBind();
                    LoadItems();

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
                Boolean error = false;
                String message = "";
                try
                {
                    requisitionNo = Request.QueryString["requisitionNo"];
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
                String tLocation = String.IsNullOrEmpty(location.SelectedValue.Trim()) ? "" : location.SelectedValue.Trim();
                String tFundCode = "";
                //String.IsNullOrEmpty(fundCode.SelectedValue.Trim()) ? "" : fundCode.SelectedValue.Trim();
                String tJob = "";
                    //String.IsNullOrEmpty(job.SelectedValue.Trim()) ? "" : job.SelectedValue.Trim();
                String tJobTask = "";
                //String.IsNullOrEmpty(jobTaskno.SelectedValue.Trim()) ? "" : jobTaskno.SelectedValue.Trim();
                string tDescription = description.Text.Trim();
               
                if (String.IsNullOrEmpty(tDescription))
                {
                    error = true;
                    message = "Please specify the Description";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.CreatePurchaseStoreRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tLocation, tDescription, 1, tFundCode, tJob, tJobTask);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        String redirectLocation = "StoreRequisition.aspx?step=2&&requisitionNo=" + requisitionNo;
                        Response.Redirect(redirectLocation);

                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav.SendStoreRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

       
        public void LoadItems()
        {
            try
            {
                var nav = new Config().ReturnNav();
                String postingGroup = itemCategory.SelectedValue;
                var items = nav.Items.Where(r => r.Item_Category_Code == postingGroup && r.Stock_Item ==true);
                item.DataSource = items;
                item.DataValueField = "No";
                item.DataTextField = "Description";
                item.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void itemCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadItems();
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
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.DeleteRequisitionLine(employeeName, requisitionNo, tLineNo, 6);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
              
                String tItemCategory = String.IsNullOrEmpty(itemCategory.SelectedValue.Trim())
                    ? ""
                    : itemCategory.SelectedValue.Trim();
                String tItem = String.IsNullOrEmpty(item.SelectedValue.Trim()) ? "" : item.SelectedValue.Trim();
                String tQuantity = String.IsNullOrEmpty(quantityRequested.Text.Trim())
                    ? ""
                    : quantityRequested.Text.Trim();
                Decimal nQuantity = 0;
                Boolean error = false;
                try
                {
                    nQuantity = Convert.ToDecimal(tQuantity);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for quantity<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                
                if (!error)
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    String status = Config.ObjNav.CreateStoreRequisitionLine(Convert.ToString(Session["employeeNo"]),
                        requisitionNo,
                         tItemCategory, tItem, nQuantity);
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

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";

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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";
                String imprestNo = Request.QueryString["requisitionNo"];
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
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
    }
}