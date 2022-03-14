using HRPortal.Models;
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
    public partial class PurchaseRequisition : System.Web.UI.Page
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
                loadPurchaseRequisition();
                var locations = nav.Locations;
                location.DataSource = locations;
                location.DataTextField = "Name";
                location.DataValueField = "Code";
                location.DataBind();

                //var allFundCodes = nav.FundCode;
                //fundCode.DataSource = allFundCodes;
                //fundCode.DataTextField = "Name";
                //fundCode.DataValueField = "Code";
                //fundCode.DataBind();
                var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
                List<Employee> allJobs = new List<Employee>();
                foreach (var myJob in jobs)
                {
                    Employee employee = new Employee();
                    employee.EmployeeNo = myJob.No;
                    employee.EmployeeName = myJob.No + " - " + myJob.Description;
                    allJobs.Add(employee);
                }
                job.DataSource = allJobs;
                job.DataValueField = "EmployeeNo";
                job.DataTextField = "EmployeeName";
                job.DataBind();
                //LoadJobTasks();
                try
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    if (!String.IsNullOrEmpty(requisitionNo))
                    {
                        Boolean exists = false;
                        var requsition =
                            nav.PurchaseHeader.Where(
                                r =>
                                    (r.Document_Type == "Purchase Requisition" || r.Document_Type == "Store Requisition") && r.No == requisitionNo && r.Request_By_No == Convert.ToString(Session["employeeNo"]));
                        foreach (var myRequisition in requsition)
                        {
                            exists = true;
                            fundCode.SelectedValue = myRequisition.Shortcut_Dimension_2_Code;
                            location.SelectedValue = myRequisition.Location_Code;
                            description.Text = myRequisition.Description;
                            job.SelectedValue = myRequisition.Job;
                            //LoadJobTasks();
                            //jobTaskno.SelectedValue = myRequisition.Job_Task_No;
                            planId.Text = myRequisition.Procurement_Plan_ID;
                            if (myRequisition.PRN_Type == "Project Works")
                            {
                                prnType.SelectedValue = "1";
                            }
                            else
                            {
                                prnType.SelectedValue = "0";
                            }
                           
                        }
                        if (!exists)
                        {
                            Response.Redirect("PurchaseRequisition.aspx");
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
                    var budgets = nav.ProcurementHeader;
                    itemCategory.DataSource = itemCategories;
                    itemCategory.DataValueField = "Code";
                    itemCategory.DataTextField = "Description";
                    itemCategory.DataBind();
                    LoadProcurementPlan();
                    LoadItems();

                }
            }
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            var directorate = "";
            var department = "";
            var pType = prnType.SelectedValue;
            if (pType == "0")
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;
                    var myJob = job.SelectedValue;
                    var nav = new Config().ReturnNav();
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
                    foreach (var item in users)

                    {
                        directorate = item.Directorate_Code;
                        department = item.Department_Code;


                    }
                    var plan = planId.SelectedValue;
                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan && x.Requisition_Product_Group == pgroup && x.Directorate == directorate && x.Department == department && x.Budget_Control_Job_No == myJob
                    && x.Procurement_Use == "Standard (Internal Use)").ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Budget_Control_Job_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }
                    planEntryNo.DataSource = list;
                    planEntryNo.DataTextField = "Description";
                    planEntryNo.DataValueField = "No";
                    planEntryNo.DataBind();

                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();
                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            else
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;
                    var nav = new Config().ReturnNav();
                    var plan = planId.SelectedValue;
                    var myJob = job.SelectedValue;
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
                    foreach (var item in users)

                    {
                        directorate = item.Directorate_Code;
                        department = item.Department_Code;


                    }
                    //var tjob = job.SelectedValue;
                    //var tJobjobTaskno = jobTaskno.SelectedValue;

                    // var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan  && x.Requisition_Product_Group == pgroup
                    //&& x.Budget_Control_Job_No == tjob && x.Budget_Control_Job_Task_No == tJobjobTaskno
                    // && x.Procurement_Use == "Project-Specific Use" ).ToList();
                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan
                   && x.Requisition_Product_Group == pgroup && x.Directorate == directorate && x.Department == department&&x.Budget_Control_Job_No== myJob
                   && x.Procurement_Use == "Standard (Internal Use)").ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Budget_Control_Job_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }
                    planEntryNo.DataSource = list;
                    planEntryNo.DataTextField = "Description";
                    planEntryNo.DataValueField = "No";
                    planEntryNo.DataBind();

                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();
                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }


        }
        protected void LoadJobTasks()
        {
            //var nav = new Config().ReturnNav();
            //var myJob = job.SelectedValue;
            //var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            //jobTaskno.DataSource = jobTasks;
            //jobTaskno.DataValueField = "Job_Task_No";
            //jobTaskno.DataTextField = "Description";
            //jobTaskno.DataBind();
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";

                String requisitionNo = "";
                Boolean newRequisition = false;
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

          

                //string priority = priorityLevel.SelectedValue;
                string plan = planId.SelectedValue;
                string planEntry = planEntryNo.SelectedValue;
                string requisitionPGroup = requisitionProductGroup.SelectedValue;
                String tLocation = String.IsNullOrEmpty(location.SelectedValue.Trim()) ? "" : location.SelectedValue.Trim();
                String tFundCode = String.IsNullOrEmpty(fundCode.SelectedValue.Trim()) ? "" : fundCode.SelectedValue.Trim();
                String tJob = String.IsNullOrEmpty(job.SelectedValue.Trim()) ? "" : job.SelectedValue.Trim();
                String tJobTask = String.IsNullOrEmpty(planEntryNo.SelectedValue.Trim()) ? "" : planEntryNo.SelectedValue.Trim();
                String tDescription = String.IsNullOrEmpty(description.Text.Trim()) ? "" : description.Text.Trim();
                var pType = prnType.SelectedValue;

                if(pType == "0")
                {
                    //tJob = "";
                    //tJobTask = "";
                }


                //if (string.IsNullOrEmpty(priority))
                //{
                //    error = true;
                //    message = "Please choose priority";

                //}
                if (string.IsNullOrEmpty(requisitionPGroup))
                {
                    error = true;
                    message = "Please choose product requisition group";
                }
                if(error == true)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
                else
                {
                    String status = Config.ObjNav.CreatePurchaseRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tLocation, tDescription, Convert.ToInt32(1), Convert.ToInt32(requisitionPGroup), tFundCode, plan, Convert.ToInt32(planEntry),"","",Convert.ToInt32(pType));
                    String[] info = status.Split('*');
                    // Session["jobId"] = tJob;
                    if (info[0] == "success")
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        String redirectLocation = "PurchaseRequisition.aspx?step=2&&requisitionNo=" + requisitionNo;
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
            Response.Redirect("PurchaseRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav.SendPurchaseRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        public void LoadProcurementPlan()
        {
            try
            {
                //var nav = new Config().ReturnNav();
                //String tBudget = budget.SelectedValue;
                //var division = "";
                //var directorateCode = "";
                //var departmentCode = "";
                //String requisitionNo = Request.QueryString["requisitionNo"];
                //var requsition =
                //           nav.PurchaseHeader.Where(
                //               r =>
                //                   (r.Document_Type == "Purchase Requisition" || r.Document_Type == "Store Requisition") && r.No == requisitionNo && r.Request_By_No == Convert.ToString(Session["employeeNo"]));
                //foreach (var myRequisition in requsition)
                //{
                //    division = myRequisition.Division;
                //    directorateCode = myRequisition.Directorate_Code;
                //    departmentCode = myRequisition.Department_Code;
                //}

                //var jobId = Session["jobId"].ToString();

                //var procurementPlan = nav.ProcurementPlan.Where(r => r.Plan_Year == tBudget && r.Job_ID == jobId && r.Directorate_Code == directorateCode && r.Division == division && r.Department_Code == departmentCode);
                //procurementPlanItem.DataSource = procurementPlan;
                //procurementPlanItem.DataValueField = "Plan_Item_No";
                //procurementPlanItem.DataTextField = "Item_Description";
                //procurementPlanItem.DataBind();
            }
            catch (Exception)
            {

            }
        }

        public void LoadItems()
        {
            try
            {
                var nav = new Config().ReturnNav();
                String postingGroup = itemCategory.SelectedValue;
                var items = nav.Items.Where(r => r.Item_Category_Code == postingGroup);
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

        protected void budget_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProcurementPlan();
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
                    String status = Config.ObjNav.DeleteRequisitionLine(employeeName, requisitionNo, tLineNo, 7);
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
            try
            {
                //String tBudget = String.IsNullOrEmpty(budget.SelectedValue.Trim()) ? "" : budget.SelectedValue.Trim();
                //String tProcurementPlanItem = String.IsNullOrEmpty(procurementPlanItem.SelectedValue.Trim())
                //    ? ""
                //    : procurementPlanItem.SelectedValue.Trim();
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
                String tDirectCost = String.IsNullOrEmpty(directUnitCost.Text.Trim())
                   ? ""
                   : directUnitCost.Text.Trim();
                Decimal nCost = 0;
                try
                {
                    nCost = Convert.ToDecimal(tDirectCost);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for direct unit cost<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                if (!error)
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    String status = Config.ObjNav.CreateRequisitionLine(Convert.ToString(Session["employeeNo"]),
                        requisitionNo,
                        "", "", tItemCategory, tItem, nQuantity, nCost);
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
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";

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
                                        Config.navExtender.AddLinkToRecord("Standard Purchase Requisition", imprestNo, filename, "");
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

            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "PurchaseRequisition Header/";

            //if (document.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder))
            //        {
            //            String extension = System.IO.Path.GetExtension(document.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String imprestNo = Request.QueryString["requisitionNo"];
            //                //imprestNo = imprestNo.Replace('/', '_');
            //                //imprestNo = imprestNo.Replace(':', '_');
            //                String documentDirectory = filesFolder + imprestNo + "/";
            //                Boolean createDirectory = true;
            //                try
            //                {
            //                    if (!Directory.Exists(documentDirectory))
            //                    {
            //                        Directory.CreateDirectory(documentDirectory);
            //                    }
            //                }
            //                catch (Exception)
            //                {
            //                    createDirectory = false;
            //                    documentsfeedback.InnerHtml =
            //                                                    "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
            //                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                }
            //                if (createDirectory)
            //                {
            //                    string filename = documentDirectory + document.FileName;
            //                    if (File.Exists(filename))
            //                    {
            //                        documentsfeedback.InnerHtml =
            //                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    }
            //                    else
            //                    {
            //                        document.SaveAs(filename);
            //                        if (File.Exists(filename))
            //                        {

            //                            Config.navExtender.AddLinkToRecord("PurchaseRequisition Header", imprestNo, filename, "");
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                        else
            //                        {
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                    }
            //                }
            //            }
            //            else
            //            {
            //                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }
            //        else
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }

            //    }
            //    catch (Exception ex)
            //    {
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //else
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}


        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";
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
            Response.Redirect("PurchaseRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("PurchaseRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void loadProcurementPlanEntry()
        {
            //var directorate = "";
            //var department = "";

            //var nav = new Config().ReturnNav();
            //var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
            //foreach(var item in users)

            //{
            //    directorate = item.Directorate_Code;
            //    department = item.Department_Code;
               

            //}


            //var plan = planId.SelectedValue;
           
            //var pgroup = "";
            //if (Session["pgroup"] != null)
            //{
            //    pgroup = Session["pgroup"].ToString();

            //}
            // Session["pgroup"] = pgroup;
            //var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan
            //&& x.Requisition_Product_Group==pgroup
            //&& x.Directorate == directorate && x.Department == department
            //&& x.Procurement_Use == "Standard (Internal Use)"
            //).ToList();
            //List<Item> list = new List<Item>();
            //foreach (var item in query)
            //{
            //    Item itm = new Item();
            //    itm.Description = item.Entry_No + " :" + item.Description;
            //    itm.No = item.Entry_No.ToString();
            //    list.Add(itm);
            //}
            //planEntryNo.DataSource = list;
            //planEntryNo.DataTextField = "Description";
            //planEntryNo.DataValueField = "No";
            //planEntryNo.DataBind();
            //planEntryNo

        }
        protected void loadCurrentProcurementPlan()
        {
            //planId
            List<ProcurementPlan> list = new List<ProcurementPlan>();
            var nav = new Config().ReturnNav();
            var plan = nav.CurrentProcurementPlan;
            foreach(var item in plan)
            {
                ProcurementPlan model = new ProcurementPlan();
                model.Code = item.Code;
                model.Description = item.Code +" "+ item.Description;
                list.Add(model);
            }
            planId.DataSource= list;
            planId.DataTextField = "Description";
            planId.DataValueField = "Code";
            planId.DataBind();
        }

        protected void loadItems()
        {
            var nav = new Config().ReturnNav();
            var entryNo = planEntryNo.SelectedValue;
            var category = "";

            var query = nav.ProcurementPlanEntry.Where(x => x.Entry_No == Convert.ToInt32(entryNo)).ToList();
            foreach(var item in query)
            {
                 category = item.Planning_Category;

            }
            var items = nav.Items.Where(x => x.Item_Category_Code == category).ToList();
         
            foreach(var item in items)
            {

            }
            
        }

      

        protected void requisitionProductGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            var pType = prnType.SelectedValue;
            if(pType== "0")
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;

                    var directorate = "";
                    var department = "";

                    var nav = new Config().ReturnNav();
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
                    foreach (var item in users)

                    {
                        directorate = item.Directorate_Code;
                        department = item.Department_Code;


                    }


                    var plan = planId.SelectedValue;
                    
                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan
                    && x.Requisition_Product_Group == pgroup && x.Directorate == directorate && x.Department == department
                    && x.Procurement_Use == "Standard (Internal Use)" ).ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Budget_Control_Job_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }
                    planEntryNo.DataSource = list;
                    planEntryNo.DataTextField = "Description";
                    planEntryNo.DataValueField = "No";
                    planEntryNo.DataBind();

                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();

                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            else
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;
                    var nav = new Config().ReturnNav();
                    var plan = planId.SelectedValue;
                    var directorate = "";
                    var department = "";
                    
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
                    foreach (var item in users)

                    {
                        directorate = item.Directorate_Code;
                        department = item.Department_Code;


                    }
                    //var tjob = job.SelectedValue;
                    //var tJobjobTaskno = jobTaskno.SelectedValue;

                    // var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan  && x.Requisition_Product_Group == pgroup
                    //&& x.Budget_Control_Job_No == tjob && x.Budget_Control_Job_Task_No == tJobjobTaskno
                    // && x.Procurement_Use == "Project-Specific Use" ).ToList();
                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan
                   && x.Requisition_Product_Group == pgroup && x.Directorate == directorate && x.Department == department
                   && x.Procurement_Use == "Standard (Internal Use)").ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Budget_Control_Job_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }
                    planEntryNo.DataSource = list;
                    planEntryNo.DataTextField = "Description";
                    planEntryNo.DataValueField = "No";
                    planEntryNo.DataBind();

                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();
                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            
        }
        protected void requisitionProcurementPlanEntry_SelectedIndexChanged(object sender, EventArgs e)
        {
            var pType = prnType.SelectedValue;
            if (pType == "0")
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;

                    var directorate = "";
                    var department = "";

                    var nav = new Config().ReturnNav();
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == Convert.ToString(Session["employeeNo"]));
                    foreach (var item in users)

                    {
                        directorate = item.Directorate_Code;
                        department = item.Department_Code;


                    }


                    var plan = planId.SelectedValue;
                    int planEntry =Convert.ToInt32(planEntryNo.SelectedValue);
                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan
                    && x.Requisition_Product_Group == pgroup && x.Directorate == directorate && x.Department == department&&x.Entry_No== planEntry
                    && x.Procurement_Use == "Standard (Internal Use)").ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Entry_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }

                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();
                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            else
            {
                try
                {
                    var pgroup = "";
                    var group = requisitionProductGroup.SelectedValue;


                    if (group == "0")
                    {
                        pgroup = "Goods";
                    }
                    else if (group == "1")
                    {
                        pgroup = "Services";
                    }
                    else if (group == "2")
                    {
                        pgroup = "Works";
                    }
                    else if (group == "3")
                    {
                        pgroup = "Assets";
                    }
                    else
                    {
                        pgroup = "";
                    }
                    Session["pgroup"] = pgroup;
                    var nav = new Config().ReturnNav();
                    var plan = planId.SelectedValue;
                    var planEntry = planEntryNo.SelectedIndex;
                    //var tjob = job.SelectedValue;
                    //var tJobjobTaskno = jobTaskno.SelectedValue;

                    var query = nav.ProcurementPlanEntry.Where(x => x.Procurement_Plan_ID == plan && x.Requisition_Product_Group == pgroup && x.Entry_No == planEntry
                    //&& x.Budget_Control_Job_No == tjob && x.Budget_Control_Job_Task_No == tJobjobTaskno
                    && x.Procurement_Use == "Project-Specific Use").ToList();
                    List<Item> list = new List<Item>();
                    foreach (var item in query)
                    {
                        Item itm = new Item();
                        itm.Description = item.Entry_No + " :" + item.Description;
                        itm.No = item.Entry_No.ToString();
                        itm.fundcodeid = item.Funding_Source_ID.ToString();
                        list.Add(itm);
                    }
                    fundCode.DataSource = list;
                    fundCode.DataTextField = "fundcodeid";
                    fundCode.DataValueField = "fundcodeid";
                    fundCode.DataBind();
                }
                catch (Exception ex)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }

        }
       
        protected void loadPurchaseRequisition()
        {
            var nav = new Config().ReturnNav();
            String requisitionNo = "";

            if (Request.QueryString["requisitionNo"] != null)
            {
                requisitionNo = Request.QueryString["requisitionNo"];
            }

            var requsition =
                           nav.PurchaseHeader.Where( r => r.Document_Type == "Purchase Requisition" && r.No == requisitionNo && r.Request_By_No == Convert.ToString(Session["employeeNo"]));
            foreach (var item in requsition)
            {
                var rGroup = item.Requisition_Product_Group;
                if (rGroup == "Goods")
                {
                    requisitionProductGroup.SelectedValue = "0";
                }
                else if (rGroup == "Services")
                {
                    requisitionProductGroup.SelectedValue = "1";
                }
                else if (rGroup == "Works")
                {
                    requisitionProductGroup.SelectedValue = "2";
                }
                else if (rGroup == "Assets")
                {
                    requisitionProductGroup.SelectedValue = "3";
                }


                //var pLevel = item.Priority_Level;
                //if (pLevel == "Low")
                //{
                //    priorityLevel.SelectedValue = "0";

                //}
                //else if (pLevel == "Normal")
                //{
                //    priorityLevel.SelectedValue = "1";
                //}
                //else if (pLevel == "High")
                //{
                //    priorityLevel.SelectedValue = "2";
                //}
                //else if (pLevel == "Critical")
                //{
                //    priorityLevel.SelectedValue = "3";
                //}
                string entryNo = Convert.ToString(item.Procurement_Plan_Entry_No);
                planEntryNo.SelectedValue = entryNo;
               // templateId.SelectedValue = item.Requisition_Template_ID;
            }
        }

        protected void prnType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var pType = prnType.SelectedValue;
               
                if (pType == "1")
                {
                    //job.Visible = true;
                    //jobTaskno.Visible = true;
                    //tJob.Visible = true;
                    //jTaskNo.Visible = true;
                    List<ProcurementPlan> list = new List<ProcurementPlan>();
                    var nav = new Config().ReturnNav();
                    var wPlan = nav.EffectiveProcurementPlans;
                    foreach(var item in wPlan)
                    {
                        ProcurementPlan plan = new ProcurementPlan();
                        plan.Code = item.Works_Procurement_Plan;
                        list.Add(plan);
                    }
                    planId.DataSource = list;
                    planId.DataTextField = "Code";
                    planId.DataValueField = "Code";
                    planId.DataBind();


                }
                else
                {
                    List<ProcurementPlan> list = new List<ProcurementPlan>();
                    var nav = new Config().ReturnNav();
                    var wPlan = nav.EffectiveProcurementPlans;
                    foreach (var item in wPlan)
                    {
                        ProcurementPlan plan = new ProcurementPlan();
                        plan.Code = item.Effective_Procurement_Plan;
                        list.Add(plan);
                    }
                    planId.DataSource = list;
                    planId.DataTextField = "Code";
                    planId.DataValueField = "Code";
                    planId.DataBind();
                    //tJob.Visible = false;
                    //jTaskNo.Visible = false;
                    //job.Visible = false;
                    //jobTaskno.Visible = false;
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
       
    }
}