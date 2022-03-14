<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BrQuestions.aspx.cs" Inherits="HRPortal.BrQuestions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainBody" runat="server">
    <style>
        #agree {
            display: none;
        }
    </style>
    <div class="panel panel-primary">
        <div class="panel-heading">
            BR Questions General Details
        </div>
        <div class="panel-body">
            <div id="feedback" style="display: none"></div>
            <div id="generalFeedback" runat="server"></div>
            <% 
                string surveyNo = Request.QueryString["surveyNo"];
                string sectionCode = Request.QueryString["sectionCode"];
                var nav = new Config().ReturnNav();
            %>
            <%
                var section = nav.BrResponseSection.Where(x => x.Survey_Response_ID == surveyNo && x.Section_Code == sectionCode).ToList();
                foreach (var sectionheader in section)
                {
            %>

            <h4><%=sectionheader.Description %></h4>
            <%
                }

            %>


            <br />
            <%
                var quiz = nav.BRResponseQuestion.Where(x => x.Survey_Response_ID == surveyNo && x.Section_Code == sectionCode).ToList();
                foreach (var project in quiz)
                {
            %>

            <div class="row">

                <div class="col-md-6 col-lg-12">
                    <div class="form-group">
                        <div class="divSurvey">
                            <input type="hidden" value="<% =Request.QueryString["surveyNo"] %>" class="txtsurveyNo" />
                            <input type="hidden" value="<%=project.Question_ID %>" class="txtQuestionId" />
                            <strong>
                                <label><% =project.Question %></label></strong>
                            <%
                                if (project.Rating_Type == "Options Text")
                                {
                            %>
                            <select class="form-control selectedoption">
                                <option>--select--</option>
                                <option value="1-HIGHLY DISAGREE">1-HIGHLY DISAGREE</option>
                                <option value="2-DISAGREE">2-DISAGREE</option>
                                <option value="3-NEUTRAL">3-NEUTRAL</option>
                                <option value="4-AGREE">4-AGREE</option>
                                <option value="5-HIGHLY AGREE">5-HIGHLY AGREE</option>
                            </select>
                            <br />
                            <label><i>Give more explanations of your choice</i></label>
                            <textarea class="form-control response" rows="1" required></textarea>
                            <%
                                }
                                else if (project.Rating_Type == "Open Text")
                                {
                            %>
                            <textarea class="form-control response" rows="1" required></textarea>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <div style="display: none" class="form-group agree">
                <label style="display: none; background-color: aqua" class="agree"><i>What is the reason?</i></label>
                <textarea style="display: none" class="form-control agree" rows="1" required></textarea>
            </div>
            <center> <button type="submit" class="btn btn-success saveresponce">Submit Survey Response</button> </center>
        </div>
    </div>
    <script>


        $("body").delegate(" .saveresponce", "click", function (event) {
            //To prevent form submit after ajax call

            event.preventDefault();
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            //declare an array
            var i = 0;


            $(".divSurvey").each(function () {
                var row = $(this);
                var onerfqitem = {};
                i++;

                onerfqitem.SurveyNo = row.attr("id", "txtsurveyNo" + i).find(".txtsurveyNo").val();

                onerfqitem.QuestionCode = row.attr("id", "txtQuestionId" + i).find(".txtQuestionId").val();

                onerfqitem.RatingOption = row.attr("id", "selectedoption" + i).find(".selectedoption").val();

                onerfqitem.GeneralResponse = row.attr("id", "response" + i).find(".response").val();

                allrfqitems.push(onerfqitem);

            });




            $.ajax({
                type: "POST",
                url: "BrQuestions.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Response Added!",
                                text: "Survey Response saved successfully!",
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Survey Responce saved successfully!");
                            });
                            break;

                        case "componentnull":
                            Swal.fire
                            ({
                                title: "Component not filled!",
                                text: "Component field empty!",
                                type: "danger"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').attr("class", "alert alert-danger");
                                $("#feedback").html("Component field empty!");
                            });
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Error!!!",
                                text: "Error Occured",
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html(status.d);
                            });

                            break;
                    }
                },
                error: function (err) {
                    console.log(err.statusText);
                    console.log(status.d);
                }

            });

            console.log(allrfqitems);
        });

        //$('.selectedoption').on('change', function () {
        //    if (this.value === "4-AGREE") {
        //        $(".agree").show();
        //    } else {
        //        $(".agree").hide();
        //    }
        //});

        //$(function () {

        //    //Attach click event to your Dropdownlist
        //    $(".selectedoption").change(function () {
        //        //Get the selected valu of dropdownlist
        //        selection = $(this).val();
        //        //If its one then show the dialog window. You can change this condition as per your need
        //        if (selection == "4-AGREE") {
        //            //Show the modal window
        //            $('.indexchangemodal').modal('show');
        //        }
        //    });
        //});

    </script>

    <!--Onselected index change modal popup-->
    <div class="modal fade indexchangemodal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editLineNo" type="hidden" />

                    <div class="form-group">
                        <strong>Vote Item:</strong>
                        <asp:DropDownList runat="server" ID="editVoteItem" CssClass="select2 form-control" Style="width: 100%;" />
                    </div>

                    <div class="form-group">
                        <strong>Description:</strong>

                        <asp:TextBox runat="server" ID="editDescription" CssClass="form-control" Placeholder="Description" />
                    </div>

                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" ID="editAmount" CssClass="form-control" Placeholder="Amount" />
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
