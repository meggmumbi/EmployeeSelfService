using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class BrQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<SurveyResponse> cmpitems)
        {
            string tSurveyNo = "", tOptionResponse = "", tGeneralResponse = "";
            string results_0 = (dynamic)null;
            int tQuestion = 0;
            try
            {

                //Check for NULL.
                //if (cmpitems == null)
                //    cmpitems = new List<SurveyResponse>();

                //Loop and insert records.
                foreach (SurveyResponse oneitem in cmpitems)
                {
                    tSurveyNo = oneitem.SurveyNo;
                    tQuestion = oneitem.QuestionCode;
                    tOptionResponse = oneitem.RatingOption;
                    tGeneralResponse = oneitem.GeneralResponse;

                    if (string.IsNullOrWhiteSpace(tGeneralResponse))
                    {
                        results_0 = "componentnull";
                        return results_0;
                    }

                    string status = Config.ObjNav.FnCreateBRResponseQuestions(tSurveyNo, tQuestion, tOptionResponse, tGeneralResponse);
                    string[] info = status.Split('*');
                    results_0 = info[0];
                }
            }
            catch (Exception ex)
            {
                // results_0 = ex.Message;
            }
            return results_0;
        }
    }
}