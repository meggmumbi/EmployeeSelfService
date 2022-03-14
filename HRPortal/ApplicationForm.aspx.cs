using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using HRPortal.Models;

namespace HRPortal
{
    public partial class ApplicationForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                var jobId = "";
                if (Request.QueryString["id"] != null)
                {
                    jobId = Request.QueryString["id"].ToString();
                }
                else
                {
                     jobId = "";
                }
                

                if(Session["desc"] != null)
                {
                    appliedfor.Text = jobId + ":" + Session["desc"].ToString();

                }
                else
                {
                    appliedfor.Text = "";
                }
                
                IdNo.Text = Session["idNo"].ToString();
                personalNo.Text = Session["employeeNo"].ToString();
                getDepartments();
                getCounties();
                fillGrid();
                editApplication();
                updateAccomplishment();
                academicList();
                proffessionalList();
                proffessionabodyList();
                academicList();
                proffessionabodyList();
                proffessionalList();
                getCountries();
                getEthinicity();
                populateShortlistingCriteria();
                populateShortlistingCriteria1();


            }

        }
        protected void addQualification_Click(object sender, EventArgs e)
        {
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();
            string from = qualificationFrom.Text.ToString();
            string to = qualificationTo.Text.ToString();
            string company = institution.Text.ToString();
            string grade = gradeAttained.Text.ToString();
            string specialty = specialization.Text.ToString();
            string Attain = Attainment.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            DateTime date = new DateTime();
            DateTime date1 = new DateTime();
            Boolean error = false;
            Boolean error1 = false;
            String message = "";

            if(string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter Grade!";
            }
            if (string.IsNullOrEmpty(specialty))
            {
                error = true;
                message = "Please enter specializationn!";
            }
            if (string.IsNullOrEmpty(Attain))
            {
                error = true;
                message = "Please enter attainment!";
            }
            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

            if (date >= DateTime.Now.Date)
            {
                error = true;
                message = "Start Date cannot be greater or equal to today's date";
            }

            if (date1 >= DateTime.Now.Date)
            {
                error = true;
                message = "End Date cannot be greater or equal to today's date";
            }
            
            if (error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {

            

                try
            {
                var status = Config.ObjNav.AddAcademicQualifications(appNo, company, Attain, specialty, grade,
                   empNo, jobId, date, date1);
                if(status=="success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='success' aria-label='close'>&times;</a></div>";
                    
                }
                

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '"+t.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
           


            }

            }



        }
        protected void addProfession_Click(object sender, EventArgs e)
        {
            
            string jobId = Request.QueryString["id"].ToString();
            string from = prof_startDate.Text.ToString();
            string to = prof_endDate.Text.ToString();
            string company = prof_institution.Text.ToString();
            string grade = attainedScore.Text.ToString();
            string spec = pr_Specialization.Text.ToString();
            string attainment = pr_attainment.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
           

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";
            Boolean error1 = false;

            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(spec))
            {
                error = true;
                message = "Please enter Specialization!";
            }
            if (string.IsNullOrEmpty(attainment))
            {
                error = true;
                message = "Please enter attainment!";
            }
            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

            if (date >= DateTime.Now.Date)
            {
                error = true;
                message = "Start Date cannot be greater or equal to today's date";
            }

            if (date1 >= DateTime.Now.Date)
            {
                error = true;
                message = "End Date cannot be greater or equal to today's date";
            }

            if (error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            { 
           

                try
            {
                var status = Config.ObjNav.AddProffessionalQualifications(appNo, company, attainment, spec, grade, empNo, jobId, date, date1);
                if(status=="success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            
            }
            }

        }
        protected void addTraining_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();
            string from = tr_StartDate.Text.ToString();
            string to = tr_EndDate.Text.ToString();
            string company = tr_institution.Text.ToString();
            string grade = tr_score.Text.ToString();
            string coursename = tr_courseName.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string attained = tr_score.Text.ToString();

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";


            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter grade!";
            }
            if (string.IsNullOrEmpty(coursename))
            {
                error = true;
                message = "Please enter coursename!";
            }

            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

            if (date >= DateTime.Now.Date)
            {
                error = true;
                message = "Start Date cannot be greater or equal to today's date";
            }

            if (date1 >= DateTime.Now.Date)
            {
                error = true;
                message = "End Date cannot be greater or equal to today's date";
            }


            if (error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            { 

           
                try
            {
                var status = Config.ObjNav.AddTrainingAttended(date, date1,jobId,empNo, company, coursename,appNo,attained);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }

            }

        }
        protected void addMembership_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();
            string p_body = m_body.Text.ToString();
            string reg_no = m_regNo.Text.ToString();
            string renewalDate = m_DateofRenewal.Text.ToString();
            string mType = m_Membershiptype.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            DateTime date = new DateTime();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(p_body))
            {
                error = true;
                message = "Please enter body!";
            }
            if (string.IsNullOrEmpty(reg_no))
            {
                error = true;
                message = "Please enter registration number!";
            }
            if (string.IsNullOrEmpty(renewalDate))
            {
                error = true;
                message = "Please enter renewal date!";
            }
            if (string.IsNullOrEmpty(mType))
            {
                error = true;
                message = "Please enter membership type!";
            }

            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {

            


            if (!String.IsNullOrEmpty(renewalDate))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(renewalDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

                if (date > DateTime.Now.Date)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'> Renewal Date cannot be greater  than today's date  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2", false);
                }


                try
            {
                var status = Config.ObjNav.AddProfessionalBody(appNo, jobId, empNo, p_body, reg_no,mType, date);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  DataBind successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               
            }

            }
          }
        protected void addEmploymentHistory_Click(object sender, EventArgs e)
        {
            
            string jobId = Request.QueryString["id"].ToString();
            string from = em_StartDate.Text.ToString();
            string to = em_EndDate.Text.ToString();
            string company = em_institution.Text.ToString();
            string position = em_positionHeld.Text.ToString();
            string grade = em_JobGrade.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string idNo = Session["idNo"].ToString();

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";

            
            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }

            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter company!";
            }
            if (string.IsNullOrEmpty(position))
            {
                error = true;
                message = "Please enter position!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter grade!";
            }


            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

            if (date >= DateTime.Now.Date)
            {
                error = true;
                message = "Start Date cannot be greater or equal to today's date";
            }

            if (date1 >= DateTime.Now.Date)
            {
                error = true;
                message = "End Date cannot be greater or equal to today's date";
            }

            if (error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {


                try
                {
                var status = Config.ObjNav.AddEmploymentHistory(idNo,date, date1,company, position, grade,appNo,empNo,jobId);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
        }
    }
 
        protected void addReferee_Click(object sender, EventArgs e)
        {
            string name = ref_name.Text.ToString();
            string occupation = ref_Occupation.Text.ToString();
            string address = ref_Address.Text.ToString();
            string postcode = ref_Postcode.Text.ToString();
            string city = ref_City.Text.ToString();
            string email = ref_EmailAddress.Text.ToString();
            string period = ref_period.Text.ToString();
            string phone = ref_phone.Text.ToString();
            string jobId = Request.QueryString["id"].ToString();

            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string idNo = Session["idNo"].ToString();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(name))
            {
                error = true;
                message = "Please enter your name!";
            }
            if (string.IsNullOrEmpty(occupation))
            {
                error = true;
                message = "Please enter occupation!";
            }
            if (string.IsNullOrEmpty(address))
            {
                error = true;
                message = "Please enter address!";
            }
            if (string.IsNullOrEmpty(postcode))
            {
                error = true;
                message = "Please enter postcode!";
            }
            if (string.IsNullOrEmpty(city))
            {
                error = true;
                message = "Please enter city!";
            }
            if (string.IsNullOrEmpty(email))
            {
                error = true;
                message = "Please enter email!";
            }
            if (string.IsNullOrEmpty(period))
            {
                error = true;
                message = "Please enter period!";
            }
            if (string.IsNullOrEmpty(phone))
            {
                error = true;
                message = "Please enter phone!";
            }

            if(error == true)
            {
                referee.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.CreateReferee(appNo, empNo, name, occupation, address, 
                    postcode, phone, email, period, jobId);
                if (status == "success")
                {
                    referee.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                referee.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
              
            }

            }
        }
        
        protected void AddDetails_Click(object sender, EventArgs e)
        {
            //int step;
            string jobId = Request.QueryString["id"].ToString();
            string surname = Surname.Text.ToString();
            string firstname = Firstname.Text.ToString();
            string lastname = Lastname.Text.ToString();
            string title = txtTitle.Text.ToString();
            string phone = PhoneNo.Text.ToString();
            string altPhone = alt_PhoneNo.Text.ToString();
            string email = Email.Text.ToString();
            string altEmail = alt_Email.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string dpt = Center.SelectedValue.ToString();
            string DateOfBirth = DOB.Text.ToString();
            int gendr = Convert.ToInt32(Gender.SelectedValue.ToString());
            string ethnic = Ethnicity.SelectedValue.ToString();
            int disable = Convert.ToInt32(disability.SelectedValue.ToString());
            string regNo = registrationNo.Text.ToString();
            //string regDate = registrationDate.Text.ToString();
            string cnty = County.SelectedValue.ToString();
            string nty = txtNationality.SelectedValue.ToString();
            string relign = religion.Text.ToString();
            int mStatus = Convert.ToInt32(Maritalstatus.SelectedValue.ToString());
            string IdNumber = Session["idNo"].ToString();
            string nhf = nhif.Text.ToString();
            string nsf = NSSF.Text.ToString();
            string txtPin = pinNo.Text.ToString();
            string crntPosition = currentPost.Text.ToString();
            string jgroup = jobGr.Text.ToString();
            string firstAppointmentDate =firstofDateappointment.Text.ToString();
            string lpromotionDate = Dateofcurrentappointment.Text.ToString();
            DateTime date = new DateTime();
            DateTime date1 = new DateTime();
            DateTime date2 = new DateTime();
            Boolean error = false;
            string Jdescription = "";

                  //var nav = new Config().ReturnNav();
                  //var positions = nav.VacantPositions.Where(r=>r.Job_ID == jobId);
                  //  foreach (var position in positions)
                  //  {
                  //   Jdescription = position.Job_Description;
                  //  }

            String message = "";
            if(disable == 0 && string.IsNullOrEmpty(regNo))
            {
                error = true;
                message = "Details of registration with the national council must be filled";
            }

            if(string.IsNullOrEmpty(surname))
            {
                error = true;
                message = "please enter surname";
            }
            if (string.IsNullOrEmpty(firstname))
            {
                error = true;
                message = "please enter firstname";
            }
            if (string.IsNullOrEmpty(lastname))
            {
                error = true;
                message = "please enter lastname";
            }
            if (string.IsNullOrEmpty(title))
            {
                error = true;
                message = "please enter title";
            }
            if (string.IsNullOrEmpty(phone))
            {
                error = true;
                message = "please enter phone number";
            }
            if (string.IsNullOrEmpty(email))
            {
                error = true;
                message = "please enter your email";
                //DateOfBirth
            }
            if (string.IsNullOrEmpty(DateOfBirth))
            {
                error = true;
                message = "please enter your date of birth";
            }
            if (string.IsNullOrEmpty(ethnic))
            {
                error = true;
                message = "please enter your ethnic";
            }
           
            if (string.IsNullOrEmpty(nty))
            {
                error = true;
                message = "please enter your nationality";
            }
            if (string.IsNullOrEmpty(relign))
            {
                error = true;
                message = "please enter your religion";
            }
            if (string.IsNullOrEmpty(nhf))
            {
                error = true;
                message = "please enter your NHIF number";
            }
            if (string.IsNullOrEmpty(nsf))
            {
                error = true;
                message = "please enter your NSSF number";
            }
            if (string.IsNullOrEmpty(txtPin))
            {
                error = true;
                message = "please enter your pin number";
            }
            if (string.IsNullOrEmpty(crntPosition))
            {
                error = true;
                message = "please enter your current position";
            }
            if (string.IsNullOrEmpty(jgroup))
            {
                error = true;
                message = "please enter your job group";
            }
            if (string.IsNullOrEmpty(firstAppointmentDate))
            {
                error = true;
                message = "please enter your first appointment date";
            }
            if (string.IsNullOrEmpty(lpromotionDate))
            {
                error = true;
                message = "please enter your last promotion date";
            }
            if (!String.IsNullOrEmpty(DateOfBirth))
            {
                // CultureInfo culture = new CultureInfo("en-US");
                CultureInfo culture = new CultureInfo("ru-RU");
                // date = DateTime.Parse(DateOfBirth, usCulture.DateTimeFormat);
                date = DateTime.ParseExact(DateOfBirth, "d/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(firstAppointmentDate))
            {
                // CultureInfo culture = new CultureInfo("en-US");
                CultureInfo culture = new CultureInfo("ru-RU");
               // date1 = DateTime.Parse(firstAppointmentDate, usCulture.DateTimeFormat);

                date1 = DateTime.ParseExact(firstAppointmentDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(lpromotionDate))
            {
                CultureInfo culture = new CultureInfo("ru-RU");
                //CultureInfo usCulture = new CultureInfo("en-US");
                //date2 = DateTime.Parse(lpromotionDate, usCulture.DateTimeFormat);
                date2 = DateTime.ParseExact(lpromotionDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (error == true)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
         try
            {

                if (altEmail == "")
                {
                    altEmail = "";
                }
                else if (altPhone == "")
                {
                    altPhone = "";

                }
                else if (regNo == "")
                {
                    regNo = "";

                }
                
               

                if(date >= DateTime.Now.Date)
                {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Date Of Birth cannot be greater or equal to today's date  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationForm.aspx?id=" + jobId, false);
                    }
                    if (date1 >= DateTime.Now.Date)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'> First Appointment Date cannot be greater or equal to today's date  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationForm.aspx?id=" + jobId, false);
                    }

                    if (date1 >= DateTime.Now.Date)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'> Last promotion date cannot be greater or equal to today's date  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationForm.aspx?id=" + jobId, false);
                    }


                }
            catch (Exception)
            {

                throw ;
            }


            try
            {
                    var reqNo = Session["Req_No"].ToString();
                    var docNo = "";
                    //var status = Config.ObjNav.ApplyinternalHrJobs(docNo, jobId, surname, firstname, lastname,
                    //   title, Convert.ToDateTime(DateOfBirth), gendr, disable,
                    //   regNo, cnty, nty, mStatus, relign, IdNumber, nhf, nsf, txtPin, phone, altPhone,
                    //  email, altEmail, empNo, dpt, crntPosition, jgroup,
                    // Convert.ToDateTime(firstAppointmentDate), Convert.ToDateTime(lpromotionDate), ethnic, reqNo);
                    var status = Config.ObjNav.ApplyinternalHrJobs(docNo, jobId, surname, firstname, lastname,
                        title, date, gendr, disable,
                        regNo, cnty, nty, mStatus, relign, IdNumber, nhf, nsf, txtPin, phone, altPhone,
                       email, altEmail, empNo, dpt, crntPosition, jgroup,
                       date1, date2, ethnic, reqNo);

                    string[] info = status.Split('*');
                    

                    if (info[0] != "danger" || info[0] != "error")
                {
                    Session["appNo"] = status;
                    feedback.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2",false);

                }
                else
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'> An error occured during the process of saving.Please try again.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationForm.aspx?id=" + jobId, false);

                }

            }
            catch (Exception t)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               

            }

            }
            //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2");

            //Response.Redirect("ApplicationForm.aspx?id="+ jobId);
        }

        protected void Step2_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");

        }
        public void getDepartments()
        {
            
            var nav = new Config().ReturnNav();
            var dpt = nav.ResponsibilityCenters.ToList();
            Center.DataSource = dpt;
            Center.DataValueField = "Code";
            Center.DataTextField = "Name";
            Center.DataBind();


        }
        public void getCounties()
        {
            var nav = new Config().ReturnNav();
            var counties = nav.Locations.ToList();
            County.DataSource = counties;
            County.DataValueField = "Code";
            County.DataTextField = "Name";
            County.DataBind();

        }
        public void getCountries()
        {
            var nav = new Config().ReturnNav();
            var countries = nav.Country.ToList();

            txtNationality.Items.Clear();
            txtNationality.SelectedIndex = -1;
            txtNationality.SelectedValue = null;
            txtNationality.ClearSelection();
            txtNationality.DataSource = countries;
            txtNationality.DataValueField = "Name";
            txtNationality.DataTextField = "Name";
            txtNationality.DataBind();
        }

        public void getEthinicity()
        {
            var nav = new Config().ReturnNav();
            var ethinicities = nav.EthincQuery.ToList();
            
            Ethnicity.Items.Clear();
            Ethnicity.SelectedIndex = -1;
            Ethnicity.SelectedValue = null;
            Ethnicity.ClearSelection();

            Ethnicity.DataSource = ethinicities;
            Ethnicity.DataValueField = "Code";
            Ethnicity.DataTextField = "Code";
            Ethnicity.DataBind();
        }

        protected void Step3_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=4");
         }

        protected void Step4_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=5");


        }

        protected void Step5_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();

            var appNo = Session["appNo"].ToString();
            

            var declare = Declare1.SelectedValue.ToString();
            Session["declare"] = declare;
            string message = "";
            Boolean decl = false;
            if (declare == "0")
            {
                decl = true;

            }
            else
            {
                decl = false;
                
            }
            if(decl == false)
            {
                message = "Declaration must be set true";
                referee.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    var status = Config.ObjNav.AddDeclaration(decl, appNo);
                    if (status == "success")
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=6");
                    }

                }
                catch (Exception t)
                {

                    referee.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
           

            

            


        }

        protected void SaveOtherPersonalDetails_Click(object sender, EventArgs e)
        {
            
            var jobId = Request.QueryString["id"].ToString();
            string convicted = convict.SelectedValue.ToString();
            string period = duration.Text.ToString();
            string dismiss = Dismissed.Text.ToString();
            string reason = dismissalReasons.Text.ToString();
            string highestLevel = txt_highestLevel.SelectedValue.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            Boolean dism = false;
            Boolean conv = false;
            Boolean error = false;
            String message = "";

            if (convicted == "0" && string.IsNullOrEmpty(period))
            {
                error = true;
                message = "Please state nature of offense, year and duration";
            }
            if (dismiss == "0" && string.IsNullOrEmpty(reason))
            {
                error = true;
                message = "Please state reason(s) for dismissal/removal";
            }

            if (string.IsNullOrEmpty(highestLevel))
            {
                error = true;
                message = "Please enter highest level!";
            }

            if(error == true)
            {
                otherPersonalDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }else
            {
                
            if (dismiss == "0")
            {
                dism = true;
            }
            else if(dismiss == "1")
            {
                dism = false;
            }else if(convicted =="0")
            {
                conv = true;

            }
            else if(convicted =="1")
            {
                conv = false;

            }

            try
            {
                var status = Config.ObjNav.AddOtherPersonalDetails(appNo,conv, period, dism, reason, highestLevel);
                if (status == "success")
                {
                    otherPersonalDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                 
                }

            }
            catch (Exception t)
            {

                    otherPersonalDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
            }
        }

        protected void AddAbility_Click(object sender, EventArgs e)
        {
            string ability = txtComment.Text.ToString();
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();
            string p_accomplishment = professionalAccomplishment.Text.ToString();

            Boolean error = false;
            String message = "";
            if(string.IsNullOrEmpty(ability))
            {
                error = true;
                message = "please enter your abilities";

            }
            if (string.IsNullOrEmpty(p_accomplishment))
            {
                error = true;
                message = "please enter your proffessional accomplishment";

            }

            if (error == true)
            {
                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }else
            {
                
            try
            {
                var status = Config.ObjNav.AddAbilityDetails_Accomplishment(ability,appNo, p_accomplishment);
                if (status == "success")
                {
                    jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                    jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
            }

            }

        }

        protected void AddDuties_Click(object sender, EventArgs e)
        {
            string duties = TextArea.Text.ToString();
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();

            Boolean error = false;
            String message = "";
            if (string.IsNullOrEmpty(duties))
            {
                message = "Please enter your abilities";

            }
            if (error == true)
            {
                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.AddDutiesDetails(duties, appNo);
                if (status == "success")
                {
                    jobDetails.InnerHtml = "<div class='alert alert-success'>  Duties successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                    jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               // Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");
            }


            }
        }
        protected void AddAccomplishment1_Click(object sender, EventArgs e)
        {
            try
            {
                string jobId = Request.QueryString["id"].ToString();
                string appNo = Session["appNo"].ToString();

                foreach (GridViewRow row in grd_accomplishment1.Rows)
                {
                    string Description = ((TextBox)row.FindControl("txtDescription1")).Text;
                    int number = Convert.ToInt32(((TextBox)row.FindControl("Number")).Text);
                    string amt = ((TextBox)row.FindControl("Amount")).Text;
                    string empNo = Session["employeeNo"].ToString();



                    if (number != 0)
                    {
                        try
                        {
                            var status = Config.ObjNav.AddApplicantAccomplishment(appNo, empNo, Description, number, jobId, amt);
                            string[] info = status.Split('*');
                            if (info[0] == "success")
                            {
                                //jobDetails1.InnerHtml = "<div class='alert alert-success'>  '"+ info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                        catch (Exception t)
                        {

                            jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
                        }


                    }
                }
                jobDetails.InnerHtml = "<div class='alert alert-success'>  Data updated successfully <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                updateAccomplishment();
            }
            catch (Exception  ex)
            {

                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            





        }

        protected void AddAccomplishment_Click(object sender, EventArgs e)
        {
            try
            {
                string jobId = Request.QueryString["id"].ToString();

                foreach (GridViewRow row in grd_accomplishment.Rows)
                {
                    string Description = ((TextBox)row.FindControl("txtDescription")).Text;
                    int number = Convert.ToInt32(((TextBox)row.FindControl("txtNumber")).Text);
                    string empNo = Session["employeeNo"].ToString();
                    string appNo = Session["appNo"].ToString();
                    string amt = ((TextBox)row.FindControl("txtAmount")).Text;
                    if (number != 0)
                    {
                        try
                        {
                            var status = Config.ObjNav.AddApplicantAccomplishment(appNo, empNo, Description, number, jobId, amt);
                            if (status == "success")
                            {
                                jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                        catch (Exception t)
                        {

                            jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
                        }


                    }
                }
                jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                updateAccomplishment();
            }
            catch (Exception m)
            {

                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + m.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
           
         





        }
        private void editApplication()
        {
            try
            {
                var appno = "";
                string jobId = "";
                string empNo = "";

                if(Session["employeeNo"] != null)
                {
                    empNo = Session["employeeNo"].ToString();
                }

                
                if (Request.QueryString["appNo"] !=null)
                {
                    appno = Request.QueryString["appNo"].ToString();
                }

                if(Request.QueryString["id"] != null)
                {
                    jobId = Request.QueryString["id"].ToString();
                }
                var reqNo = "";

                if (Session["Req_No"] != null)
                {
                     reqNo = Session["Req_No"].ToString();
                }
                

                //var appno = Request.QueryString["appNo"].ToString();
                var nav = new Config().ReturnNav();
                var positions = nav.MyJobApplications.Where(r => r.Employee_No == empNo && r.Job_Applied_For == jobId && r.Employee_Requisition_No== reqNo).ToList();
                foreach (var item in positions)
                {
                    appliedfor.Text = item.Job_Applied_For;
                    Surname.Text = item.First_Name;
                    Firstname.Text = item.Middle_Name;
                    Lastname.Text = item.Last_Name;
                    txtTitle.Text = item.Initials;
                    PhoneNo.Text = item.Cell_Phone_Number;
                    alt_PhoneNo.Text = item.Altenative_Phone_Number;
                    Email.Text = item.E_Mail;
                    alt_Email.Text = item.Alternative_Email;
                    personalNo.Text = item.Employee_No;
                    Center.Text = item.Department_Code;
                    DOB.Text = Convert.ToDateTime(item.Date_Of_Birth).ToString("dd/MM/yyyy");

                    if (item.Gender == "Male")
                    {
                        Gender.Text = "0";
                    }
                    else if (item.Gender == "Female")
                    {
                        Gender.Text = "1";
                    }
                    else if (item.Gender == "Both")
                    {
                        Gender.Text = "2";
                    }
                    Ethnicity.Text = item.Ethnic_Origin;
                    if (item.Disabled == "No")
                    {
                        disability.Text = "1";
                    }
                    else if (item.Disabled == "Yes")
                    {
                        disability.Text = "0";
                    }

                    /// disability1.Text = item.Disabled;

                    registrationNo.Text = item.Disability_Details;

                    County.Text = item.County;
                    txtNationality.Text = item.Citizenship;
                    religion.Text = item.Religion;
                    //professionalAccomplishment.Text = item.Professional_Accomplishment;
                    professionalAccomplishment.Text = item.Professional_Accomplishment;

                    if (item.Marital_Status == "Married")
                    {
                        Maritalstatus.Text = "0";
                    }
                    else if (item.Marital_Status == "Single")
                    {
                        Maritalstatus.Text = "1";
                    }
                    else if (item.Marital_Status == "Divorced")
                    {
                        Maritalstatus.Text = "2";
                    }
                    else if (item.Marital_Status == "Separated")
                    {
                        Maritalstatus.Text = "3";
                    }
                    else if (item.Marital_Status == "Widow(er)")
                    {
                        Maritalstatus.Text = "4";
                    }
                    else if (item.Marital_Status == "Other")
                    {
                        Maritalstatus.Text = "5";
                    }

                    IdNo.Text = item.ID_Number;
                    nhif.Text = item.NHIF;
                    NSSF.Text = item.NSSF;
                    pinNo.Text = item.PIN_Number;
                    currentPost.Text = item.Position_held;
                    jobGr.Text = item.Job_Group;
                    firstofDateappointment.Text = Convert.ToDateTime(item.First_Appointment_Date).ToString("dd/MM/yyyy");
                    Dateofcurrentappointment.Text = Convert.ToDateTime(item.Last_Appointment_Date).ToString("dd/MM/yyyy");

                    //firstofDateappointment.Text = Convert.ToDateTime(item.First_Appointment_Date).ToString("dd/MM/yyyy");
                    //Dateofcurrentappointment.Text = Convert.ToDateTime(item.Last_Appointment_Date).ToString("dd/MM/yyyy");

                    //SaveOtherPersonalDetails1_Click

                    if (item.Convicted == true)
                    {
                        convict.Text = "0";
                    }
                    else if (item.Convicted == false)
                    {
                        convict.Text = "1";
                    }
                    if (item.Dismissal == true)
                    {
                        Dismissed.Text = "0";
                    }
                    else if (item.Dismissal == false)
                    {
                        Dismissed.Text = "1";
                    }

                    duration.Text = item.Conviction_Description;

                    dismissalReasons.Text = item.Dismissal_Description;
                    txt_highestLevel.Text = item.Highest_Education_Level;

                    Declare1.Text = item.Declaralation.ToString();

                    //AddAbility1
                    txtComment.Text = item.Abilites_Skills;

                    //AddDuties1
                    TextArea.Text = item.Current_Duties;

                    //AddAccomplishment1_Click


                    if (item.Declaralation == true)
                    {
                        Declare1.Text = "0";
                    }
                    else if (item.Declaralation == false)
                    {
                        Declare1.Text = "1";
                    }







                }

            }
            catch (Exception)
            {

                throw;
            }
        }

        public void fillGrid()
        {
            // grd_accomplishment
            var nav = new Config().ReturnNav();
            var hrAccomplishment = nav.HrApplicantAccomplishment.ToList();
            grd_accomplishment.DataSource = hrAccomplishment;
            grd_accomplishment.DataBind();
       }

        protected void populateShortlistingCriteria()
        {
            try
            {
                var reqNo = Session["Req_No"].ToString();
                var appNo = Session["appNo"].ToString();
                var nav = new Config().ReturnNav();

                var query = nav.ShortListingCritea.Where(x => x.Job_App_No == appNo && x.Requisition_No == reqNo).ToList();
                shortlistingCriteria.DataSource = query;
                shortlistingCriteria.DataBind();

            }
            catch (Exception e)
            {

                referee.InnerHtml = "<div class='alert alert-danger'>'"+e.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void populateShortlistingCriteria1()
        {
            try
            {
                var reqNo = Session["Req_No"].ToString();
                var appNo = Session["appNo"].ToString();
                var nav = new Config().ReturnNav();

                var query = nav.ShortListingCritea.Where(x => x.Job_App_No == appNo && x.Requisition_No == reqNo && x.Check== true).ToList();
                ShortListingCriteria1.DataSource = query;
                ShortListingCriteria1.DataBind();

            }
            catch (Exception e)
            {

                referee.InnerHtml = "<div class='alert alert-danger'>'" + e.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void academicList()
        {
            var nav = new Config().ReturnNav();
            var query = nav.Qualifications.Where(x => x.Type == "Educational");
            Attainment.DataTextField = "Description";
            Attainment.DataValueField = "Code";
            Attainment.DataSource = query;
            Attainment.DataBind();
            //pr_attainment
        }
        protected void proffessionalList()
        {
            var nav = new Config().ReturnNav();
            //var query = nav.Qualifications.Where(x => x.Type == "Educational");
            var query = nav.Qualifications.Where(x => x.Type == "Professional").ToList();
            pr_attainment.DataTextField = "Description";
            pr_attainment.DataValueField = "Code";
            pr_attainment.DataSource = query;
            pr_attainment.DataBind();
        }
        protected void proffessionabodyList()
        {
            var nav = new Config().ReturnNav();
            m_body.DataTextField = "Description";
            m_body.DataValueField = "Code";
            var query = nav.Qualifications.Where(x => x.Type == "Body").ToList();
            m_body.DataSource = query;
            m_body.DataBind();
        }

        protected void updateAccomplishment()
        {
            string appNo = "";
            if (Session["appNo"] == null)
            {
                appNo = "";
            }
            else
            {

                 appNo = Session["appNo"].ToString();
            }
            var nav = new Config().ReturnNav();
            var hrAccomplishment = nav.ApplicantAccomplishment.Where(x => x.Job_Application_No == appNo).ToList();
            foreach (var item in hrAccomplishment)
            {
                string desc = item.Indicator_Description;
                int number = Convert.ToInt32(item.Number);
            }
            grd_accomplishment1.DataSource = hrAccomplishment;
            grd_accomplishment1.DataBind();




        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (document.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = document.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        //HttpFileCollection hfc = Request.Files;
                        //for (int i = 0; i < hfc.Count; i++)
                        //{
                        //    HttpPostedFile hpf = hfc[i];
                            //foreach (HttpPostedFile postFiles in document.PostedFiles)
                            //{
                            if (Directory.Exists(filesFolder))
                            {
                                String extension = System.IO.Path.GetExtension(document.FileName);
                                if (new Config().IsAllowedExtension(extension))
                                {
                                    String appNo = Session["appNo"].ToString(); ;
                                    String documentDirectory = filesFolder + appNo + "/";
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
                                                Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                       // }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

           

        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";
               
                String appNo = Session["appNo"].ToString();
                String documentDirectory = filesFolder + appNo + "/";
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

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=1"+"JobNo="+ appNo);
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("JobDetails.aspx?id=" + jobId);

        }

        protected void GoBack1_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=1");

        }

        protected void GoBack2_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2");

        }

        protected void GoBack3_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");

        }

        protected void GoBack4_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=4");

        }

        protected void GoBack5_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=5");

        }

        protected void Finish_Click(object sender, EventArgs e)
        {
            string appNo = Session["appNo"].ToString();
          Session["finish"] = "<div class='alert alert-success'> Application submitted successfully<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            

            Response.Redirect("myapplications.aspx");
          
        }


        protected void DeleteQualification_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Code.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteAcademicLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteProfessional_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(PCode.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteProfessionalLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteTraining_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(TCode.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteTrainingLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeletePBody_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(BCode.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteProffessionalBodyLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteEmployment_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(ECode.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteEmploymentHistoryLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteRef_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(RCode.Text);
            var appNo = Session["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteRefereeLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    referee.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   // Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=5", false);
                     //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2",false);
                }


            }
            catch (Exception t)
            {

                referee.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void grd_accomplishment1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string id = grd_accomplishment1.SelectedRow.Cells[0].Text;
                var appNo = Session["appNo"].ToString();
                var status = Config.ObjNav.DeleteAccomplishment(Convert.ToInt32(id), appNo);
                string[] info = status.Split('*');
                if(info[0] == "success")
                {
                    jobDetails.InnerHtml = "<div class='alert alert-success'>'"+info[1]+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    updateAccomplishment();
                }


            }
            catch (Exception ex)
            {
                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void UploadHelbDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadHelbDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadHelbDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadHelbDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadHelbDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadHelbDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }


        }

        protected void UploadKRADocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadKRADoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadKRADoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadKRADoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadKRADoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadKRADoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadCRBDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadCRBDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadCRBDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadCRBDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadCRBDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadCRBDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadEACCDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadEACCDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadEACCDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadEACCDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadEACCDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadEACCDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadCVDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadCVDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadCVDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadCVDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadCVDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =  "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadCVDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }
        

        protected void UploadCoverLetterDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadCoverLetterDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadCoverLetterDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadCoverLetterDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadCoverLetterDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadCoverLetterDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadAcademicDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadAcademicDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadAcademicDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadAcademicDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadAcademicDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadAcademicDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadProfessionalMembershipDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadProfessionalMembershipDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadProfessionalMembershipDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadProfessionalMembershipDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadProfessionalMembershipDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadProfessionalMembershipDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadProffessionalDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadProffessionalDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadProffessionalDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadProffessionalDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadProffessionalDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadProffessionalDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        protected void UploadPublicationDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (UploadPublicationDoc.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = UploadPublicationDoc.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        if (Directory.Exists(filesFolder))
                        {
                            String extension = System.IO.Path.GetExtension(UploadPublicationDoc.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                String appNo = Session["appNo"].ToString(); ;
                                String documentDirectory = filesFolder + appNo + "/";
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
                                    string filename = documentDirectory + UploadPublicationDoc.FileName;
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    else
                                    {
                                        UploadPublicationDoc.SaveAs(filename);
                                        if (File.Exists(filename))
                                        {
                                            Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }


        protected void ShortListingCriteria1_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                foreach (GridViewRow row in ShortListingCriteria1.Rows)
                {
                    string entryNo = ((TextBox)row.FindControl("txtEntryNo1")).Text;

                    string reqNo = ((TextBox)row.FindControl("txtReqNo1")).Text;
                    string appNo = ((TextBox)row.FindControl("txtAppNo1")).Text;

                    CheckBox check = (CheckBox)row.FindControl("txtCheckBox1");

                    if (!check.Checked)
                    {
                        var status = Config.ObjNav.DeleteChecklistCriteria(reqNo, appNo, Convert.ToInt32(entryNo));
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            populateShortlistingCriteria1();
                            //jobDetails1.InnerHtml = "<div class='alert alert-success'>  '"+ info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                    }

                }

                
                referee.InnerHtml = "<div class='alert alert-success'>  Data updated successfully <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



            }
            catch (Exception ex)
            {

                referee.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            
        }

        protected void ShortListingCriteriaButton_Click(object sender, EventArgs e)
        {
            try
            {

                foreach (GridViewRow row in shortlistingCriteria.Rows)
                {
                    string entryNo = ((TextBox)row.FindControl("txtEntryNo")).Text;

                    string reqNo = ((TextBox)row.FindControl("txtReqNo")).Text;
                    string appNo = ((TextBox)row.FindControl("txtAppNo")).Text;

                    CheckBox check = (CheckBox)row.FindControl("txtCheckBox");

                    if (check.Checked)
                    {
                        var status = Config.ObjNav.UpdateChecklistCriteria(reqNo, appNo, Convert.ToInt32(entryNo));
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            //jobDetails1.InnerHtml = "<div class='alert alert-success'>  '"+ info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                    }
                }
                populateShortlistingCriteria1();
                referee.InnerHtml = "<div class='alert alert-success'>  Data updated successfully <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                

            }
            catch (Exception ex)
            {

                referee.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }




           

        }
    }
}