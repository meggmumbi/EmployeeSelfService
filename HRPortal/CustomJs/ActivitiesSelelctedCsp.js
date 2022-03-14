$(document).ready(function () {
    $('#checkBoxAll').click(function () {
        var checked = this.checked;
    })
    var td2 = $("#primaryActivityInitiativeTableDetails")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });
    var selected_arr = [];
    $(".btn_applyActvities").on("click",
        function (e) {
            e.preventDefault();
            // Read all checked checkboxes
            $.each($("#primaryActivityInitiativeTableDetails tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords1').val();
                //document.getElementById("#selectedrecordid");
                //$('#goodselected').text();
                // $('#goodselected').
                selected_arr.push($(this).find('td').eq(2).text());
                //$(this).find('input[type=checkbox]').val());
                // $(this).find('td').eq(2).text()
            });
            var postData = {
                DocumentNo: $("#preapplicationo").val(),
                RfiDocumentNo: $('#prequaliinvitno').val(),
                ProcurementCategory: selected_arr
            };
            Swal.fire({
                title: "Confirm Prequalification Application?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"

            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: "/Home/InsertResponseLines",
                        type: "POST",
                        data: JSON.stringify(postData),
                        contentType: "application/json",
                        cache: false,
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.split('*');
                        status = registerstatus[0];
                        switch (status) {
                            case "success":
                                Swal.fire
                                ({
                                    title: "Prequalifications Categories Submitted!",
                                    text: status,
                                    type: "success"
                                }).then(() => {
                                    $("#goodsfeedback").css("display", "block");
                                    $("#goodsfeedback").css("color", "green");
                                    $('#goodsfeedback').attr("class", "alert alert-success");
                                    $("#goodsfeedback").html("Your Prequalifications Details have been successfully submitted.Kindly Proceed to fill in the rest details!");
                                    $("#goodsfeedback").css("display", "block");
                                    $("#goodsfeedback").css("color", "green");
                                    $("#goodsfeedback").html("Your Prequalifications Details have been successfully submitted.Kindly Proceed to fill in the rest details!");
                                    $("#goodsfeedback").reset();
                                });
                                selected_arr = [];
                                break;
                            default:
                                Swal.fire
                                ({
                                    title: "Prequalifications Error!!!",
                                    text: registerstatus[1],
                                    type: "error"
                                }).then(() => {
                                    $("#goodsfeedback").css("display", "block");
                                    $("#goodsfeedback").css("color", "red");
                                    $('#goodsfeedback').addClass('alert alert-danger');
                                    $("#goodsfeedback").html("Your Prequalifications Details could not be submitted.Kindly Proceed to fill in the rest details!" + registerstatus[1]);
                                });
                                selected_arr = [];
                                break;
                        }
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                        'Prequalifications Cancelled',
                        'You cancelled your supplier prequalifications submission details!',
                        'error'
                    );
                }
            });

        });
});