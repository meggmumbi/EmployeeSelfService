$(document).ready(function () {
    $("body").on("click", "#btnSaveCoreInitiatives", function () {
        //Loop through the Table rows and build a JSON array.
        var PrimaryInitiative = new Array();
        $(".primarycoreInitiativeTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.startdate = row.find("TD input").eq(0).val();
            primiarydetails.enddate = row.find("TD input").eq(1).val();
            primiarydetails.agreedtarget = row.find("TD input").eq(2).val();
            primiarydetails.assignedweight = row.find("TD input").eq(3).val();
            PrimaryInitiative.push(primiarydetails);
        });
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
                    data: '{primarydetails: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewIndividualScoreCard.aspx/InsertScoreCard",
                    dataType: "json",
                    success: function (status) {
                        switch (status.d) {
                            case "success":
                                Swal.fire
                                    ({
                                        title: "Details Updated Successfully!",
                                        text: "Your  details was Successfully Submmitted.",
                                        type: "success"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "green");
                                        $('#feedback').attr("class", "alert alert-success");
                                        $("#feedback").html("Your details was Successfully Submmitted");
                                        location.reload();
                                        return false;
                                    });
                                break;
                            case "found":
                                Swal.fire
                                    ({
                                        title: "Missing Activities",
                                        text: "Your Activity Could not be found",
                                        icon: "warning",
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "green");
                                        $('#feedback').attr("class", "alert alert-success");
                                        $("#feedback").html("Your Actvity Details could not be found");
                                        return false;
                                    });
                                break;
                            default:
                                Swal.fire
                                    ({
                                        title: "Details Submission Error!!!",
                                        text: "Error Occured when submmitting your details.Kindly Try Again",
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
            };
        });
    });
    ////////////////////////////////////////

    //$("body").on("click", "#btnSaveTargets", function () {
    //    //Loop through the Table rows and build a JSON array.
    //    var PerformanceLogs = new Array();
    //    $(".PerformanceTargetsTable TBODY TR").each(function () {
    //        var row = $(this);
    //        var primiarydetails = {};
    //        primiarydetails.entrynumber = row.find('td:eq(0)').html();
    //        primiarydetails.agreedtarget = $("#txtagreedtarget").val();
    //        //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
    //        PerformanceLogs.push(primiarydetails);
    //    });
    //    console.log(JSON.stringify(PerformanceLogs))

    //    $.ajax({
    //        type: "POST",
    //        url: "NewPerformanceLogEntry.aspx/InsertTergets",
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
    //                        location.reload();
    //                        return false;
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


    /////////////////////////////////////////////////////

    //$("body").on("click", "#btnSaveTargets", function () {
    //    //Loop through the Table rows and build a JSON array.
    //    var PerformanceLogs = new Array();
    //    $(".PerformanceTargetsTable TBODY TR").each(function () {
    //        var row = $(this);
    //        var primiarydetails = {};
    //        primiarydetails.entrynumber = row.find('td:eq(0)').html();
    //        primiarydetails.agreedtarget = $("#txtagreedtarget").val();
    //        //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
    //        PerformanceLogs.push(primiarydetails);
    //    });
    //    console.log(JSON.stringify(PerformanceLogs))
    //    $.ajax({
    //        type: "POST",
    //        contentType: "application/json; charset=utf-8",
    //        data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
    //        url: "NewPerformanceLogEntry.aspx/InsertTergets",
    //        dataType: "json",
    //        success: function (status) {
    //            switch (status.d) {
    //                case "success":
    //                    swal({
    //                        title: "Performance Targets Updated Successfully!",
    //                        text: "Your  details was Successfully Submmitted.",
    //                        icon: "success",
    //                    }).then(() => {
    //                        $("#feedback").css("display", "block");
    //                        $("#feedback").css("color", "green");
    //                        $('#feedback').attr("class", "alert alert-success");
    //                        $("#feedback").html("Your Performance Targets details was Successfully Submmitted");
    //                        // location.reload();
    //                        return false;
    //                    });
    //                    break;
    //                default:
    //                    swal({
    //                        title: "Performance Targets Submission Error!!!",
    //                        text: "Error Occured when submmitting your Performance Targets details.Kindly Try Again",
    //                        type: "error"
    //                    }).then(() => {
    //                        $("#feedback").css("display", "block");
    //                        $("#feedback").css("color", "red");
    //                        $('#feedback').addClass('alert alert-danger');
    //                        $("#feedback").html(status.d);
    //                    });
    //                    break;
    //            }

    //        }
    //    });
    //});

    //$('#checkBoxAllGoods').click(function () {
    //    var checked = this.checked;
    //})
    //var td2 = $(".primaryActivityInitiativeTableDetails")
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
    //console.log(j)
    //var selected_arr = [];
    //$(".btn_applyselectedActvitiess").on("click",
    //    function (e) {
    //        e.preventDefault();
    //        // Read all checked checkboxes
    //        $.each($(".primaryActivityInitiativeTableDetails tr.active"), function () {
    //            //procurement category
    //            var checkbox_value = $('#selectedactivityrecords1').val();
    //            selected_arr.push($(this).find('td').eq(1).text());
    //        });
    //        var postData = {
    //            ActivityCategory: selected_arr
    //        };
    //        console.log(JSON.stringify(postData))
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
    //                    //added s
    //                    url: "NewIndividualScoreCard.aspx/SubmitSelectedCategoriess",
    //                    type: "POST",
    //                    data: '{ActivityCategory: ' + JSON.stringify(TargetDetails) + '}',
    //                    contentType: "application/json",
    //                    cache: false,
    //                    dataType: "json",
    //                    processData: false
    //                }).done(function (status) {
    //                    switch (status) {
    //                        case "success":
    //                            Swal.fire
    //                            ({
    //                                title: "Activity Categories Submitted!",
    //                                text: status,
    //                                type: "success"
    //                            }).then(() => {
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "green");
    //                                $('#feedback').attr("class", "alert alert-success");
    //                                $("#feedback").html("Your Activity Details have been successfully submitted!");
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "green");
    //                                $("#feedback").html("Your Activity Details have been successfully submitted!");
    //                                $("#feedback").reset();
    //                            });
    //                            selected_arr = [];
    //                            $('.primaryActivities').modal('hide');
    //                            $.modal.close();
    //                            break;
    //                        default:
    //                            Swal.fire
    //                            ({
    //                                title: "feedback Error!!!",
    //                                text: status,
    //                                type: "error"
    //                            }).then(() => {
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "red");
    //                                $('#feedback').addClass('alert alert-danger');
    //                                $("#feedback").html("Your Activity Details could not be submitted!" + status);
    //                            });
    //                            selected_arr = [];
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


    $("body").on("click", ".btn_saveJDTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".JDTargetsTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.workplanno = row.find('td:eq(1)').html();
            primiarydetails.annualtarget = row.find("TD input").eq(0).val();
            primiarydetails.assignedweight = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);

            //$("#txtannualtarget").val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
        });
        console.log(JSON.stringify(PerformanceLogs))
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
                    url: "NewIndividualScoreCard.aspx/InsertJDTergets",
                    data: '{primiarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (status) {
                        switch (status.d) {
                            case "success":
                                Swal.fire
                                ({
                                    title: "Targets Added!",
                                    text: "Plog Targets saved successfully!",
                                    type: "success"
                                }).then(() => {
                                    $("#feedback").css("display", "block");
                                    $("#feedback").css("color", "green");
                                    $('#feedback').attr("class", "alert alert-success");
                                    $("#feedback").html("Plog Targets saved successfully!");
                                    location.reload();
                                    return false;
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

                console.log(PerformanceLogs);
            }
        });
    });


    //$("body").on("click", ".btnSavePlogActivities", function () {
    //    //Loop through the Table rows and build a JSON array.
    //    var AllPerformanceLogs = new Array();
    //    $(".AllPerformanceTargetsTable TBODY TR").each(function () {
    //        var row = $(this);
    //        var plogsdetails = {};
    //        plogsdetails.entrynumber = row.find('td:eq(0)').html();
    //        plogsdetails.achievedDate = row.find("TD input").eq(0).val();
    //        plogsdetails.agreedtarget = row.find("TD input").eq(1).val();
    //        plogsdetails.allcomments = row.find("TD input").eq(2).val();
    //        AllPerformanceLogs.push(plogsdetails);
    //    });
    //    console.log(JSON.stringify(AllPerformanceLogs))
    //    Swal.fire({
    //        title: "Confirm Activity Submission?",
    //        text: "Are you sure you would like to proceed with submission?",
    //        type: "warning",
    //        showCancelButton: true,
    //        closeOnConfirm: true,
    //        confirmButtonText: "Yes, Proceed!",
    //        confirmButtonClass: "btn-success",
    //        confirmButtonColor: "#008000",
    //        position: "center"
    //    }).then((result) => {
    //        if (result.value) {
    //            $.ajax({
    //                type: "POST",
    //                url: "NewPerformanceLogEntry.aspx/InsertTergets",
    //                data: '{primarydetails: ' + JSON.stringify(AllPerformanceLogs) + '}',
    //                contentType: "application/json; charset=utf-8",
    //                dataType: "json",
    //                success: function (status) {
    //                    switch (status.d) {
    //                        case "success":
    //                            Swal.fire
    //                            ({
    //                                title: "Targets Added!",
    //                                text: "Plog Targets saved successfully!",
    //                                type: "success"
    //                            }).then(() => {
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "green");
    //                                $('#feedback').attr("class", "alert alert-success");
    //                                $("#feedback").html("Plog Targets saved successfully!");
    //                                location.reload();
    //                                return false;
    //                            });
    //                            break;

    //                        case "componentnull":
    //                            Swal.fire
    //                            ({
    //                                title: "Component not filled!",
    //                                text: "Component field empty!",
    //                                type: "danger"
    //                            }).then(() => {
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "red");
    //                                $('#feedback').attr("class", "alert alert-danger");
    //                                $("#feedback").html("Component field empty!");
    //                            });
    //                            break;
    //                        default:
    //                            Swal.fire
    //                            ({
    //                                title: "Error!!!",
    //                                text: "Error Occured",
    //                                type: "error"
    //                            }).then(() => {
    //                                $("#feedback").css("display", "block");
    //                                $("#feedback").css("color", "red");
    //                                $('#feedback').addClass('alert alert-danger');
    //                                $("#feedback").html(status.d);
    //                            });

    //                            break;
    //                    }
    //                },
    //                error: function (err) {
    //                    console.log(err.statusText);
    //                    console.log(status.d);
    //                }

    //            });

    //            console.log(AllPerformanceLogs);
    //        }
    //    });
    //});


    //insert plog targets
    $("body").on("click", "#btnSavePlogAllTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PerformanceTargetsTableData TBODY TR").each(function () {
            alert = "found!";
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.docNo = row.find('td:eq(1)').html();
            primiarydetails.description = row.find('td:eq(2)').html();
            primiarydetails.actualTarget = row.find('td:eq(7)').html();
            primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            primiarydetails.Attachment = row.find("TD input").eq(2).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "PerformanceLog.aspx/InsertPlogTargets",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
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

        console.log(PerformanceLogs);

    });
    //insert selected core initiatives to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".primaryActivityInitiativeTableDetails1")
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
    $(".btn_applyallselectedActvities1").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".primaryActivityInitiativeTableDetails1 tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords1').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
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
                        url: "PerformanceLog.aspx/SubmitSelectedCoreInitiatives",
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
                                    location.reload();
                                    return false;
                                });
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
                                $.modal.close();
                                break;
                            default:
                                Swal.fire
                                ({
                                    title: "feedback Error!!!",
                                    text: registerstatus,
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
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                        'Activity Cancelled',
                        'You cancelled your Activity submission details!',
                        'error'
                    );
                }
            });

        });

    //insert selected additional initiatives to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".AdditionalToPlogTableDetails")
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
    $(".btn_AdditionalToPlogTableDetails").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".AdditionalToPlogTableDetails tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords2').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
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
                        url: "PerformanceLog.aspx/SubmitSelectedAddInitiatives",
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
                                    location.reload();
                                    return false;
                                });
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
                                $.modal.close();
                                break;
                            default:
                                Swal.fire
                                ({
                                    title: "feedback Error!!!",
                                    text: registerstatus,
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
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                        'Activity Cancelled',
                        'You cancelled your Activity submission details!',
                        'error'
                    );
                }
            });

        });

    //insert selected JD to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".JDInitiativeTableDetails")
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
    $(".btn_JDInitiativeTableDetails").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".JDInitiativeTableDetails tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords3').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
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
                        url: "PerformanceLog.aspx/SubmitSelectedJDInitiatives",
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
                                    location.reload();
                                    return false;
                                });
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
                                $.modal.close();
                                break;
                            default:
                                Swal.fire
                                ({
                                    title: "feedback Error!!!",
                                    text: registerstatus,
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
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                        'Activity Cancelled',
                        'You cancelled your Activity submission details!',
                        'error'
                    );
                }
            });

        });

