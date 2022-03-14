using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TransportRequisitionTrips : System.Web.UI.Page
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
                var employees = nav.Employees.ToList().OrderBy(r => r.First_Name);
                List<Employee> allemployees = new List<Employee>();
                foreach (var employee in employees)
                {
                    Employee generalemployee = new Employee();
                    generalemployee.EmployeeNo = employee.No;
                    generalemployee.EmployeeName = employee.No+" "+ employee.First_Name+" "+ employee.Middle_Name+ " " + employee.Last_Name;
                    allemployees.Add(generalemployee);
                }
                authorizedby.DataSource = allemployees;
                authorizedby.DataValueField = "EmployeeNo";
                authorizedby.DataTextField = "EmployeeName";
                authorizedby.DataBind();
            }
        }
        protected void Unnamed2_Click(object sender, EventArgs e)
        {
           string  requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("TransportRequisitionTrips.aspx?step=2&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed3_Click(object sender, EventArgs e)
        {
            string requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("TransportRequisitionTrips.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void next_Click(object sender, EventArgs e)
        {
            var emp = "";
            if (Session["employeeNo"] != null)
            {
                emp = Session["employeeNo"].ToString();
            }
            string tdetailsofjourney = detailsofjourney.Text.Trim();
            int tkilometers =Convert.ToInt32(kilometers.Text.Trim());
            int toildrwan = Convert.ToInt32(oildrwan.Text.Trim());
            int tfueldrawn = Convert.ToInt32(fueldrawn.Text.Trim());
            string tvoucherno = voucherno.Text.Trim();
            decimal topsodometer =Convert.ToDecimal(opsodometer.Text.Trim());
            decimal tendodometer =Convert.ToDecimal( endodometer.Text.Trim());
            string tauthorizedby = authorizedby.SelectedValue;
            String ttripdate = tripdate.Text.Trim();
            DateTime mytripdate = new DateTime();
            mytripdate = DateTime.ParseExact(ttripdate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            String requisitionNo = "";
            try
            {
                requisitionNo = Request.QueryString["requisitionNo"];
                if (String.IsNullOrEmpty(requisitionNo))
                {
                    requisitionNo = "";
                }
            }
            catch (Exception)
            {
                requisitionNo = "";
            }

            try
            {

                var status = Config.ObjNav.AddTripRequisitionDetails(Convert.ToString(Session["employeeNo"]), requisitionNo, tdetailsofjourney, tkilometers, toildrwan, tfueldrawn, tvoucherno, topsodometer, tendodometer, tauthorizedby);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    Response.Redirect("TransportRequisitionTrips.aspx?step=2&&requisitionNo=" + requisitionNo);


                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }
        protected void accidentDetails_Click(object sender, EventArgs e)
        {
            var emp = "";
            if (Session["employeeNo"] != null)
            {
                emp = Session["employeeNo"].ToString();
            }
            String taccidentdate = accidentdate.Text.Trim();
            DateTime myaccidentdate = new DateTime();
            myaccidentdate = DateTime.ParseExact(taccidentdate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            string taccidentdetails = accidentdetails.Text.Trim();
            string tpoliceabstract = policeabstract.Text.Trim();
            string tremarks = remarks.Text.Trim();
            String requisitionNo = "";
            try
            {
                requisitionNo = Request.QueryString["requisitionNo"];
                if (String.IsNullOrEmpty(requisitionNo))
                {
                    requisitionNo = "";
                }
            }
            catch (Exception)
            {
                requisitionNo = "";
            }

            try
            {

                var status = Config.ObjNav.AddTripAccidentDetails(Convert.ToString(Session["employeeNo"]), requisitionNo, myaccidentdate, taccidentdetails, tpoliceabstract, tremarks);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                 }else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }


            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }
        protected void deleteLineIncidents_Click(object sender, EventArgs e)
        {
            try
            {
                int tincidentdelete =Convert.ToInt32(incidentdelete.Text.Trim());
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                string requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.DeleteTripAccidentDetails(mEmployeeNo, requisitionNo, tincidentdelete);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                String requisitionNo = Request.QueryString["requisitionNo"];
                String empNo = Session["employeeNo"].ToString();
                String status = Config.ObjNav.SubmitVehicleMaintenanceRequestDetails(empNo, requisitionNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("OpenTransportRequisitionTrips.aspx");
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}