<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplicationForm.aspx.cs" Inherits="HRPortal.ApplicationForm" %>

<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">

    <% var nav = new Config().ReturnNav();
        var jobId = Session["appNo"];
        int step = 1;

        try
        {

            step = Convert.ToInt32(Request.QueryString["step"].ToString());
            if (step == 0)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;



        }

    %>
    <%
        if (step == 1)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Personal Details</h3>
        </div>

        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <h3><strong>1.0 Post Applied For:</strong></h3>

            <div class="form-group">
                <asp:TextBox runat="server" ID="appliedfor" ReadOnly="true" CssClass="form-control" placeholder="post applied for" />
            </div>
            <h3><strong>2.0 Personal Details</strong></h3>
            <div class="row">
                <div class="form-group col-xs-3">
                    <label for="Surname"><span style="color: red;">*</span>Surname</label>
                    <asp:TextBox runat="server" ID="Surname" CssClass="form-control" required="required" placeholder="" />

                </div>
                <div class="form-group col-xs-3">
                    <label for="Firstname"><span style="color: red;">*</span>Firstname</label>
                    <asp:TextBox runat="server" ID="Firstname" CssClass="form-control" required="required" placeholder="" />
                    <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="Firstname" BackColor="Red" errormessage="Please enter your Firstname!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="Lastname"><span style="color: red;">*</span>Lastname</label>
                    <asp:TextBox runat="server" ID="Lastname" CssClass="form-control" required="required" placeholder="" />
                    <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="Lastname" BackColor="Red" errormessage="Please enter your Lastname!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="Title"><span style="color: red;">*</span>Title</label>
                    <asp:TextBox runat="server" ID="txtTitle" CssClass="form-control" required="required" placeholder="eg.Mr,Mrs,Proff" />
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="txtTitle" BackColor="Red" errormessage="Please enter your Title!" />--%>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-xs-4">
                    <label for="DOB"><span style="color: red;">*</span>Date of Birth</label>
                    <asp:TextBox runat="server" ID="DOB" CssClass="form-control" required="required" placeholder="" />
                    <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="DOB" BackColor="Red" errormessage="Please enter your Date of Birth!" />--%>
                </div>
                <div class="form-group col-xs-4">
                    <label for="Gender"><span style="color: red;">*</span>Gender</label>
                    <asp:DropDownList ID="Gender" runat="server" Visible="true" required="required" CssClass="form-control select2"
                        AutoPostBack="false">
                        <%--  <asp:ListItem>Select</asp:ListItem>--%>
                        <asp:ListItem Value="0">Male</asp:ListItem>
                        <asp:ListItem Value="1">Female</asp:ListItem>
                        <asp:ListItem Value="2">Both</asp:ListItem>

                    </asp:DropDownList>
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="Gender" BackColor="Red" errormessage="Please select  your Gender!" />--%>
                </div>
                <div class="form-group col-xs-4">
                    <label for="Ethnicity"><span style="color: red;">*</span>Ethnicity</label>
                    <asp:DropDownList runat="server" ID="Ethnicity" CssClass="form-control" required="required" />
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="Ethnicity" BackColor="Red" errormessage="Please enter your Ethnicity!" />--%>
                </div>


            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <label for="Disability"><span style="color: red;">*</span> Are you a person living with disability?</label>
                    <%--<asp:TextBox runat="server" ID="disability" CssClass="form-control" placeholder=""/>--%>
                    <asp:DropDownList ID="disability" runat="server" Visible="true" CssClass="form-control select2"
                        AutoPostBack="false" required="required">
                        <%--<asp:ListItem>Select</asp:ListItem>--%>
                        <asp:ListItem Value="0">Yes</asp:ListItem>
                        <asp:ListItem Value="1">No</asp:ListItem>
                    </asp:DropDownList>
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="disability" BackColor="Red" errormessage="Please enter your disability!" />--%>
                </div>


            </div>

            <div class="row col-xs-12">
                <div class="form-group col-xs-12">
                    <label for="Disability">Details of registration with the national council with people with disability (registration no and date).(Not More than 50 characters) </label>

                    <%-- <asp:textarea id="registrationNo" CssClass="txt2" TextMode="multiline" MaxLength="2" Columns="50" Rows="10"  runat="server" />
                    --%>
                    <asp:TextBox ID="registrationNo" CssClass="txt2 form-control" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false" onpaste="return false;" />

                    <br />
                    <label id="txt2_WordCount"></label>
                </div>
            </div>
            <div class="row">

                <div class="form-group col-xs-3">
                    <label for="County"><span style="color: red;">*</span>County of origin: </label>
                    <asp:DropDownList ID="County" CssClass="form-control" runat="server" required="required" />
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="County" BackColor="Red" errormessage="Please enter your County!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="Nationality"><span style="color: red;">*</span>Nationality: </label>
                    <asp:DropDownList runat="server" ID="txtNationality" CssClass="form-control" required="required">
                        <asp:ListItem>Select Country</asp:ListItem>
                    </asp:DropDownList>
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="Nationality" BackColor="Red" errormessage="Please enter your Nationality!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="Nationality"><span style="color: red;">*</span>Religion: </label>
                    <asp:TextBox runat="server" ID="religion" CssClass="form-control" required="required" placeholder="" />
                </div>
                <div class="form-group col-xs-3">
                    <label for="Nationality"><span style="color: red;">*</span>Marital status: </label>
                    <asp:DropDownList ID="Maritalstatus" CssClass="form-control" required="required" runat="server">
                        <%--  <asp:ListItem>Select</asp:ListItem>--%>
                        <asp:ListItem Value="0">Married</asp:ListItem>
                        <asp:ListItem Value="1">Single</asp:ListItem>
                        <asp:ListItem Value="2">Divorced</asp:ListItem>
                        <asp:ListItem Value="3">Separated</asp:ListItem>
                        <asp:ListItem Value="4">Widow(er)</asp:ListItem>
                        <asp:ListItem Value="5">Other</asp:ListItem>
                    </asp:DropDownList>
                </div>


            </div>
            <div class="row">
                <div class="form-group col-xs-3">
                    <label for="Nationality">National ID No:  </label>
                    <asp:TextBox runat="server" ID="IdNo" CssClass="form-control" ReadOnly="true" required="required" placeholder="" />
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="IdNo" BackColor="Red" errormessage="Please enter your Id number!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="NHIF"><span style="color: red;">*</span>NHIF: </label>
                    <asp:TextBox runat="server" ID="nhif" CssClass="form-control" required="required" placeholder="" />
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="nhif" BackColor="Red" errormessage="Please enter your Nhif number!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="NSSF"><span style="color: red;">*</span>NSSF: </label>
                    <asp:TextBox runat="server" ID="NSSF" CssClass="form-control" required="required" placeholder="" />
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="NSSF" BackColor="Red" errormessage="Please enter your NSSF number!" />--%>
                </div>

                <div class="form-group col-xs-3">
                    <label for="NSSF"><span style="color: red;">*</span>KRA PIN:  </label>
                    <asp:TextBox runat="server" ID="pinNo" CssClass="form-control" required="required" placeholder="" />
                    <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="pinNo" BackColor="Red" errormessage="Please enter your pin number!" />--%>
                </div>

            </div>
            <h3><strong>3.0 Communication Details</strong></h3>
            <div class="row">
                <div class="form-group col-xs-3">
                    <label for="Mobile Phone No"><span style="color: red;">*</span>Mobile Phone No</label>
                    <asp:TextBox runat="server" ID="PhoneNo" type="number" CssClass="form-control" required="required" placeholder="" />
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="pinNo" BackColor="Red" errormessage="Please enter your phone number!" />--%>
                </div>
                <div class="form-group col-xs-3">
                    <label for="Mobile Phone No">Alternative Mobile No: </label>
                    <asp:TextBox runat="server" ID="alt_PhoneNo" type="number" CssClass="form-control" placeholder="" />
                </div>
                <div class="form-group col-xs-3">
                    <label for="Email"><span style="color: red;">*</span>Email</label>
                    <asp:TextBox runat="server" ID="Email" type="email" CssClass="form-control" required="required" placeholder="" />
                </div>
                <div class="form-group col-xs-3">
                    <label for="Email">Alternative Email</label>
                    <asp:TextBox runat="server" ID="alt_Email" type="email" CssClass="form-control" placeholder="" />
                </div>
            </div>
            <h3><strong>4.0 Employment Details (for internal applicants)</strong></h3>
            <div class="row">
                <div class="form-group col-xs-4">
                    <label for="Personal No">Personal No.</label>
                    <asp:TextBox runat="server" ID="personalNo" ReadOnly="true" CssClass="form-control" placeholder="" />
                </div>
                <div class="form-group col-xs-4">
                    <label for="Email"><span style="color: red;">*</span>Centre/Department</label>
                    <asp:DropDownList ID="Center" runat="server" CssClass="form-control" required="required">
                    </asp:DropDownList>

                </div>
                <div class="form-group col-xs-4">
                    <label for="Email">Present substantive Post</label>
                    <asp:TextBox runat="server" ID="currentPost" CssClass="form-control" placeholder="" />
                </div>
                <%--              <div class="form-group col-xs-3">
           <label for="Email">Years of work experience</label>
                <asp:TextBox runat="server" ID="workExperience" type="number" CssClass="form-control" placeholder=""/>
           </div>--%>
            </div>
            <div class="row">
                <div class="form-group col-xs-4">
                    <label for="Email">Job Group</label>
                    <asp:TextBox runat="server" ID="jobGr" CssClass="form-control" placeholder="" />
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="jobGr" BackColor="Red" errormessage="Please enter Job group!" />--%>
                </div>
                <div class="form-group col-xs-4">
                    <label for="Email">Date of first appointment</label>
                    <asp:TextBox runat="server" ID="firstofDateappointment" CssClass="form-control" placeholder="" />
                    <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="firstofDateappointment" BackColor="Red" errormessage="Please enter date of first appointment!" />--%>
                </div>

                <div class="form-group col-xs-4">
                    <label for="Email">Date of current appointment (last promotion)</label>
                    <asp:TextBox runat="server" ID="Dateofcurrentappointment" CssClass="form-control" placeholder="" />
                    <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="Dateofcurrentappointment" BackColor="Red" errormessage="Please enter date of current appointment!" />--%>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button ID="AddDetails" runat="server" Text="Next" CausesValidation="false" class="button btn btn-info pull-right" OnClick="AddDetails_Click" />
            <asp:Button ID="GoBack" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (step == 2)
        {%>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"></h3>
        </div>

        <div class="panel-body">
            <div runat="server" id="academicQualification"></div>
            <h3><strong>5.0 Academic qualifications</strong></h3>

            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addQualification">Add Qualification</button>

            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>From</th>
                        <th>To</th>
                        <th>University/Colleges/ High School attended </th>
                        <th>Award attainment e.g. PhD, Masters, Bachelors, KSCE </th>
                        <th>Specialization/Subject e.g. Epidemiology, Microbiology, Entomology, Finance, Human resource</th>
                        <th>Grade</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                    <% var Aca_qualifications = nav.ApplicantsQualification.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Application_No == jobId.ToString());
                        foreach (var qual in Aca_qualifications)
                        {
                    %>


                    <tr>
                        <td><% =Convert.ToDateTime(qual.From_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(qual.To_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =qual.Institution_Company %></td>
                        <td><% =qual.Qualification_Description %></td>
                        <td><% =qual.Specialization %></td>
                        <td><% =qual.Course_Grade %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteQualification('<%=qual.Code %>','<%=qual.Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>




                    </tr>
                    <%
                        } %>
                </tbody>
            </table>

            <h3><strong>6.0 Professional/Technical Qualifications/certifications relevant to the post</strong></h3>
            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addProfessional">Add Professional</button>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>From</th>
                        <th>To</th>
                        <th>Institution</th>
                        <th>Awards/attainment e.g. Higher Diploma, Diploma, Certificate, Certified Public Accountants etc </th>
                        <th>Specialization/Subject e.g. Epidemiology, Applied Biology, Medical Laboratory services, Clinical Medicine and Surgery, Engineering, Human resource, Accounts etc</th>
                        <th>Class/Grade</th>

                    </tr>
                </thead>
                <tbody>
                    <% var qualif = nav.ProfessionalQualification.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Application_No == jobId.ToString());
                        foreach (var prof in qualif)
                        {
                    %>


                    <tr>
                        <td><% =Convert.ToDateTime(prof.From_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(prof.To_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =prof.Institution %></td>
                        <td><% =prof.Attainment %></td>
                        <td><% =prof.Specialization %></td>
                        <td><% =prof.Grade %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteProfessional('<%=prof.Code %>','<%=prof.Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>

                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
            <h3><strong>7.0 Relevant courses and training attended lasting not less than one(1) week</strong></h3>
            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addTraining">Add Training</button>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>FROM</th>
                        <th>To</th>
                        <th>Name of course</th>
                        <th>Institution</th>
                        <th>Awards/attainment</th>
                        <%--<th>Institution/Company</th>--%>
                    </tr>
                </thead>
                <tbody>
                    <% var trainingAttended = nav.HrTrainingAttended.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Application_No == jobId.ToString());
                        foreach (var attended in trainingAttended)
                        {
                    %>


                    <tr>
                        <td><% =Convert.ToDateTime(attended.From_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(attended.To_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% = attended.Course_Name %></td>
                        <td><% =  attended.Institution %></td>
                        <td><% =attended.Attained %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteTraining('<%=attended.Code %>','<%=attended.Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>

                    </tr>
                    <%
                        } %>
                </tbody>
            </table>

            <h3><strong>8.0 Current registration/membership to professional bodies</strong></h3>
            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addMembership">Add Membership</button>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>Professional Body</th>
                        <th>Membership/Registration No.</th>
                        <th>Membership type e.g. Associate/Full</th>
                        <th>Date of Renewal</th>
                    </tr>
                </thead>
                <tbody>
                    <% var body = nav.HrProffessionalBody.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Application_No == jobId.ToString());
                        foreach (var p in body)
                        {
                    %>


                    <tr>
                        <td><% =p.Institution %></td>
                        <td><% =p.Membership_No%></td>
                        <td><% =p.Membership_Type %></td>
                        <td><% =p.Renewal_Date %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteProffessionalBody('<%=p.Code %>','<%=p.Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>



                    </tr>
                    <%
                        } %>
                </tbody>
            </table>

            <h3><strong>9.0 Employment history</strong></h3>
            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addEmploymentHistory">Add Employment History</button>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>FROM</th>
                        <th>TO</th>
                        <th>Designation/Position </th>
                        <th>Job Grade</th>
                        <th>Institution</th>
                    </tr>
                </thead>
                <tbody>
                    <% var EmployeeHistory = nav.ApplicantEmployeeHistory.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Application_No == jobId.ToString());
                        foreach (var hist in EmployeeHistory)
                        {
                    %>


                    <tr>
                        <td><% =Convert.ToDateTime(hist.From_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =Convert.ToDateTime(hist.To_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% = hist.Job_Title %></td>
                        <td><% = hist.Job_Grade %></td>
                        <td><% = hist.Company_Name %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteEmployment('<%=hist.Code %>','<%=hist.Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>


                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button ID="Step2" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step2_Click" />
            <asp:Button ID="GoBack1" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack1_Click" />

            <div class="clearfix"></div>

        </div>
    </div>

    <%
        }
        else if (step == 3)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Job Details</h3>
        </div>

        <div class="panel-body">
            <div runat="server" id="jobDetails"></div>
            <h3><strong>10.0 Briefly state your current duties, responsibilities and assignments.(Not more than 1000 characters)</strong></h3>
            <div class="form-group">
                <asp:TextBox ID="TextArea" CssClass="txt1" TextMode="multiline" MaxLength="2" Columns="50" Rows="10" onpaste="return true" runat="server" />
                <br />
                <label id="txt1_WordCount"></label>
            </div>
            <div class="form-group">
                <asp:Button ID="AddDuties" runat="server" Text="Save Duties" class="button btn btn-success pull-left" OnClick="AddDuties_Click" />
                <div class="clearfix"></div>
            </div>

            <h3><strong>11.0 Description of Accomplishments: Note: Please attach a list details of developed proposals, funded proposals, publications in refereed journals, publications in refereed journals as first author, additional responsibilities at the centre/Departments, provision of Mentorship to other staff and/or students.</strong></h3>
            <asp:GridView ID="grd_accomplishment" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>


                    <%--<asp:BoundField DataField="PromotionItem" HeaderText="Lookup Code" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" />
                                    <asp:BoundField DataField="PromoHeader" HeaderText="Promo Header" />
                    --%>

                    <asp:TemplateField HeaderText="Indicator Description">

                        <ItemTemplate>
                            <asp:TextBox ID="txtDescription" ReadOnly="true" runat="server" Text='<% #Eval("Indicator_Description") %>' Width="500px" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Indicator Number ">

                        <ItemTemplate>
                            <asp:TextBox ID="txtNumber" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Number") %>' type="number" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Amount ">

                        <ItemTemplate>
                            <asp:TextBox ID="txtAmount" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Amount") %>' type="number" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>


                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

            </asp:GridView>


            <div class="form-group">
                <asp:Button ID="AddAccomplishment" runat="server" Text="Add Accomplishment" class="button btn btn-success pull-left" OnClick="AddAccomplishment_Click" />
                <div class="clearfix"></div>
            </div>

            <asp:GridView ID="grd_accomplishment1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grd_accomplishment1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>


                    <%--<asp:BoundField DataField="PromotionItem" HeaderText="Lookup Code" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" />
                                    <asp:BoundField DataField="PromoHeader" HeaderText="Promo Header" />
                    --%>
                    <asp:BoundField DataField="Code" HeaderText="Proposal ID" />

                    <asp:TemplateField HeaderText="Indicator Description">

                        <ItemTemplate>
                            <asp:TextBox ID="txtDescription1" ReadOnly="true" runat="server" Text='<% #Eval("Indicator_Description") %>' Width="500px" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Indicator Number ">

                        <ItemTemplate>
                            <asp:TextBox ID="Number" runat="server" ReadOnly="true" onkeypress="return isNumber(event)" Text='<% #Eval("Number") %>' type="number" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount ">
                        <ItemTemplate>
                            <asp:TextBox ID="Amount" runat="server" ReadOnly="true" onkeypress="return isNumber(event)" Text='<% #Eval("Amount") %>' type="number" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" SelectText="Delete" ShowSelectButton="True" />


                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

            </asp:GridView>


            <%--       <div class="form-group">
            <asp:Button ID="AddAccomplishment1" runat="server" Text="Update Accomplishment" class="button btn btn-success pull-left" OnClick="AddAccomplishment1_Click"
                 />
           <div class="clearfix"></div>
         </div>--%>


            <h3><strong>12.0 Please give details of your abilities,skills,and experience,which you consider relevant to the position applied.This information may include an outline of your most recent achievements and reasons for applying for this post. (Not more than 1000 characters)</strong></h3>
            <br />
            <div class="form-group col-xs-12">
                <asp:TextBox ID="txtComment" onpaste="return true" CssClass="txt" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false"
                    onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off" />
                <br />
                <label id="lblWordCount"></label>
            </div>

            <h3><strong>13.0 Briefly provide description of your proffessional accomplishment (Not more than 250 characters)</strong></h3>
            <br />
            <div class="form-group col-xs-12">
                <asp:TextBox ID="professionalAccomplishment" onpaste="return true" CssClass="txt5" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false"
                    onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off" />
                <br />
                <label id="lblWordCount5"></label>
            </div>

            <div class="form-group">
                <asp:Button ID="AddAbility" runat="server" Text="Save Skills" class="button btn btn-success pull-left" OnClick="AddAbility_Click" />
                <div class="clearfix"></div>
            </div>

        </div>
        <div class="panel-footer">
            <asp:Button ID="Step3" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step3_Click" />
            <asp:Button ID="GoBack2" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack2_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%

        }
        else if (step == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Other personal details</h3>
        </div>

        <div class="panel-body">
            <div runat="server" id="otherPersonalDetails"></div>
            <h3><strong>14.0 Other personal details</strong></h3>
            <h5>i)Have you ever been convicted of any criminal offence or subject to any active ongoing criminal investigation?</h5>
            <div class="form-group col-xs-12">
                <asp:DropDownList ID="convict" runat="server" CssClass="form-control">
                    <%--   <asp:ListItem>Select</asp:ListItem>--%>
                    <asp:ListItem Value="0">Yes</asp:ListItem>
                    <asp:ListItem Value="1">No</asp:ListItem>
                </asp:DropDownList>
            </div>
            <h5>ii)If yes state nature of offense, year and duration(not more than 50 characters)</h5>

            <div class="form-group col-xs-12">
                <asp:TextBox ID="duration" CssClass="txt3  form-control" TextMode="MultiLine" runat="server" />
                <br />
                <label id="txt3_WordCount"></label>
            </div>
            <h5>iii)Have you ever been dismissed or otherwise removed from employment?</h5>
            <div class="form-group col-xs-12">
                <asp:DropDownList ID="Dismissed" CssClass="form-control" runat="server">
                    <%--  <asp:ListItem>Select</asp:ListItem>--%>
                    <asp:ListItem Value="0">Yes</asp:ListItem>
                    <asp:ListItem Value="1">No</asp:ListItem>
                </asp:DropDownList>
            </div>
            <h5>iv)4.	If yes, state reason(s) for dismissal/removal (effective date)</h5>
            <div class="form-group col-xs-12">
                <asp:TextBox ID="dismissalReasons" CssClass="txt form-control" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false" onpaste="return false;"
                    onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off" />
                <br />
                <label id="txt1_lblCount"></label>
            </div>
            <h5>v)What is your highest level of education </h5>
            <div class="form-group col-xs-12">
                <asp:DropDownList ID="txt_highestLevel" CssClass="form-control" runat="server">
                    <asp:ListItem Value="Certificate">Certificate</asp:ListItem>
                    <asp:ListItem Value="Diploma">Diploma</asp:ListItem>
                    <asp:ListItem Value="Bachelors">Bachelors</asp:ListItem>
                    <asp:ListItem Value="Honors">Honors</asp:ListItem>
                    <asp:ListItem Value="Masters">Masters</asp:ListItem>
                    <asp:ListItem Value="PHD">PHD</asp:ListItem>
                    <asp:ListItem Value="Post doctorate">Post doctorate</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Button ID="SaveOtherPersonalDetails" runat="server" Text="Save" class="button btn btn-success pull-left" OnClick="SaveOtherPersonalDetails_Click" />
                <div class="clearfix"></div>
            </div>
            <h3><strong>Declaring the above information will not necessarily bar an applicant from employment in the institute. Each case will be considered on its own merit.</strong></h3>

        </div>
        <div class="panel-footer">
            <asp:Button ID="Step4" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step4_Click" />
            <asp:Button ID="GoBack3" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack3_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%

        }
        else if (step == 5)
        { %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Referees Details</h3>
        </div>

        <div class="panel-body">
            <div runat="server" id="referee"></div>
            <h3><strong>15.0 Referees (People who have interacted with you professionally) </strong></h3>
            <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addReferee">Add Referee</button>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>

                        <th>Full names</th>
                        <th>Occupation</th>
                        <th>Address </th>
                        <th>Postcode</th>
                        <th>Mobile Number</th>
                        <th>Email Address</th>
                        <th>Period for which the referee has known you</th>
                    </tr>
                </thead>
                <tbody>
                    <% var referee = nav.HRApplicantReferees.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Job_Application_No == jobId.ToString());
                        foreach (var refer in referee)
                        {
                    %>


                    <tr>
                        <td><% =refer.Names%></td>
                        <td><% =refer.Occupation %></td>
                        <td><% =refer.Address %></td>
                        <td><% =refer.Post_Code %></td>
                        <td><% =refer.Telephone_No %></td>
                        <td><% =refer.E_Mail %></td>
                        <td><% =refer.Period_Known %></td>
                        <td>
                            <label class="btn btn-danger" onclick="DeleteReferee('<%=refer.Code %>','<%=refer.Job_Application_No %>');"><i class="fa fa-trash-o"></i>Delete</label></td>

                    </tr>
                    <%
                        } %>
                </tbody>
            </table>


            <h3><strong>Minimum job requirement qualification checklist</strong></h3>
            <asp:GridView ID="shortlistingCriteria" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>




                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtEntryNo" ReadOnly="true" runat="server" Visible="false" Text='<% #Eval("Entry_No") %>' AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtAppNo" ReadOnly="true" Visible="false" runat="server" Text='<% #Eval("Job_App_No") %>' AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtReqNo" Visible="false" ReadOnly="true" runat="server" Text='<% #Eval("Requisition_No") %>' AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Description ">

                        <ItemTemplate>
                            <asp:TextBox ID="txtDescription" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Description") %>' ReadOnly="true" Width="250px" type="text" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Requirement">

                        <ItemTemplate>
                            <asp:TextBox ID="txtRequirement" runat="server" Text='<% #Eval("Requirement") %>' Width="250px" ReadOnly="true" type="text" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Confirm you have met the minimum job requirement by checking checkbox">

                        <ItemTemplate>
                            <asp:CheckBox ID="txtCheckBox" runat="server" Checked="false" Width="250px" type="text" AutoPostBack="False" />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>



                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <div class="form-group">
                <asp:Button ID="ShortListingCriteriaButton" runat="server" Text="Save" class="button btn btn-success pull-left" OnClick="ShortListingCriteriaButton_Click" />
                <div class="clearfix"></div>
            </div>

            <h3><strong>View Your input on minimum job requirements</strong></h3>
            <asp:GridView ID="ShortListingCriteria1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="ShortListingCriteria1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>




                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtEntryNo1" Visible="false" ReadOnly="true" runat="server" Text='<% #Eval("Entry_No") %>' Width="0px" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtAppNo1" Visible="false" ReadOnly="true" runat="server" Text='<% #Eval("Job_App_No") %>' Width="0px" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">

                        <ItemTemplate>
                            <asp:TextBox ID="txtReqNo1" Visible="false" ReadOnly="true" runat="server" Text='<% #Eval("Requisition_No") %>' Width="0px" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Description ">

                        <ItemTemplate>
                            <asp:TextBox ID="txtDescription1" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Description") %>' ReadOnly="true" Width="250" type="text" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Requirement">

                        <ItemTemplate>
                            <asp:TextBox ID="txtRequirement1" runat="server" Text='<% #Eval("Requirement") %>' ReadOnly="true" Width="250px" type="text" AutoPostBack="False"></asp:TextBox>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Checked">

                        <ItemTemplate>
                            <asp:CheckBox ID="txtCheckBox1" runat="server" Checked="true" Text='<% #Eval("Check") %>' type="text" AutoPostBack="False" />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" SelectText="Remove from my selection" ShowSelectButton="True" />


                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

            </asp:GridView>



            <h3><strong>Declaration</strong></h3>
            <h5>I certify that the particulars given on this form are correct and understand that any incorrect/misleading information may lead to disqualification and/or legal action.</h5>

            <div class="form-group col-xs-6">
                <label for="Disability">Declare</label>
                <asp:DropDownList ID="Declare1" runat="server" Visible="true" CssClass="form-control select2"
                    AutoPostBack="false">
                    <asp:ListItem Value="0">Yes</asp:ListItem>
                    <asp:ListItem Value="1">No</asp:ListItem>
                </asp:DropDownList>
            </div>

        </div>
        <div class="panel-footer">

            <asp:Button ID="Step5" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step5_Click" />
            <asp:Button ID="GoBack4" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack4_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%

        }
        else if (step == 6)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Upload Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 6 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload certificate of good conduct in a named pdf format as per job advert:</h5>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Higher Education Loans Board(HELB) clearance certificate in a named pdf format as per job advert:</h5>
                        <asp:FileUpload runat="server" ID="UploadHelbDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadHelbDocument" OnClick="UploadHelbDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload valid Kenya Revenue Authority(KRA) compliance certificate in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadKRADoc" AllowMultiple="true" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadKRADocument" OnClick="UploadKRADocument_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Credit Reference Bureau(CRB) clearance certificate in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadCRBDoc" AllowMultiple="true" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadCRBDocument" OnClick="UploadCRBDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Ethics And Anti-Corruption Commission(EACC) Certificate in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadEACCDoc" AllowMultiple="true" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadEACCDocument" OnClick="UploadEACCDocument_Click" />
                    </div>
                </div>
            </div>
            <h5><strong>ii)Academic related documents</strong></h5>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload curriculum vitae(CV) in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadCVDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadCVDocument" OnClick="UploadCVDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Cover Letter in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadCoverLetterDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadCoverLetterDocument" OnClick="UploadCoverLetterDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Academic Certificates  in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadAcademicDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadAcademicDocument" OnClick="UploadAcademicDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload proof of Professional Membership/Licence  in a named pdf format as per job advert:</h5>

                        <asp:FileUpload runat="server" ID="UploadProfessionalMembershipDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadProfessionalMembershipDocument" OnClick="UploadProfessionalMembershipDocument_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Professional Certification in a named pdf format as per job advert:</h5>
                        <asp:FileUpload runat="server" ID="UploadProffessionalDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadProffessionalDocument" OnClick="UploadProffessionalDocument_Click" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <h5>Upload Publication and Proposal List in a named pdf format as per job advert:</h5>
                        <asp:FileUpload runat="server" ID="UploadPublicationDoc" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadPublicationDocument" OnClick="UploadPublicationDocument_Click" />
                    </div>
                </div>
            </div>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%--  <th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

                            string appNo = Session["appNo"].ToString();

                            String documentDirectory = filesFolder + appNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))

                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>

                        <%--  <td><a href="<%=fileFolderApplication %>\HR Job Applications Card\<% =appNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>--%>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <%
                                }
                            }
                        }
                        catch (Exception)
                        {

                        }%>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button ID="GoBack5" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack5_Click" />
            <asp:Button ID="Finish" runat="server" Text="Submit Application" class="button btn btn-success pull-right" OnClick="Finish_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
    %>



    <div id="addQualification" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Academic Qualification</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>From:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="From" ID="qualificationFrom" Style="width: 97%;" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label>To:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="To" ID="qualificationTo" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Institution:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="institution" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Specialization/Subject </label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="e.g. Epidemiology" ID="specialization" Style="width: 97%;" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label>Award Attainment:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:DropDownList CssClass="form-control" runat="server" placeholder="e.g. PhD, Masters, Bachelors, KSCE " ID="Attainment" Style="width: 97%;" />

                            </div>

                        </div>

                        <div class="form-group">
                            <label>Grade Attained:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="gradeAttained" Style="width: 97%;" />

                            </div>
                        </div>






                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Qualificcation" OnClick="addQualification_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div id="addProfessional" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Profession/Certification</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>From:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="From" ID="prof_startDate" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>To:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="To" ID="prof_endDate" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Institution:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="prof_institution" Style="width: 97%;" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label>Specialization/Subject :</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="e.g.Epidemiology" ID="pr_Specialization" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Award/Attainment :</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:DropDownList CssClass="form-control" runat="server" placeholder="e.g. Higher Diploma, Diploma, Certificate, Certified Public Accountants etc" ID="pr_attainment" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Grade Attained:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="attainedScore" Style="width: 97%;" />
                            </div>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Proffession" OnClick="addProfession_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div id="addTraining" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Training</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>From:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="From" ID="tr_StartDate" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>To:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="To" ID="tr_EndDate" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Course Name:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="tr_courseName" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Institution:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="tr_institution" Style="width: 97%;" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label>Awards/attainment:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="tr_score" Style="width: 97%;" />

                            </div>
                        </div>



                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Training" OnClick="addTraining_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div id="addMembership" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Membership</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>Professional Body:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:DropDownList CssClass="form-control" runat="server" placeholder="professional body" ID="m_body" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Membership/Registration No:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="m_regNo" Style="width: 97%;" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label>Membership type:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="e.g. Associate/Full" ID="m_Membershiptype" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Date of Renewal:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="To" ID="m_DateofRenewal" Style="width: 97%;" />
                            </div>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Membership" OnClick="addMembership_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div id="addEmploymentHistory" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Employment History</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>From:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="From" ID="em_StartDate" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>To:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="To" ID="em_EndDate" Style="width: 97%;" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label>Position Held:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="em_positionHeld" Style="width: 97%;" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label>Institution/Company:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="em_institution" Style="width: 97%;" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label>Job Grade:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="em_JobGrade" Style="width: 97%;" />
                            </div>
                        </div>



                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Employment History" OnClick="addEmploymentHistory_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>


    <div id="addReferee" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Referee</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">

                        <div class="form-group">
                            <label>Full names:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_name" Style="width: 97%;" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label>Occupation:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_Occupation" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Address:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_Address" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Postcode:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_Postcode" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>City</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_City" Style="width: 97%;" />

                            </div>
                        </div>

                        <div class="form-group">
                            <label>Mobile Number</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_phone" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_EmailAddress" Style="width: 97%;" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Period for which the referee has known you</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="" ID="ref_period" Style="width: 97%;" />
                            </div>
                        </div>

                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Referee" OnClick="addReferee_Click"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>



    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="deleteFile" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>



    <script>

        function DeleteQualification(Code, ApplicationNo) {
            document.getElementById("ApplicationNo").innerText = ApplicationNo;
            document.getElementById("MainBody_Code").value = Code;
            $("#deleteQualificationModal").modal();
        }
    </script>

    <div id="deleteQualificationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="ApplicationNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="Code" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeleteQualification" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteQualification_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function DeleteProfessional(PCode, PNo) {
            document.getElementById("PNo").innerText = PNo;
            document.getElementById("MainBody_PCode").value = PCode;
            $("#deleteProfessionalModal").modal();
        }
    </script>
    <div id="deleteProfessionalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="PNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="PCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeleteProfessional" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteProfessional_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function DeleteTraining(TCode, TNo) {
            document.getElementById("TNo").innerText = TNo;
            document.getElementById("MainBody_TCode").value = TCode;
            $("#deleteTrainingModal").modal();
        }
    </script>
    <div id="deleteTrainingModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the record <strong id="TNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="TCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeleteTraining" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteTraining_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function DeleteProffessionalBody(BCode, BNo) {
            document.getElementById("BNo").innerText = BNo;
            document.getElementById("MainBody_BCode").value = BCode;
            $("#deletePBodyModal").modal();
        }
    </script>
    <div id="deletePBodyModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the record <strong id="BNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="BCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeletePBody" CssClass="btn btn-danger" Text="Delete" OnClick="DeletePBody_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function DeleteEmployment(ECode, ENo) {
            document.getElementById("ENo").innerText = ENo;
            document.getElementById("MainBody_ECode").value = ECode;
            $("#deleteEHistoryModal").modal();
        }
    </script>
    <div id="deleteEHistoryModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the record <strong id="ENo"></strong>?</p>
                    <asp:TextBox runat="server" ID="ECode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeleteEmployment" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteEmployment_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function DeleteReferee(RCode, RNo) {
            document.getElementById("RNo").innerText = RNo;
            document.getElementById("MainBody_RCode").value = RCode;
            $("#deleteRefereeModal").modal();
        }
    </script>
    <div id="deleteRefereeModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the record <strong id="RNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="RCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="DeleteRef" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteRef_Click" />
                </div>
            </div>

        </div>
    </div>



</asp:Content>
