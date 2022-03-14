using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employeeNo"] == null)
            {

                Response.Redirect("Login.aspx");
            }
            else
            {
                string filesFolder = Server.MapPath("~/Passport/");
                string employeeNo = Convert.ToString(Session["employeeNo"]);
                string filename = filesFolder + employeeNo + ".png";
                if(File.Exists(filename))
                {
                    var image = "Passport/" + Convert.ToString(Session["employeeNo"]) + ".png";
                    passportimage.Src = image;
                    passportimage.Width = 221;
                    passportimage.Height = 201;
                    photosize.Visible = false;
                }
                else
                {

                    photosize.InnerHtml= "<div class='alert alert-warning'>" + "Dear"+" "+Session["name"].ToString()+" "+"Kindly Upload your Passport Size Photo"+ "</div>";
                }
                
            }
        }
        public void UPloadImage_Click(object sender, EventArgs e)
        {
            string filesFolder = Server.MapPath("~/Passport/");

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        string extension = System.IO.Path.GetExtension(document.FileName);
                        if (extension == ".jpg" || extension == ".JPG" || extension == ".jpeg" || extension == ".png" || extension == ".PNG")
                        {
                            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(document.PostedFile.InputStream);
                            System.Drawing.Image objImage = ScaleImage(bmpPostedImage, 81);

                            string employeeNo = Convert.ToString(Session["employeeNo"]);
                            string documentDirectory = filesFolder + "/";
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
                                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            if (createDirectory)
                            {
                                string Imagedepedantphotobytes = (dynamic)null;
                                string filename = documentDirectory + employeeNo + ".png";
                                if (!File.Exists(filename))
                                {
                                    try
                                    {
                                        document.SaveAs(filename);
                                        string imagePath = filename;
                                        System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                                        byte[] Imagedepedantphoto = ImageToByteArray(img);
                                        Imagedepedantphotobytes = Convert.ToBase64String(Imagedepedantphoto);
                                        string status = Config.ObjNav.Addemployeepassportphoto(Convert.ToString(Session["employeeNo"]), Imagedepedantphotobytes);
                                        string[] info = status.Split('*');
                                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>Your Passport Size Photo has been UPloaded SUccessfully<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        Response.Redirect("Dashboard.aspx");
                                    }
                                    catch (Exception)
                                    {

                                    }
                                }
                                else
                                {
                                    try
                                    {
                                        var image = System.Drawing.Image.FromFile(filename);
                                        image.Dispose();
                                        File.Delete(filename);
                                        document.SaveAs(filename);
                                        string imagePath = filename;
                                        System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                                        byte[] Imagedepedantphoto = ImageToByteArray(img);
                                        Imagedepedantphotobytes = Convert.ToBase64String(Imagedepedantphoto);
                                        var employee = Convert.ToString(Session["employeeNo"]);
                                        string status = Config.ObjNav.Addemployeepassportphoto(employee, Imagedepedantphotobytes);
                                        string[] info = status.Split('*');
                                        Response.Redirect("Dashboard.aspx");
                                    }
                                    catch (Exception)
                                    {

                                    }
                                  
                                    
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Your Passport Size Photo file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        public byte[] ImageToByteArray(System.Drawing.Image imageIn)
        {
            using (var ms = new MemoryStream())
            {
                imageIn.Save(ms, imageIn.RawFormat);

                return ms.ToArray();
            }
        }
        public static System.Drawing.Image ScaleImage(System.Drawing.Image image, int maxHeight)
        {
            var ratio = (double)maxHeight / image.Height;
            var newWidth = (int)(image.Width * ratio);
            var newHeight = (int)(image.Height * ratio);
            var newImage = new Bitmap(newWidth, newHeight);
            using (var g = Graphics.FromImage(newImage))
            {
                g.DrawImage(image, 0, 0, newWidth, newHeight);
            }
            return newImage;
        }
    }
}