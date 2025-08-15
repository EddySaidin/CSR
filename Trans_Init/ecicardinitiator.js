
$(document).ready(function() {

    // Initialize date picker for date inputs
    $('.dates').datepicker({
        dateFormat: "dd/mm/yy",
        changeMonth: true,
        changeYear: true
    });
    
    //Insert ECI Card Application
    $('#btnSave').on('click', function (e) {
        e.preventDefault(); // Prevent default button behavior
        
        // Clear trigbtn first
        $("#trigbtn").val("");
        
        console.log("btnSave clicked");
        
        // Validate required fields
        let isValid = true;
        let errorMessage = "";
        
        // Check description field
        const description = $('textarea[name="description"]').val().trim();
        if (!description) {
            isValid = false;
            errorMessage += "• Description is required\n";
            $('textarea[name="description"]').addClass('is-invalid');
        } else {
            $('textarea[name="description"]').removeClass('is-invalid');
        }
        
        // Check application type radio buttons
        const applicationType = $('input[name="application_type"]:checked').val();
        if (!applicationType) {
            isValid = false;
            errorMessage += "• Application Type is required\n";
            $('input[name="application_type"]').closest('.col-md').addClass('is-invalid');
        } else {
            $('input[name="application_type"]').closest('.col-md').removeClass('is-invalid');
        }
        
        // If validation fails, show error message
        if (!isValid) {
            Swal.fire({
                title: "Validation Error",
                text: "Please fill in all required fields:\n" + errorMessage,
                icon: "error",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "OK"
            });
            return;
        }
        
        // Show SweetAlert2 confirmation dialog
        Swal.fire({
            title: "Confirm Application",
            text: "Are you sure you want to submit this ECI Card application?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, submit it!",
            cancelButtonText: "Cancel"
        }).then((result) => {
            if (result.isConfirmed) {
                // User confirmed - Set trigbtn to "1" and submit the form
                $("#trigbtn").val("1");
                $("#apssforms").submit();
            }
        });
    });

    //Update ECI Card Application
    $('#btnUpdate').on('click', function (e) {
        e.preventDefault(); // Prevent default button behavior
        
        // Clear trigbtn first
        $("#trigbtn").val("");
        
        console.log("btnUpdate clicked");
        
        // Validate required fields
        let isValid = true;
        let errorMessage = "";
        
        // Check description field
        const description = $('textarea[name="description"]').val().trim();
        if (!description) {
            isValid = false;
            errorMessage += "• Description is required\n";
            $('textarea[name="description"]').addClass('is-invalid');
        } else {
            $('textarea[name="description"]').removeClass('is-invalid');
        }
        
        // Check application type radio buttons
        const applicationType = $('input[name="application_type"]:checked').val();
        if (!applicationType) {
            isValid = false;
            errorMessage += "• Application Type is required\n";
            $('input[name="application_type"]').closest('.col-md').addClass('is-invalid');
        } else {
            $('input[name="application_type"]').closest('.col-md').removeClass('is-invalid');
        }
        
        // If validation fails, show error message
        if (!isValid) {
            Swal.fire({
                title: "Validation Error",
                text: "Please fill in all required fields:\n" + errorMessage,
                icon: "error",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "OK"
            });
            return;
        }
        
        // Show SweetAlert2 confirmation dialog
        Swal.fire({
            title: "Confirm Update",
            text: "Are you sure you want to update this ECI Card application?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, update it!",
            cancelButtonText: "Cancel"
        }).then((result) => {
            if (result.isConfirmed) {
                // User confirmed - Set trigbtn to "2" and submit the form
                $("#trigbtn").val("0");
                $("#apssforms").submit();
            }
        });
    });

    //Handle Upload Modal Click
    $(document).on("click", ".btnUpload", function (e) { 
        $("#trx_checklist").val("");
        $("#rename").val("");
        $("#f").val("");
        $('.DialogUpload').modal('show', function (data) {});
        $(".submitupload").show();
        
        //Init the select2 for document type
        $('#trx_checklist').select2({
            dropdownParent: $('.DialogUpload .modal-body'),
            width: '100%'
        });
    });

    //Handle Submit Upload File
    $(document).on("click", ".submitupload", function (e) {
        //Prevent Instant Click  
        e.preventDefault();
        // Create an FormData object 
        if($("#trx_checklist").val()==""){ 
            $("#trx_checklist").focus().css("border", "1px solid red");
            var msg = "Sila pilih Senarai Semak Dokumen!"
            $(".msgchecklist").text(msg).addClass("requiredOption").show(); 
            e.preventDefault();
        }else if($("#rename").val()==""){
            $("#rename").focus().css("border", "1px solid red");
            e.preventDefault();
        }else if($("#f").val()==""){
            $("#f").focus().css("border", "1px solid red");
            e.preventDefault();
        }else{
            var formData = $("#formUpload").submit(function (e) {
                return;
            });
            $("#fullscreen").show();
            $('.DialogUpload').modal('hide', function (data) {});
            var formData = new FormData(formData[0]);
            $.ajax({
                url: $('#formUpload').attr('action'),
                type: 'POST',
                data: formData,
                success: function (html) {
                    $('.DialogUpload').modal('hide', function (data) {});
                    $(".ups").show();
                    $(".ups").load(location.href + " .ups>*", "");
                    //(".ups").load(window.location + " .ups");
                    $(".submitupload").hide();                    
                    var countItem = $(".nomup").length; 
                    var totup = countItem + 1
                    $("#totup").val(totup);                    
                    $(".msgattachment").hide(); 
                    $("#fullscreen").hide();                    
                    $("#upldMsg").text("File has been successfully uploaded to the system.").show().delay(2000).fadeOut();                              
                },
                contentType: false,
                processData: false,
                cache: false
            });
            Swal.fire({
                title: "Success!",
                text: "File has been successfully uploaded to the system.",
                icon: "success",
                timer: 2000,
                showConfirmButton: false
            });         
        }
        return false;
    });

    //Handle Staff Search Autocomplete
    $("#staffname").autocomplete({
        source: "a_empty.asp?action=auto_search_staff&typp=name",
        minLength: 3,
        select: function(event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
                $('#staffname').val("");
                $('#staffno').val("");
                $('#EmployeeGroup').val("");
                $('#EmployeeSubGroup').val("");
                $('#Division').val("");
                $('#Department').val("");
                $('#CostCenter').val("");
                $('#BA').val("");
                $('#PositionName').val("");
                $('#PayScaleGroup').val("");
                $('#Email1').val("");
                $('#ManagerName').val("");
                $('#HODeptName').val("");
            } else {
                $(this).removeClass("custplahol");
                $('#staffname').val(ui.item.value);
                $('#staffno').val(ui.item.employeecode);
                $('#EmployeeGroup').val(ui.item.EmployeeGroup);
                $('#EmployeeSubGroup').val(ui.item.EmployeeSubGroup);
                $('#Division').val(ui.item.Division);
                $('#Department').val(ui.item.Department);
                $('#CostCenter').val(ui.item.CostCenter);
                $('#BA').val(ui.item.BA);
                $('#PositionName').val(ui.item.PositionName);
                $('#PayScaleGroup').val(ui.item.PayScaleGroup);
                $('#Email1').val(ui.item.Email1);
                $('#ManagerName').val(ui.item.ManagerName);
                $('#HODeptName').val(ui.item.HODeptName);
            }
        },
        change: function (event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
                $('#staffno').val("");
                $('#EmployeeGroup').val("");
                $('#EmployeeSubGroup').val("");
                $('#Division').val("");
                $('#Department').val("");
                $('#CostCenter').val("");
                $('#BA').val("");
                $('#PositionName').val("");
                $('#PayScaleGroup').val("");
                $('#Email1').val("");
                $('#ManagerName').val("");
                $('#HODeptName').val("");
            } else {
                $(this).removeClass("custplahol");
                $('#staffname').val(ui.item.value);
                $('#staffno').val(ui.item.employeecode);
                $('#EmployeeGroup').val(ui.item.EmployeeGroup);
                $('#EmployeeSubGroup').val(ui.item.EmployeeSubGroup);
                $('#Division').val(ui.item.Division);
                $('#Department').val(ui.item.Department);
                $('#CostCenter').val(ui.item.CostCenter);
                $('#BA').val(ui.item.BA);
                $('#PositionName').val(ui.item.PositionName);
                $('#PayScaleGroup').val(ui.item.PayScaleGroup);
                $('#Email1').val(ui.item.Email1);
                $('#ManagerName').val(ui.item.ManagerName);
                $('#HODeptName').val(ui.item.HODeptName);
            }
        }
    });

    //Handle Staff Filter Autocomplete (for search form)
    $("#staffFilter").autocomplete({
        source: "a_empty.asp?action=auto_search_staff&typp=name",
        minLength: 3,
        select: function(event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
            } else {
                $(this).removeClass("custplahol");
                $('#staffFilter').val(ui.item.value);
            }
        },
        change: function (event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
            } else {
                $(this).removeClass("custplahol");
                $('#staffFilter').val(ui.item.value);
            }
        }
    });
});

