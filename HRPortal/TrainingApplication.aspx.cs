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
    public partial class TrainingApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"]);
                if (step > 5 || step < 1)
                {
                    step = 1;
                }
            }
            catch (Exception)
            {
                step = 1;
            }

            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var query = nav.HumanResourceSetup;
                List<Item> list = new List<Item>();
                foreach (var item in query)
                {
                    Item itm = new Item();
                    itm.Description = item.Annual_Training_Plan + " :" + item.Annual_Training_Plan_Name;
                    itm.No = item.Annual_Training_Plan;
                    list.Add(itm);
                }
                trainingPlan.DataSource = list;
                trainingPlan.DataTextField = "Description";
                trainingPlan.DataValueField = "No";
                trainingPlan.DataBind();
                LoadCourse();

                var workTypes = nav.WorkTypes.Where(x => x.Category == "Project Team").ToList();
                trainingvenue.DataSource = workTypes;
                trainingvenue.DataValueField = "Code";
                trainingvenue.DataTextField = "Description";
                trainingvenue.DataBind();

                //var rc = nav.ResponsibilityCenters.Where(x => x.Operating_Unit_Type == "Region");
                //trainingresponsibility.DataSource = rc;
                //trainingresponsibility.DataValueField = "Code";
                //trainingresponsibility.DataTextField = "Name";
                //trainingresponsibility.DataBind();

                var u = nav.UnitsOfMeasure;
                uom.DataSource = u;
                uom.DataTextField = "Description";
                uom.DataValueField = "Code";
                uom.DataBind();

                var rcp = nav.ReceiptAndPaymentTypes;
                //.Where(x => x.Type == "Imprest")
                type.DataSource = rcp;
                type.DataTextField = "Description";
                type.DataValueField = "Code";
                type.DataBind();

                editType.DataSource = rcp;
                editType.DataTextField = "Description";
                editType.DataValueField = "Code";
                editType.DataBind();

                var emp = nav.Employees;
                List<Item> emplist = new List<Item>();
                foreach (var item in emp)
                {
                    Item itm = new Item();
                    itm.Description = item.First_Name + " " + item.Last_Name;
                    itm.No = item.No;
                    emplist.Add(itm);
                }
                teamMember.DataSource = emplist;
                teamMember.DataTextField = "Description";
                teamMember.DataValueField = "No";
                teamMember.DataBind();

                editTeamMember.DataSource = emplist;
                editTeamMember.DataTextField = "Description";
                editTeamMember.DataValueField = "No";
                editTeamMember.DataBind();

                costEmp.DataSource = emplist;
                costEmp.DataTextField = "Description";
                costEmp.DataValueField = "No";
                costEmp.DataBind();


                var job = nav.FundCode.ToList();
                fundcode.DataSource = job;
                fundcode.DataTextField = "Name";
                fundcode.DataValueField = "Code";
                fundcode.DataBind();

                var f = nav.FundingSource.ToList();
                fundsource.DataSource = f;
                fundsource.DataTextField = "Description";
                fundsource.DataValueField = "Code";
                fundsource.DataBind();

                var annualcodes = nav.AnnualReportingCodes.ToList();
                year.DataSource = annualcodes;
                year.DataTextField = "Description";
                year.DataValueField = "Code";
                year.DataBind();

                var costitems = nav.HRModelsList.ToList();
                costitem.DataSource = costitems;
                costitem.DataValueField = "Code";
                costitem.DataTextField = "Code";
                costitem.DataBind();

                var Titemcategory = nav.ItemCategory.Where(x => x.Parent_Category == "PRODUCTS").ToList();
                itemcategory.DataSource = Titemcategory;
                itemcategory.DataValueField = "Code";
                itemcategory.DataTextField = "Description";
                itemcategory.DataBind();

                //var ic = nav.ItemCategories;
                //itemcategory.DataSource = ic;
                //itemcategory.DataTextField = "Description";
                //itemcategory.DataValueField = "Code";
                //itemcategory.DataBind();

                //var ci = nav.HRModels.Where(x => x.Type == "Training Item Cost").ToList();
                //costitem.DataSource = ci;
                //costitem.DataTextField = "Description";
                //costitem.DataValueField = "Code";
                //costitem.DataBind();

                //destination.DataSource = workTypes;
                //destination.DataValueField = "Code";
                //destination.DataTextField = "Description";
                //destination.DataBind();
                string ndocNo = "";
                try
                {
                    ndocNo = Request.QueryString["docNo"];
                    //if (string.IsNullOrEmpty(ndocNo))
                    //{
                    //    ndocNo = Convert.ToString(Session["mDocNo"]);
                    //}
                }
                catch
                {
                    ndocNo = "";
                }
                if (!string.IsNullOrEmpty(ndocNo))
                {
                    var data = nav.Trainingrequests.Where(x => x.Code == ndocNo);
                    foreach (var item in data)
                    {
                        mstartDate.Text = Convert.ToDateTime(item.Start_DateTime).ToString("d/MM/yyyy");
                        mendDate.Text = Convert.ToDateTime(item.End_DateTime).ToString("d/MM/yyyy");
                        Duration.Text = Convert.ToString(item.Duration);
                        description.Text = item.Justification;
                        trainingvenue.SelectedValue = item.Training_Venue_Region_Code;
                        fundcode.SelectedValue = item.Global_Dimension_2_Code;
                        year.SelectedValue = item.Year;
                        trainingtype.Text = item.Training_Type;
                        modeoftraining.Text = item.Mode_of_Training;
                        residency.Text = item.Residency;
                        location.Text = item.Location;
                        nprovider.Text = item.Provider_Name;
                        coursecategory.Text = item.Description;

                        try
                        {
                            trainingPlan.SelectedValue = item.Training_Plan_No;
                            LoadCourse();
                        }
                        catch
                        {

                        }
                        txtcourseTitle.SelectedValue = item.Course_Title;
                    }
                }

                if (step == 2)
                {
                    String docNo = "";
                    if (string.IsNullOrEmpty(docNo))
                    {
                        docNo = Request.QueryString["docNo"];
                    }
                    var d = nav.Trainingrequests.Where(x => x.Code == docNo);
                    foreach (var t in d)
                    {
                        linedestination.Text = t.Training_Venue_Region_Code;
                    }
                }
            }
        }

        protected void LoadCourse()
        {
            var nav = new Config().ReturnNav();
            List<Course> list = new List<Course>();
            string department = Convert.ToString(Session["Department"]);
            string p = trainingPlan.SelectedValue;
            var tPlan = nav.TrainingRequisitionCourses.Where(x => x.Training_Plan_Id == p && x.Planned_Department == department);
            foreach (var item in tPlan)
            {
                Course c = new Course();
                c.Id = item.Course_ID;
                c.Description = item.Course_Description;
                list.Add(c);
            }

            txtcourseTitle.DataSource = list;
            txtcourseTitle.DataTextField = "Description";
            txtcourseTitle.DataValueField = "Id";
            txtcourseTitle.DataBind();
            txtcourseTitle.Items.Insert(0, "-- Select--");
        }


        protected void trainingPlan_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                String sms = "";
                Boolean flag = false;
                String ttrainingplan = trainingPlan.SelectedValue;
                String ttxtcourseTitle = txtcourseTitle.SelectedValue;
                String ttrainingvenue = trainingvenue.SelectedValue;
                //String ttrainingresponsibility = trainingresponsibility.SelectedValue;
                //String tprovider = provider.SelectedValue;
                String tlocation = location.Text.Trim();
                if (flag)
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = "";
                    Boolean newdocNo = false;
                    try
                    {
                        docNo = Request.QueryString["docNo"];
                        if (String.IsNullOrEmpty(docNo))
                        {
                            //docNo = Convert.ToString(Session["mDocNo"]);
                            //if (String.IsNullOrEmpty(docNo))
                            //{
                                docNo = "";
                                newdocNo = true;
                            //}
                        }
                    }
                    catch (Exception)
                    {
                        docNo = "";
                        newdocNo = true;
                    }
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateTrainingRequisition(docNo, ttrainingplan, "", "", "", "", "", employeeNo, "","","",0,0,0);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        var nav = new Config().ReturnNav();
                        List<Course> list = new List<Course>();
                        string department = Convert.ToString(Session["Department"]);
                        var tPlan = nav.TrainingRequisitionCourses.Where(x => x.Training_Plan_Id == info[3] && x.Planned_Department == department);
                        foreach (var item in tPlan)
                        {
                            Course c = new Course();
                            c.Id = item.Course_ID;
                            c.Description = item.Course_Description;
                            list.Add(c);
                        }

                        txtcourseTitle.DataSource = list;
                        txtcourseTitle.DataTextField = "Description";
                        txtcourseTitle.DataValueField = "Id";
                        txtcourseTitle.DataBind();
                        txtcourseTitle.Items.Insert(0, "-- Select--");

                        Response.Redirect("TrainingApplication.aspx?docNo=" + info[2]);
                    }
                    else
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void txtcourseTitle_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttrainingplan = trainingPlan.SelectedValue;
                String ttxtcourseTitle = txtcourseTitle.SelectedValue;
                String ttrainingvenue = trainingvenue.SelectedValue;
                //String ttrainingresponsibility = trainingresponsibility.SelectedValue;
                //String tprovider = provider.SelectedValue;
                String tlocation = location.Text.Trim();
                if (flag)
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateTrainingRequisition(docNo, "", ttxtcourseTitle, "", "", "", "", employeeNo, "", "", "", 0, 0, 0);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        var nav = new Config().ReturnNav();
                        var data = nav.Trainingrequests.Where(x => x.Code == info[2]).ToList();
                        foreach (var item in data)
                        {
                            mstartDate.Text = Convert.ToDateTime(item.Start_DateTime).ToString("d/MM/yyyy");
                            mendDate.Text = Convert.ToDateTime(item.End_DateTime).ToString("d/MM/yyyy");
                            Duration.Text = Convert.ToString(item.Duration);
                            description.Text = item.Justification;
                            nprovider.Text = item.Provider_Name;
                            coursecategory.Text = item.Description;
                        }
                    }
                    else
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttrainingplan = trainingPlan.SelectedValue;
                String ttxtcourseTitle = txtcourseTitle.SelectedValue;
                String ttrainingvenue = trainingvenue.SelectedValue;
                //String ttrainingresponsibility = trainingresponsibility.SelectedValue;
                String tprovider = "";
                String tlocation = location.Text.Trim();
                String tDesc = description.Text.Trim();
                String tFundcode = fundcode.SelectedValue;
                String tYear = year.SelectedValue;
                int tTrainingtype = trainingtype.SelectedIndex;
                int tModeoftraining = modeoftraining.SelectedIndex;
                int tResidency = residency.SelectedIndex;
                if (flag)
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = "";
                    Boolean newdocNo = false;
                    try
                    {
                        docNo = Request.QueryString["docNo"];
                        if (String.IsNullOrEmpty(docNo))
                        {
                            //docNo = Convert.ToString(Session["mDocNo"]);
                            //if (String.IsNullOrEmpty(docNo))
                            //{
                                docNo = "";
                                newdocNo = true;
                            //}
                        }
                    }
                    catch (Exception)
                    {
                        docNo = "";
                        newdocNo = true;
                    }
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateTrainingRequisition(docNo, ttrainingplan, ttxtcourseTitle, ttrainingvenue, "", tlocation, tprovider, employeeNo, tDesc,tFundcode, tYear, tTrainingtype, tModeoftraining, tResidency);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newdocNo)
                        {
                            docNo = info[2];
                        }
                        Response.Redirect("TrainingApplication.aspx?step=2&&docNo=" + docNo);
                    }
                    else
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttype = type.SelectedValue;
                String tteamMember = teamMember.SelectedValue;
                String tdestination = linedestination.Text;
                Decimal tteamNumberOfDays = Convert.ToDecimal(teamNumberOfDays.Text);

                if (flag)
                {
                    teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.AddTrainingParticipants(ttype, tteamMember, tdestination, tteamNumberOfDays, docNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void GoBackStep1_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=1&&docNo=" + docNo);
        }

        protected void gotostep3_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=3&&docNo=" + docNo);
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Training Requisition/";
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["docNo"];
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
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //We could not create a directory for your documents
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
                                        Config.navExtender.AddLinkToRecord("Training Requisition", imprest, filename, "");
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

        protected void GoBackStep2_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=2&&docNo=" + docNo);
        }

        protected void GoBackToStep4_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=4&&docNo=" + docNo);
        }

        protected void GoToStep4_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=4&&docNo=" + docNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String docNo = Request.QueryString["docNo"];
                String status = Config.ObjNav.SendTrainingRequestApproval(employeeNo, docNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void printReport_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplicationReport.aspx?docNo=" + docNo);
        }

        //protected void itemcategory_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string str = itemcategory.SelectedValue;
        //    var nav = new Config().ReturnNav();
        //    var item = nav.Items.Where(x => x.Blocked == false && x.Item_Category_Code == str).ToList();
        //    serviceitem.DataSource = item;
        //    serviceitem.DataTextField = "Description";
        //    serviceitem.DataValueField = "No";
        //    serviceitem.DataBind();
        //}

        protected void addtrainingcosts_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                int tcostcategory = Convert.ToInt32(costcategory.SelectedValue);
                String tteamMember = costEmp.SelectedValue;
                String tCostItem = costitem.SelectedValue;
                String tItemcategory = itemcategory.SelectedValue;
                String tItemcode = itemcode.SelectedValue;
                String tUom = uom.SelectedValue;
                String tSource = fundsource.SelectedValue;
                decimal tunitcost = Convert.ToDecimal(unitcost.Text);
                int tquantity = Convert.ToInt32(quantity.Text);
                string tdesc = costDescription.Text;

                if (flag)
                {
                    costfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.AddTrainingCost(docNo, tcostcategory, tunitcost, tquantity, tdesc, tCostItem, tItemcategory, tItemcode, tUom, tSource);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        costfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        costfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                costfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editteammemberbutton_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                String ttype = editType.SelectedValue;
                String tteamMember = editTeamMember.SelectedValue;
                int tteamNumberOfDays = Convert.ToInt32(editDays.Text);
                int LineNo = Convert.ToInt32(originalNo.Text);
                if (flag)
                {
                    teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.EditTrainingParticipants(LineNo, ttype, tteamMember, tteamNumberOfDays, docNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeteammember_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                int LineNo = Convert.ToInt32(originalNo.Text);
                if (flag)
                {
                    teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.DeleteTrainingParticipants(LineNo, docNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removecost_Click(object sender, EventArgs e)
        {
            try
            {
                String sms = "";
                Boolean flag = false;
                int LineNo = Convert.ToInt32(CostLineNumber.Text);
                if (flag)
                {
                    costfeedback.InnerHtml = "<div class='alert alert-danger'>" + sms + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String docNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.RemoveTrainingCost(docNo, LineNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        costfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        costfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                costfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Training Requisition/";
                String imprestNo = Request.QueryString["docNo"];
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
        }

        protected void txtgobacktostep3_Click1(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=3&&docNo=" + docNo);
        }

        protected void gotostep5_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("TrainingApplication.aspx?step=5&&docNo=" + docNo);
        }

        protected void itemcategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            string cat = itemcategory.SelectedValue;
            var titem = nav.Items.Where(x=> x.Item_Category_Code == cat && x.Blocked == false).ToList();
            itemcode.DataSource = titem;
            itemcode.DataValueField = "No";
            itemcode.DataTextField = "Description";
            itemcode.DataBind();
            txtcourseTitle.Items.Insert(0, "-- Select--");
        }
    }
}