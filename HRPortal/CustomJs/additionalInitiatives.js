//save additional activities
$(document).ready(function () {
    $("body").on("click", "#btnSaveAdditionalActivities2", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".additionalactivitiestable2 TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber1 = row.find('td:eq(0)').html();
            primiarydetails.startdate1 = row.find("TD input").eq(0).val();
            primiarydetails.enddate1 = row.find("TD input").eq(1).val();
            primiarydetails.agreedtarget1 = row.find("TD input").eq(2).val();
            primiarydetails.assignedweight1 = row.find("TD input").eq(3).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewIndividualScoreCard.aspx/InsertAdditionalActivities",
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

    //save core initiatives
    $(document).ready(function () {
        $("body").on("click", "#btnSaveAdditionalInitiativesActivities", function () {
            //Loop through the Table rows and build a JSON array.
            var CoreInitiatives = new Array();
            $(".Additionalactivities TBODY TR").each(function () {
                var row = $(this);
                var primarydetailsData = {};
                primarydetailsData.entrynumber = row.find('td:eq(0)').html();
                primarydetailsData.startdate = row.find("TD input").eq(0).val();
                primarydetailsData.enddate = row.find("TD input").eq(1).val();
                primarydetailsData.agreedtarget = row.find("TD input").eq(2).val();
                primarydetailsData.assignedweight = row.find("TD input").eq(3).val();
                primarydetailsData.comments = row.find("TD input").eq(4).val();
                CoreInitiatives.push(primarydetailsData);
            });
            console.log(JSON.stringify(CoreInitiatives))
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
                        data: '{primarydetailsData: ' + JSON.stringify(CoreInitiatives) + '}',
                        url: "NewIndividualScoreCard.aspx/InsertAdditionalActivities",
                        dataType: "json",
                        success: function (status) {
                            var registerstatus = status.d;
                            switch (registerstatus) {
                                case "success":
                                    Swal.fire
                                    ({
                                        title: "Additional Activities Submitted!",
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
                                        location.reload();
                                        return false;
                                    });
                                    PrimaryInitiative = [];
                                    $('#allsecondaryActivities').modal('hide');
                                    location.reload();
                                    return false;
                                    break;
                                default:
                                    Swal.fire({
                                        title: "Sorry,Details Submission Warning!!!",
                                        text: registerstatus,
                                        type: "warning"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $('#feedback').attr("class", "alert alert-warning");
                                        $("#feedback").css("color", "warning");
                                        $('#feedback').addClass('alert alert-warning');
                                        $("#feedback").html("Your Activity Details could not be successfully saved!");
                                        $("#feedback").html(registerstatus);
                                    });
                                    break;
                            }
                        },
                        error: function (err) {

                        }
                    });
                }
            })
        });
    });
});