//insert sub-plog lines
    $("body").on("click", "#btnSaveSubPlogLines", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PlogSubIndicatorTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entryNo = row.find('td:eq(0)').html();
            primiarydetails.plogNo = row.find('td:eq(1)').html();
            primiarydetails.initiativeNo = row.find('td:eq(2)').html();
            primiarydetails.pcId = row.find('td:eq(3)').html();
            primiarydetails.achievedTarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "SubPlogIndicators.aspx/InsertSubPlogLines",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Data Added!",
                            text: status.d,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: status.d,
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

        console.log(PerformanceLogs);

    });

    //Insert Standard Appraisal Objectives
    $("body").on("click", "#btn_objectivesandoutcomes", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".objectivesandoutcomes TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.Olineno = row.find('td:eq(0)').html();
            primiarydetails.Otargetquantity = $("#txtagreedtarget").val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewStandardAppraisal.aspx/InsertObjectives",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                            location.reload();
                            return false;
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

        console.log(PerformanceLogs);
    });

    //Insert Standard Appraisal Proficiency
    $("body").on("click", "#btn_proficiencyandevaluation", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".proficiencyandevaluation TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.lineno = row.find('td:eq(0)').html();
            primiarydetails.targetquantity = $("#txttarget").val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewStandardAppraisal.aspx/InsertProfiency",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                            location.reload();
                            return false;
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

        console.log(PerformanceLogs);
    });

});