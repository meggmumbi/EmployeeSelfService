'use-strict';
$('#checkBoxAllGoods').click(function () {
    var checked = this.checked;
})
var td2 = $(".primaryActivityInitiativeTableDetails")
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
//var selected_arr = [];
var PrimaryInitiative = new Array();
$(".btn_applyallselectedActvities").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        $.each($(".primaryActivityInitiativeTableDetails tr.active"), function () {
            var checkbox_value = $('#selectedactivityrecords1').val();
            var Targets = {};
            Targets.targetNumber = ($(this).find('td').eq(1).text());
            PrimaryInitiative.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
        Swal.fire({
            title: "Confirm Activity Submission?",
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
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewIndividualScoreCard.aspx/SubmitSelectedCategories",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Activity Categories Submitted!",
                                text: registerstatus,
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").reset();
                                return false;
                                PrimaryInitiative = [];
                                $("#activityNumber").val('');
                            });
                            PrimaryInitiative = [];
                            $('#primaryActivities').modal('hide');
                            location.reload();
                            return false;
                            break;
                        case "found":
                            Swal.fire
                             ({
                                 title: "Missing Activity Categories!",
                                 text: "The Primary Core Inititives Selected could not be found on your Performance Contract Objective Lines",
                                 type: "warning"
                             }).then(() => {
                                 $("#feedback").css("display", "block");
                                 $("#feedback").css("color", "warning");
                                 $('#feedback').attr("class", "alert alert-success");
                                 $("#feedback").html("Your Activity Details could not be found!");
                                 $("#feedback").css("display", "block");
                                 $("#feedback").css("color", "warning");
                                 $("#feedback").html("Your Activity Details could not be found!");
                                 $("#feedback").reset();
                                 location.reload();
                                 return false;
                                 PrimaryInitiative = [];
                             });
                            PrimaryInitiative = [];
                            $('#primaryActivities').modal('hide');
                            location.reload();
                            return false;
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Categories Error!!",
                                text: "The Primary Core Initives Lines could not be submitted.Kindly try again later"+ registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiative = [];
                            break;
                    }
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled your Activity submission details!',
                    'error'
                );
            }
        });
    });


