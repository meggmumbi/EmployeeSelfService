using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewRecordsRequisition : System.Web.UI.Page
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
                var filetypes = nav.FileTypes.ToList().OrderBy(r => r.Description);
                fileclassess.DataSource = filetypes;
                fileclassess.DataValueField = "Code";
                fileclassess.DataTextField = "Description";
                fileclassess.DataBind();

                editFileClass.DataSource = filetypes;
                editFileClass.DataValueField = "Code";
                editFileClass.DataTextField = "Description";
                editFileClass.DataBind();
                filterfileNumbertypes();
            }
        }
        protected void CreateFileRequest_Click(object sender, EventArgs e)
        {
            string EmpNumber = Session["employeeNo"].ToString().Trim();
            int tdaysrequested = Convert.ToInt32(daysrequested.Text.Trim());
            string message = "";
            bool error = false;
            try
            {
                if (tdaysrequested < 1)
                {
                    error = true;
                    message = "Please enter the Number of Days.This Cannot be 0 or Null";
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    var requestnumber = "";
                    string status = Config.ObjNav
                        .FnCreateNewFileRequsition(EmpNumber, tdaysrequested);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                          Response.Redirect("NewRecordsRequisition.aspx?step=2&&fileRequestNo=" + info[2]);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                   
                    }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
       
        protected void FileClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterfileNumbertypes();
        }
        public void filterfileNumbertypes()
        {
            var nav = new Config().ReturnNav();
            var myfileclass = fileclassess.SelectedValue;
            var myfiles = nav.RegistryFileNumbers.Where(r => r.File_Type == myfileclass);
             List<Employee> allfiles = new List<Employee>();
            foreach (var myJob in myfiles)
            {
                Employee employee = new Employee();
                employee.EmployeeNo = myJob.File_No;
                employee.EmployeeName = myJob.File_No + " - " + myJob.File_Name;
                allfiles.Add(employee);
            }
            filenumber.DataSource = allfiles;
            filenumber.DataValueField = "EmployeeNo";
            filenumber.DataTextField = "EmployeeName";
            filenumber.DataBind();


            editFileNumber.DataSource = myfiles;
            editFileNumber.DataSource = allfiles;
            editFileNumber.DataValueField = "EmployeeNo";
            editFileNumber.DataTextField = "EmployeeName";
            editFileNumber.DataBind();
        }
        protected void AddfileLines_Click(object sender, EventArgs e)
        {
            string tfileclassess = fileclassess.SelectedValue;
            string tfilenumber = filenumber.SelectedValue;
            string tfiledescription = filedescription.Text.Trim();
            string EmpNumber = Session["employeeNo"].ToString().Trim();
            string RequisitionNumber = Request.QueryString["fileRequestNo"];
            string message = "";
            bool error = false;
            try
            {
                if (tfiledescription.Length < 1)
                {
                    error = true;
                    message = "Please enter the File Description/Purpose";
                }
                if (tfileclassess.Length < 1)
                {
                    error = true;
                    message = "Please select the File Class";
                }
                if (tfilenumber.Length < 1)
                {
                    error = true;
                    message = "Please select the File Number";
                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = Config.ObjNav
                     .FnCreateNewFileRequsitionLines(EmpNumber, RequisitionNumber, tfileclassess, tfilenumber, tfiledescription);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }

                }
            }
            catch (Exception ex)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        protected void DeleteFile_Onclick(object sender, EventArgs e)
        {
            try
            {
                string tfileDocNumber = fileDocNumber.Text.Trim();
                int tlineNumber = Convert.ToInt32(lineNumber.Text.Trim());
                string status = Config.ObjNav
                          .DeleteFileMovementRecordLine(tfileDocNumber, tlineNumber);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String trequestNumber = Request.QueryString["fileRequestNo"];
                String status = Config.ObjNav.SendFileMovementforApproval( trequestNumber);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
             
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void Previous_Click(object sender, EventArgs e)
        {
            String tRequestNumber = Request.QueryString["fileRequestNo"];
            Response.Redirect("NewRecordsRequisition.aspx?step=2&&fileRequestNo=" + tRequestNumber);
        }

    }
}