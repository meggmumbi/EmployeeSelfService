'use-strict';
//$('#checkBoxAllGoods').click(function () {
//    var checked = this.checked;
//})
//var td2 = $(".primaryActivityInitiativeTableDetails1")
//td2.on("change",
//    "tbody tr .checkboxes",
//    function () {
//        var t = jQuery(this).is(":checked"), selected_arr = [];
//        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
//            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
//        // Read all checked checkboxes
//        $("input:checkbox[class=checkboxes]:checked").each(function () {
//            selected_arr.push($(this).val());
//        });

//        if (selected_arr.length > 0) {
//            $("#rfiresponsefeedback").css("display", "block");

//        } else {
//            $("#rfiresponsefeedback").css("display", "none");
//            selected_arr = [];
//        }

//    });
////var selected_arr = [];
//var PrimaryInitiative = new Array();
//$(".btn_applyallselectedActvities1").on("click",
//    function (e) {
//        e.preventDefault();
//        PrimaryInitiative = [];
//        $.each($(".primaryActivityInitiativeTableDetails1 tr.active"), function () {
//            //procurement category
//            var checkbox_value = $('#selectedactivityrecords1').val();
//            var Targets = {};
//            Targets.targetNumber = ($(this).find('td').eq(1).text());
//            Targets.plogNo = ($(this).find('td').eq(5).text());
//            PrimaryInitiative.push(Targets);
//        });
//        var postData = {
//            catgeories: PrimaryInitiative
//        };
//        console.log(JSON.stringify(PrimaryInitiative))
//        Swal.fire({
//            title: "Confirm Activity Submission?",
//            text: "Are you sure you would like to proceed with submission?",
//            type: "warning",
//            showCancelButton: true,
//            closeOnConfirm: true,
//            confirmButtonText: "Yes, Proceed!",
//            confirmButtonClass: "btn-success",
//            confirmButtonColor: "#008000",
//            position: "center"

//        }).then((result) => {
//            if (result.value) {
//                $.ajax({
//                    type: "POST",
//                    contentType: "application/json; charset=utf-8",
//                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
//                    url: "PerformanceLog.aspx/SubmitSelectedCoreInitiatives",
//                    dataType: "json",
//                    processData: false
//                }).done(function (status) {
//                    var registerstatus = status.d;
//                    console.log(JSON.stringify(registerstatus))
//                    switch (registerstatus) {
//                        case "success":
//                            Swal.fire
//                            ({
//                                title: "Activity Categories Submitted!",
//                                text: registerstatus,
//                                type: "success"
//                            }).then(() => {
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "green");
//                                $('#feedback').attr("class", "alert alert-success");
//                                $("#feedback").html("Your Activity Details have been successfully submitted!");
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "green");
//                                $("#feedback").html("Your Activity Details have been successfully submitted!");
//                                location.reload();
//                                return false;
//                            });
//                            PrimaryInitiative = [];
//                            $('#primaryActivities').modal('hide');
//                            $.modal.close();
//                            break;
//                        default:
//                            Swal.fire
//                            ({
//                                title: "feedback Error!!!",
//                                text: registerstatus,
//                                type: "error"
//                            }).then(() => {
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "red");
//                                $('#feedback').addClass('alert alert-danger');
//                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
//                            });
//                            PrimaryInitiative = [];
//                            break;
//                    }
//                }
//                );
//            } else if (result.dismiss === Swal.DismissReason.cancel) {
//                Swal.fire(
//                    'Activity Cancelled',
//                    'You cancelled your Activity submission details!',
//                    'error'
//                );
//            }
//        });

//    });

////////////////////////////////////////
////plog targets
//$("body").on("click", "#btnSavePlogTargets", function () {
//    //Loop through the Table rows and build a JSON array.
//    var PerformanceLogs = new Array();
//    $(".PerformanceTargetsTable TBODY TR").each(function () {
//        var row = $(this);
//        var primiarydetails = {};
//        primiarydetails.entrynumber = row.find('td:eq(0)').html();
//        primiarydetails.docNo = row.find('td:eq(1)').html();
//        primiarydetails.description = row.find('td:eq(2)').html();
//        primiarydetails.actualTarget = row.find('td:eq(7)').html();
//        primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
//        primiarydetails.comments = row.find("TD input").eq(1).val();
//        PerformanceLogs.push(primiarydetails);
//    });
//    console.log(JSON.stringify(PerformanceLogs))

//    $.ajax({
//        type: "POST",
//        url: "PerformanceLog.aspx/InsertTergets",
//        data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: function (status) {
//            switch (status.d) {
//                case "success":
//                    Swal.fire
//                    ({
//                        title: "Targets Added!",
//                        text: "Achieved Targets saved successfully!",
//                        type: "success"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "green");
//                        $('#feedback').attr("class", "alert alert-success");
//                        $("#feedback").html("Achieved Targets saved successfully!");
//                    });
//                    break;

//                case "componentnull":
//                    Swal.fire
//                    ({
//                        title: "Component not filled!",
//                        text: "Component field empty!",
//                        type: "danger"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "red");
//                        $('#feedback').attr("class", "alert alert-danger");
//                        $("#feedback").html("Component field empty!");
//                    });
//                    break;
//                default:
//                    Swal.fire
//                    ({
//                        title: "Error!!!",
//                        text: status.d,
//                        type: "error"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "red");
//                        $('#feedback').addClass('alert alert-danger');
//                        $("#feedback").html(status.d);
//                    });