//Delete Application Record
function deleteApplicationRecord(tkn) {
    console.log("DELETE_DEBUG: Delete function called with token:", tkn);
    
    // Show SweetAlert2 confirmation dialog
    Swal.fire({
        title: "Delete Record",
        text: "Do you want to delete this record?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel"
    }).then((result) => {
        if (result.isConfirmed) {
            console.log("DELETE_DEBUG: User confirmed deletion for token:", tkn);
            
            // User confirmed - proceed with deletion
            var queryString = 'delete_id=' + tkn;
            console.log("DELETE_DEBUG: Sending AJAX request with data:", queryString);
            
            jQuery.ajax({
                url: "?action=ecicardinitiator",
                data: queryString,
                type: "POST",
                success: function(data) {
                    console.log("DELETE_DEBUG: AJAX success response received");
                    console.log("DELETE_DEBUG: Response data:", data);
                    
                    // Check if the response contains debug information
                    if (data.includes("DELETE_DEBUG")) {
                        console.log("DELETE_DEBUG: Server-side debug info found in response");
                        // Extract debug info from HTML comments
                        var debugMatches = data.match(/<!-- DELETE_DEBUG: ([^>]+) -->/g);
                        if (debugMatches) {
                            debugMatches.forEach(function(match) {
                                console.log("DELETE_DEBUG: " + match.replace(/<!-- DELETE_DEBUG: | -->/g, ''));
                            });
                        }
                    }
                    
                    // Check if deletion was successful
                    if (data.includes("SUCCESS")) {
                        console.log("DELETE_DEBUG: Server confirmed successful deletion");
                        // Remove the row from the table
                        $('#delete_' + tkn).slideUp();
                        
                        // Show success message
                        Swal.fire({
                            title: "Deleted!",
                            text: "Record has been deleted successfully.",
                            icon: "success",
                            timer: 2000,
                            showConfirmButton: false
                        });
                    } else {
                        console.log("DELETE_DEBUG: Server did not confirm successful deletion");
                        // Show warning message
                        Swal.fire({
                            title: "Warning!",
                            text: "Delete operation may not have completed successfully. Please refresh the page to verify.",
                            icon: "warning",
                            confirmButtonColor: "#3085d6"
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.log("DELETE_DEBUG: AJAX error occurred");
                    console.log("DELETE_DEBUG: Token:", tkn);
                    console.log("DELETE_DEBUG: Status:", status);
                    console.log("DELETE_DEBUG: Error:", error);
                    console.log("DELETE_DEBUG: XHR response:", xhr.responseText);
                    
                    // Show error message
                    Swal.fire({
                        title: "Error!",
                        text: "Failed to delete record. Please try again. Check console for details.",
                        icon: "error",
                        confirmButtonColor: "#3085d6"
                    });
                }
            });
        } else {
            console.log("DELETE_DEBUG: User cancelled deletion for token:", tkn);
        }
    });
}

//Delete Application Documents
function deleteApplicationDocuments(tkn, application_toke) {
    console.log("DELETE_DEBUG: Delete function called with token:", tkn);
    
    // Show SweetAlert2 confirmation dialog
    Swal.fire({
        title: "Delete Document",
        text: "Do you want to delete this document? This action cannot be undone.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel"
    }).then((result) => {
        if (result.isConfirmed) {
            console.log("DELETE_DEBUG: User confirmed deletion for token:", tkn);
            
            // Show loading state
            Swal.fire({
                title: "Deleting...",
                text: "Please wait while we delete the document.",
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
            
            // User confirmed - proceed with deletion
            var queryString = 'delete_doc_id=' + tkn;
            console.log("DELETE_DEBUG: Sending AJAX request with data:", queryString);
            
            jQuery.ajax({
                url: "?action=editecicardinitiator&token=" + application_toke,
                data: queryString,
                type: "POST",
                success: function(data) {
                    console.log("DELETE_DEBUG: AJAX success response received");
                    console.log("DELETE_DEBUG: Response data:", data);
                    
                    // Check if the response contains debug information
                    if (data.includes("DELETE_DEBUG")) {
                        console.log("DELETE_DEBUG: Server-side debug info found in response");
                        // Extract debug info from HTML comments
                        var debugMatches = data.match(/<!-- DELETE_DEBUG: ([^>]+) -->/g);
                        if (debugMatches) {
                            debugMatches.forEach(function(match) {
                                console.log("DELETE_DEBUG: " + match.replace(/<!-- DELETE_DEBUG: | -->/g, ''));
                            });
                        }
                    }
                    
                    // Check if deletion was successful
                    if (data.includes("SUCCESS")) {
                        console.log("DELETE_DEBUG: Server confirmed successful deletion");
                        
                        // Close loading dialog
                        Swal.close();
                        
                        // Remove the row from the table with animation
                        $('#delete_' + tkn).fadeOut(400, function() {
                            $(this).remove();
                            
                            // Check if table is empty and show message
                            if ($('#tableatt tbody tr').length <= 1) { // Only header row left
                                $('#tableatt tbody').append('<tr><td colspan="10" class="text-center">No uploaded documents found.</td></tr>');
                            }
                        });
                        
                        // Show success message
                        Swal.fire({
                            title: "Deleted!",
                            text: "Document has been deleted successfully.",
                            icon: "success",
                            timer: 2000,
                            showConfirmButton: false
                        });
                        
                        // Refresh the page after a short delay to ensure data consistency
                        setTimeout(function() {
                            location.reload();
                        }, 2500);
                        
                    } else {
                        console.log("DELETE_DEBUG: Server did not confirm successful deletion");
                        
                        // Close loading dialog
                        Swal.close();
                        
                        // Show warning message
                        Swal.fire({
                            title: "Warning!",
                            text: "Delete operation may not have completed successfully. Please refresh the page to verify.",
                            icon: "warning",
                            confirmButtonColor: "#3085d6"
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.log("DELETE_DEBUG: AJAX error occurred");
                    console.log("DELETE_DEBUG: Token:", tkn);
                    console.log("DELETE_DEBUG: Status:", status);
                    console.log("DELETE_DEBUG: Error:", error);
                    console.log("DELETE_DEBUG: XHR response:", xhr.responseText);
                    
                    // Close loading dialog
                    Swal.close();
                    
                    // Show error message
                    Swal.fire({
                        title: "Error!",
                        text: "Failed to delete document. Please try again. Check console for details.",
                        icon: "error",
                        confirmButtonColor: "#3085d6"
                    });
                }
            });
        } else {
            console.log("DELETE_DEBUG: User cancelled deletion for token:", tkn);
        }
    });
}