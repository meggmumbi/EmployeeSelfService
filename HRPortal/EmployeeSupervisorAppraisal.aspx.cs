using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeSupervisorAppraisal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                var cpsplan = nav.CorporateStrategicPlan.Where(r => r.Implementation_Status == "Ongoing" && r.Approval_Status == "Released");
                strategicplanno.DataSource = cpsplan;
                strategicplanno.DataValueField = "Code";
                strategicplanno.DataTextField = "Description";
                strategicplanno.DataBind();

                var workplans = nav.PerfomanceContractHeader.Where(r => r.Document_Type == "Functional/Operational PC" && r.Approval_Status == "Released");
                funcionalworkplan.DataSource = workplans;
                funcionalworkplan.DataValueField = "No";
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataBind();

                var annualreportingcodes = nav.AnnualReporingCodes.Where(r => r.Current_Year == true);
                annualreportingcode.DataSource = annualreportingcodes;
                annualreportingcode.DataValueField = "Code";
                annualreportingcode.DataTextField = "Description";
                annualreportingcode.DataBind();

                string employeeno = Convert.ToString(Session["employeeNo"]);
                var pseronalsorecard = nav.PerfomanceContractHeader.Where(r => r.Document_Type == "Individual Scorecard" &&r.Status=="Signed" && r.Responsible_Employee_No == employeeno);
                personalscorecards.DataSource = pseronalsorecard;
                personalscorecards.DataValueField = "No";
                personalscorecards.DataTextField = "Description";
                personalscorecards.DataBind();

                var tasknumber = nav.PerformanceTasks.Where(r => r.Review_Periods != "" && r.Task_Category == "Performance Review");
                tasknumbers.DataSource = tasknumber;
                tasknumbers.DataValueField = "Task_Code";
                tasknumbers.DataTextField = "Description";
                tasknumbers.DataBind();

            }

        }
        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {

                string tstrategicplanno = strategicplanno.SelectedValue.Trim();
                string tfuncionalworkplan = funcionalworkplan.SelectedValue.Trim();
                string tannualreportingcode = annualreportingcode.SelectedValue.Trim();
                string tlastevaluationdate = lastevaluationdate.Text.Trim();
                string ttasknumber = tasknumbers.Text.Trim();
                string tpersonalscorecard = personalscorecards.Text.Trim();
                String status = Config.ObjNav.FnNewPerformanceAppraisalEntry(Convert.ToString(Session["employeeNo"]), tpersonalscorecard, tstrategicplanno, tfuncionalworkplan, tannualreportingcode);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    Session["IndividualCardNo"] = info[2];
                    generalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("EmployeeSupervisorAppraisal.aspx?step=1&&IndividualCardNo=" + info[2]);
                }
                else
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}