//                    break;
//            }
//        },
//        error: function (err) {
//            console.log(err.statusText);
//            console.log(status.d);
//        }

//    });

//    console.log(PerformanceLogs);

//});

////////////////////////////////////////
//sub plog lines
//$("body").on("click", "#btnSaveSubPlogLines", function () {
//    //Loop through the Table rows and build a JSON array.
//    var PerformanceLogs = new Array();
//    $(".PlogSubIndicatorTable TBODY TR").each(function () {
//        var row = $(this);
//        var primiarydetails = {};
//        primiarydetails.entryNo = row.find('td:eq(0)').html();
//        primiarydetails.plogNo = row.find('td:eq(1)').html();
//        primiarydetails.initiativeNo = row.find('td:eq(2)').html();
//        primiarydetails.pcId = row.find('td:eq(3)').html();
//        primiarydetails.achievedTarget = row.find("TD input").eq(0).val();
//        primiarydetails.comments = row.find("TD input").eq(1).val();
//        PerformanceLogs.push(primiarydetails);
//    });
//    console.log(JSON.stringify(PerformanceLogs))

//    $.ajax({
//        type: "POST",
//        url: "SubPlogIndicators.aspx/InsertSubPlogLines",
//        data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: function (status) {
//            switch (status.d) {
//                case "success":
//                    Swal.fire
//                    ({
//                        title: "Data Added!",
//                        text: status.d,
//                        type: "success"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "green");
//                        $('#feedback').attr("class", "alert alert-success");
//                        $("#feedback").html("Achieved Targets saved successfully!");
//                    });
//                    break;

//                case "componentnull":
//                    Swal.fire
//                    ({
//                        title: "Component not filled!",
//                        text: status.d,
//                        type: "danger"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "red");
//                        $('#feedback').attr("class", "alert alert-danger");
//                        $("#feedback").html("Component field empty!");
//                    });
//                    break;
//                default:
//                    Swal.fire
//                    ({
//                        title: "Error!!!",
//                        text: "Error Occured",
//                        type: "error"
//                    }).then(() => {
//                        $("#feedback").css("display", "block");
//                        $("#feedback").css("color", "red");
//                        $('#feedback').addClass('alert alert-danger');
//                        $("#feedback").html(status.d);
//                    });

//                    break;
//            }
//        },
//        error: function (err) {
//            console.log(err.statusText);
//            console.log(status.d);
//        }

//    });

//    console.log(PerformanceLogs);

//});

//var PrimaryInitiative = new Array();
//$(".btnSaveSelectedPlog").on("click",
//    function (e) {
//        e.preventDefault();
//        PrimaryInitiative = [];
//        $.each($(".AllDetailsplogTable tr.active"), function () {
//            //procurement category
//            var checkbox_value = $('#selectedplogactivity').val();
//            var Targets = {};
//            Targets.targetNumber = ($(this).find('td').eq(1).text());
//            //Targets.plogNo = $("#txtPlogNumber").val();
//            PrimaryInitiative.push(Targets);
//            alert = Targets.targetNumber;
//        });
//        var postData = {
//            catgeories: PrimaryInitiative
//        };
//        console.log(JSON.stringify(PrimaryInitiative))
//        Swal.fire({
//            title: "Confirm Activity Submission?",
//            text: "Are you sure you would like to proceed with submission?",
//            type: "warning",
//            showCancelButton: true,
//            closeOnConfirm: true,
//            confirmButtonText: "Yes, Proceed!",
//            confirmButtonClass: "btn-success",
//            confirmButtonColor: "#008000",
//            position: "center"

//        }).then((result) => {
//            if (result.value) {
//                $.ajax({
//                    type: "POST",
//                    contentType: "application/json; charset=utf-8",
//                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
//                    url: "PerformanceLog.aspx/SubmitSelectedCoreInitiatives",
//                    dataType: "json",
//                    processData: false
//                }).done(function (status) {
//                    var registerstatus = status.d;
//                    console.log(JSON.stringify(registerstatus))
//                    switch (registerstatus) {
//                        case "success":
//                            Swal.fire
//                            ({
//                                title: "Activity Categories Submitted!",
//                                text: registerstatus,
//                                type: "success"
//                            }).then(() => {
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "green");
//                                $('#feedback').attr("class", "alert alert-success");
//                                $("#feedback").html("Your Activity Details have been successfully submitted!");
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "green");
//                                $("#feedback").html("Your Activity Details have been successfully submitted!");
//                                location.reload();
//                                return false;
//                            });
//                            PrimaryInitiative = [];
//                            $('#primaryActivities').modal('hide');
//                            $.modal.close();
//                            break;
//                        default:
//                            Swal.fire
//                            ({
//                                title: "feedback Error!!!",
//                                text: registerstatus,
//                                type: "error"
//                            }).then(() => {
//                                $("#feedback").css("display", "block");
//                                $("#feedback").css("color", "red");
//                                $('#feedback').addClass('alert alert-danger');
//                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
//                            });
//                            PrimaryInitiative = [];
//                            break;
//                    }
//                }
//                );
//            } else if (result.dismiss === Swal.DismissReason.cancel) {
//                Swal.fire(
//                    'Activity Cancelled',
//                    'You cancelled your Activity submission details!',
//                    'error'
//                );
//            }
//        });

//    });