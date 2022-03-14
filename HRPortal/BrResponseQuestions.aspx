<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BrResponseQuestions.aspx.cs" Inherits="HRPortal.BrResponseQuestions" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBody" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">BR Response Questions</div>
        <div class="panel-body">
            <div id="feedback" style="display: none"></div>
            <input type="hidden" value="<% =Request.QueryString["surveyNo"] %>" id="txtsurveyNo" />
            <table id="d-example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th style="width: 2em; display: none">#</th>
                        <%--<th style="width: 12em;">Section Code</th>--%>
                        <th style="width: 20em;">Question</th>
                        <%--<th>Rating Type</th>--%>
                        <th>Response Value</th>
                        <th style="width: 50em;">General Response Statement</th>
                        <%-- <th>Assigned Weight</th> --%>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Back" formnovalidate ID="back" OnClick="back_Click" /></th>
                        <th></th>
                        <%--    <th></th>--%>
                        <th></th>
                        <th></th>
                        <th>
                            <button type="submit" class="btn btn-success btnInsertCmps" id="btnAddSubcomponent">Submit Response</button></th>
                    </tr>
                </tfoot>
                <tbody>
                    <%
                        string surveyNo = Request.QueryString["surveyNo"];
                        var nav = new Config().ReturnNav();
                        var quiz = nav.BRResponseQuestion.Where(x => x.Survey_Response_ID == surveyNo).ToList();
                        foreach (var project in quiz)
                        {
                    %>
                    <tr>
                        <td style="display: none">
                            <input class="form-control" type="text" value="<%=project.Question_ID %>" disabled="disabled" style="width: 5em;" /></td>
                        <%--  <td><textarea  disabled="disabled" style="width: 15em; word-wrap: break-word!important;" id="sectioncode"><%=project.Section_Code %></textarea></td>--%>
                        <td>
                            <textarea disabled="disabled" style="width: 20em; word-wrap: break-word!important;" id="question"><%=project.Question %></textarea></td>
                        <%-- <td><textarea  disabled="disabled" style="width: 9em; word-wrap: break-word!important;" id="ratingtypes"><%=project.Rating_Type %></textarea></td>--%>

                        <%
                            if (project.Rating_Type == "Options Text")
                            {
                        %>
                        <td>
                            <select style="width: 13em; height: 3em; word-wrap: break-word!important;" id="ratingtypeOption">
                                <option>4-AGREE</option>
                                <option>1-HIGHLY DISAGREE</option>
                            </select>
                        </td>
                        <%
                            }
                            else if (project.Rating_Type == "Open Text")
                            {
                        %>
                        <td style="width: 60px">
                            <input disabled="disabled" type="text" class="form-control" required="required" id="ratingtypeOpentext" /></td>
                        <%
                            }

                        %>
                        <td style="width: 100px">
                            <input type="text" class="form-control" required="required" id="generalresponse" /></td>
                        <%--<td><textarea  disabled="disabled" style="width: 9em; word-wrap: break-word!important;" id="tmaximumscore"><%=project.Assigned_Weight %></textarea></td>--%>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>

        $("body").delegate("#d-example2 .btnInsertCmps", "click", function (event) {
            //To prevent form submit after ajax call
            event.preventDefault();
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            $("#d-example2 TBODY TR").each(function () {
                var row = $(this);
                var onerfqitem = {};
                onerfqitem.SurveyNo = $("#txtsurveyNo").val();
                onerfqitem.QuestionCode = row.find("TD input").eq(0).val();
                onerfqitem.RatingOption = row.find("TD select").eq(0).val();
                //onerfqitem.RatingOpenText = row.find("TD select").eq(1).val();
                //onerfqitem.GeneralResponse = row.find("TD input").eq(2).val();

                //onerfqitem.RatingOption = $("#ratingtypeOption").val();
                //onerfqitem.RatingOpenText = $("#ratingtypeOpentext").val();
                onerfqitem.GeneralResponse = $("#generalresponse").val();
                allrfqitems.push(onerfqitem);

            });

            $.ajax({
                type: "POST",
                url: "BrResponseQuestions.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Items Added!",
                                text: "Survey Response saved successfully!",
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Survey Response saved successfully!");
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

    </script>
</asp:Content>
