$(document).ready(function () {
        $("body").on("click", ".btnInsertCmps", function () {
        //To prevent form submit after ajax call
        //event.preventDefault();
        //Loop through the Table rows and build a JSON array.
        var allrfqitems = new Array();
        $(".RatingTable TBODY TR").each(function () {
            var row = $(this);
            var onerfqitem = {};
            onerfqitem.docNo = row.find("TD input").eq(0).val();
            onerfqitem.LineNo = row.find("TD input").eq(1).val();
            onerfqitem.Rating = row.find("TD select").eq(0).val();
            onerfqitem.CategoryCode = row.find("TD input").eq(2).val();
            onerfqitem.CategoryDescription = row.find("TD input").eq(3).val();
            onerfqitem.Comment = row.find("TD input").eq(4).val();
            onerfqitem.TrainingCategory = row.find("TD input").eq(5).val();
            allrfqitems.push(onerfqitem);

        });

        $.ajax({
            type: "POST",
            url: "TrainingFeedback.aspx/InsertComponentItems",
            data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Items Added!",
                            text: "Feedback comments saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("The Feedback comments have been saved successfully");
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
                            title: "An Error Occured!!!",
                            text: status.d,
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

    //evaluation
        $("body").on("click", ".btnInsertCmps1", function () {
            //To prevent form submit after ajax call
            //event.preventDefault();
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            $(".RatingTable1 TBODY TR").each(function () {
                var row = $(this);
                var onerfqitem = {};
                onerfqitem.docNo = row.find("TD input").eq(0).val();
                onerfqitem.LineNo = row.find("TD input").eq(1).val();
                onerfqitem.Rating = row.find("TD select").eq(0).val();
                onerfqitem.Comment = row.find("TD input").eq(2).val();
                allrfqitems.push(onerfqitem);

            });

            $.ajax({
                type: "POST",
                url: "TrainingEvaluation.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Items Added!",
                                text: "Evaluation comments saved successfully!",
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("The Evaluation comments have been saved successfully");
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
                                title: "An Error Occured!!!",
                                text: status.d,
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
});