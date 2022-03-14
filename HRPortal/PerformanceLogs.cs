using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPortal
{
    public class PerformanceLogs
    {
        public string entrynumber { get; set; }
        public string docNo { get; set; }
        public int agreedtarget { get; set; }
        public string comments { get; set; }
        public string actualTarget { get; set; }
        public string description { get; set; }
        public string Attachment { get; set; }
    }
    public class PlogsEntries
    {
        public string entrynumber { get; set; }
        public string agreedtarget { get; set; }
        public string allcomments { get; set; }
        public string achievedDate { get; set; }
    }
}