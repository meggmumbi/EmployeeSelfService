<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="HRPortal.profile" %>

<%@ Import Namespace="HRPortal" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainBody" runat="server">
    <% var nav = new Config().ReturnNav();
    %>
    <div id="feedback" runat="server"></div>
    <div class="row" style="margin: 10px;">


        <div class="col-md-6 col-lg-6">
            <div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="icon-file"></i>
                        Job Application Details
                    </div>
                    <div class="panel-body" style="overflow: auto;">

                        <table class="table table-striped table-bordered">
                            <tr>
                                <th>First Name</th>
                                <td>
                                    <asp:TextBox runat="server" ID="fName" placeholder="First Name" CssClass="form-control" />

                                </td>
                            </tr>
                            <tr>
                                <th>Middle Name</th>
                                <td>
                                    <asp:TextBox runat="server" ID="middleName" placeholder="Middle Name" CssClass="form-control" />

                                </td>
                            </tr>
                            <tr>
                                <th>Last Name</th>
                                <td>
                                    <asp:TextBox runat="server" ID="lastName" placeholder="Last Name" CssClass="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <th>Initials</th>
                                <td>
                                    <asp:TextBox runat="server" ID="initials" placeholder="Initials" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <th>Firt Language</th>
                                <td>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="firstLanguage" />
                                    <table>
                                        <tr>
                                            <td>Read</td>
                                            <td>Write</td>
                                            <td>Speak</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox runat="server" ID="firstLanguageRead" />
                                            </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="firstLanguageWrite" />
                                            </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="firstLanguageSpeak" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th>Second Language</th>
                                <td>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="secondlanguage" />
                                    <table>
                                        <tr>
                                            <td>Read</td>
                                            <td>Write</td>
                                            <td>Speak</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox runat="server" ID="secondLanguageRead" /></td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="secondLanguageWrite" />
                                            </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="secondLanguageSpeak" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th>Additional Language</th>
                                <td>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="additionalLanguage" /></td>
                            </tr>
                            <tr>
                                <th>Id</th>
                                <td>
                                    <asp:TextBox runat="server" ID="idNumber" placeholder="ID Number" CssClass="form-control" ReadOnly="True" /></td>
                            </tr>
                            <tr>
                                <th>Gender</th>
                                <td>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="gender" /></td>
                            </tr>
                            <tr>
                                <th>Citizenship</th>
                                <td>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="citizenship" /></td>
                            </tr>
                        </table>
                        <div class="row" style="margin: 10px;">
                            <asp:LinkButton ID="updateGeneralDetails" CssClass="button btn btn-success btn-large pull-right" runat="server" OnClick="updateGeneralDetails_Click">Update General Details</asp:LinkButton>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="icon-file"></i>
                        Hobies
                    </div>
                    <div class="panel-body" style="overflow: auto;">
                        <asp:TextBox runat="server" ID="hobby" CssClass="form-control" placeholder="Hobby" />
                        <asp:LinkButton runat="server" CssClass="btn btn-success" OnClick="Unnamed1_Click">Add Hobby</asp:LinkButton>
                        <ol>
                            <!-- get hobies-->
                            <% var hobies = nav.JobApplicantHobies.Where(r => r.Id_No == (String)Session["idNo"]);
                                foreach (var hobby in hobies)
                                {
                            %>
                            <li><%=hobby.Hobby %></li>
                            <%
                                }
                            %>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <i class="icon-file"></i>
                    Personal Details
                </div>
                <div class="panel-body" style="overflow: auto;">
                    <table class="table table-striped table-bordered">
                        <tr>
                            <th>Marital Status</th>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="maritalStatus" /></td>
                        </tr>
                        <tr>
                            <th>Ethnic Origin</th>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="ethnicOrigin" /></td>
                        </tr>
                        <tr>
                            <th>Disabled</th>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="disabled" /></td>
                        </tr>
                        <tr>
                            <th>Health Assessment</th>
                            <td>
                                <asp:CheckBox runat="server" ID="healthAssessment" /></td>
                        </tr>
                        <tr>
                            <th>Health Assessment Date</th>
                            <td>
                                <asp:TextBox runat="server" ID="healthAssessmentDate" placeholder="Health Assessment Date" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Date of Birth</th>
                            <td>
                                <asp:TextBox runat="server" ID="dateOfBirth" placeholder="Date of Birth" CssClass="form-control" /></td>
                        </tr>
                    </table>
                    <div class="row" style="margin: 10px;">
                        <asp:LinkButton ID="updatePersonalDetails" CssClass="button btn btn-success btn-large pull-right" runat="server" OnClick="updatePersonalDetails_Click">Update Personal Details</asp:LinkButton>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <i class="icon-file"></i>
                    Communication Details
                </div>
                <div class="panel-body" style="overflow: auto;">
                    <table class="table table-striped table-bordered">
                        <tr>
                            <th>Home Phone Number</th>
                            <td>
                                <asp:TextBox runat="server" ID="homePhoneNumber" placeholder="Home Phone Number" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Postal Address</th>
                            <td>
                                <asp:TextBox runat="server" ID="postalAddress" placeholder="Postal Address" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Postal Address 2</th>
                            <td>
                                <asp:TextBox runat="server" ID="postalAddress2" placeholder="Postal Address 2" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Postal Address 3</th>
                            <td>
                                <asp:TextBox runat="server" ID="postalAddress3" placeholder="Postal Address 3" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Post Code</th>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="postCode" /></td>
                        </tr>
                        <tr>
                            <th>Residential Address</th>
                            <td>
                                <asp:TextBox runat="server" ID="residentialAddress" placeholder="Residential Address" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Residential Address 2</th>
                            <td>
                                <asp:TextBox runat="server" ID="residentialAddress2" placeholder="Residential Address 2" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Residential Address 3</th>
                            <td>
                                <asp:TextBox runat="server" ID="residentialAddress3" placeholder="Residential Address 3" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Post Code 2</th>
                            <td>
                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="postCode2" /></td>
                        </tr>
                        <tr>
                            <th>Cell Phone Number</th>
                            <td>
                                <asp:TextBox runat="server" ID="cellPhoneNumber" placeholder="Cell Phone Number" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Work Phone Number</th>
                            <td>
                                <asp:TextBox runat="server" ID="workPhoneNumber" placeholder="Work Phone Number" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Extension</th>
                            <td>
                                <asp:TextBox runat="server" ID="extension" placeholder="Extension" CssClass="form-control" /></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td>
                                <asp:TextBox runat="server" ID="email" placeholder="Email" CssClass="form-control" ReadOnly="True" /></td>
                        </tr>
                        <tr>
                            <th>Fax Number</th>
                            <td>
                                <asp:TextBox runat="server" ID="fax" placeholder="Fax Number" CssClass="form-control" /></td>
                        </tr>
                    </table>
                    <div class="row" style="margin: 10px;">
                        <asp:LinkButton ID="updateCommunication" CssClass="button btn btn-success btn-large pull-right" runat="server" OnClick="updateCommunication_Click">Update Communication Details</asp:LinkButton>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>



        <hr />
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <i class="icon-file"></i>
                    Qualifications
                </div>
                <div class="panel-body">

                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addQualification">Add Qualification</button>

                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Qualification Code</th>
                                <th>Qualification Description</th>
                                <th>From Date</th>
                                <th>To Date</th>
                                <th>Institution/Company</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% var qualifications = nav.JobApplicantQualifications;
                                foreach (var qualification in qualifications)
                                {
                            %>


                            <tr>
                                <%--                <td><% =qualification.Code %></td>
                     <td><% =qualification.Description %></td>
                     <td><% =Convert.ToDateTime(qualification.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(qualification.To_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =qualification.Institution_Company %></td>--%>
                            </tr>
                            <%
                                } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <i class="icon-file"></i>
                    Referees
                </div>
                <div class="panel-body">
                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addReferee">Add Referee</button>
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Designation</th>
                                <th>Institution</th>
                                <th>Address</th>
                                <th>Telephone No.</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% var referees = nav.JobApplicantReferees;
                                foreach (var referee in referees)
                                {
                            %>


                            <tr>
                                <%--                     <td><% =referee.Names %></td>
                     <td><% =referee.Designation %></td>
                     <td><% =referee.Institution %></td>
                     <td><% =referee.Address %></td>
                     <td><% =referee.Telephone_No %></td>
                     <td><% =referee.E_Mail %></td>--%>
                            </tr>
                            <%
                                } %>
                        </tbody>
                    </table>
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
                    <h4 class="modal-title">Add Referees</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">
                        <div class="form-group">
                            <label>Name:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder=" Referee Name" ID="refName" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Designation:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Designation" ID="refDesignation" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Institution:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution" ID="refInstitution" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Address:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="address" ID="refAddress" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Telephone No:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Telephone Number" ID="refTelephoneNo" Style="width: 97%;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Email:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Email" ID="refEmail" Style="width: 97%;" />
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

    <div id="addQualification" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Qualification</h4>
                </div>
                <div class="modal-body">

                    <div class="row" style="width: 100%; display: block; margin: auto;">
                        <!--<div class="form-group">
                      <label>Qualification Type:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" ID="qualificationType" style="width:97%;" placeholder="Qualification Type"/>
                         </div>
                  </div>-->
                        <div class="form-group">
                            <label>Qualification Description:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:DropDownList CssClass="form-control select2" runat="server" ID="qualificationDescription" Style="width: 97%;" />
                            </div>
                        </div>

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
                            <label>Institution/Company:</label>
                            <div class="input-group mb-10">
                                <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="institution" Style="width: 97%;" />
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


    <script>

        $(document).ready(function () {


        });
    </script>
</asp:Content>

