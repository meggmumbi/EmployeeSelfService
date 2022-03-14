using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPortal
{
    public class SurveyResponse
    {
        public int QuestionCode { get; set; }
        public string SurveyNo { get; set; }
        public string RatingOption { get; set; }
        public string GeneralResponse { get; set; }
    }
}