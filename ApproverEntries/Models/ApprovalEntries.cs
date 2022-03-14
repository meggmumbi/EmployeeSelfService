using ApproverEntries.NAV;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;

namespace HRPortal.Models
{
    public class ApprovalEntries
    {
        public int SequenceNo { get; set; }
        public string Status { get; set; }
        public string SenderId { get; set; }
        public string ApproverId { get; set; }
        public string Amount { get; set; }
        public String DateSentforApproval { get; set; }
        public String Comment { get; set; }
        public String DueDate { get; set; }

    }

    public class ApprovalFilter
    {
        public int TableId { get; set; }
        public String DocumentType { get; set; }
        public String DocumentNo { get; set; }
    }

    public class Config
    {
        public NAV ReturnNav()
        {

            NAV nav = new NAV(new Uri(ConfigurationManager.AppSettings["ODATA_URI"]))
            {
                Credentials =
                    new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"])
            };
            return nav;
        }
    }
}