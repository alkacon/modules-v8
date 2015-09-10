$(function() {

    // optional back link
    var backLink = null;
    
    // the user generated content handler object
    // UGC requires at least 3 arguments:
    // 1: The id of the form in the HTML
    // 2: The mapping callback function
    // 3: The error callback function
    // 4: (optional) The custom form init callback function
    // 5: (optional) The wait indicator callback function
    var ugc = new UGC("ugcForm", myMappings, myErrorHandler, myFormInitHandler, myWaitHandler);
    
    function myMappings() {
        // initialize the content mappings
        // arg 1: the id of the field in the HTML form
        // arg 2: the xPath of the content in the OpenCms object on the server
        // arg 3: (optionl) indicate if this is OPTIONAL or an UPLOAD
        //        values marked OPTIONAL will case the field to be removed in the XML content if the form value is empty
        //        UPLOAD is required for all form elements that are of type <input type="file"> 
        ugc.map("title", "Title[1]");
        ugc.map("text", "Paragraph[1]/Text[1]");
        ugc.map("imagefile", "Paragraph[1]/Image[1]/Image[1]", ugc.UPLOAD);
        ugc.map("imagetitle", "Paragraph[1]/Image[1]/Title[1]", ugc.OPTIONAL);
        ugc.map("imagedescription", "Paragraph[1]/Image[1]/Description[1]", ugc.OPTIONAL);
        ugc.map("webpageurl", "Paragraph[1]/Link[1]/URI[1]");
        ugc.map("webpagenice", "Paragraph[1]/Link[1]/Text[1]");
        ugc.map("author", "Author[1]");
        ugc.map("authormail", "AuthorMail[1]", ugc.OPTIONAL);
    }
    
    function myErrorHandler(errorType, message, additionalData) {
        // very simple error handler that just displays an alert box with the raw error text
        var out = "Error of type: " + errorType + ": " + message;
        if (!$.isEmptyObject(additionalData)) {
            out += "\n\nAdditional information:\n";
            for ( var key in additionalData) {
                out += "\n" + key + ": " + additionalData[key];
            }
        }
        window.alert(out);
    }    

    function myFormInitHandler() {
        // optional custom form init handler
        // purpose here: show the "remove image" option only if there actually IS an image in the existing content
        if (ugc.contentHas("imagefile")) {
            $('#imageOptions').show();
            ugc.setForm("imageuri", ugc.getContent("imagefile"));
        } else {            
            $('#imageOptions').hide();
        }
    }  
    
    function myWaitHandler(isWaiting) {
        // display a DIV in the HTML that contains a "please wait, loading" animation
        if (isWaiting) {
            $("#postFormLoading").show();
        } else {
            $("#postFormLoading").hide();
        }
    }      
    
    function updateValues(uploadResults) {

        // fill the content in the UGC object with the values of the form
        ugc.setContent();

        // check if we have upload results, if not set value to null
        var uploads = (typeof uploadResults === "undefined") ? null : uploadResults;
        if (uploads != null) {
            // we do have uploads
            var image = uploads["imagefile"];
            if (image) {
                // an image was uploaded
                ugc.setContent("imagefile", image);
            }
        }

        if (ugc.formHasNot("webpageurl", "webpagenice")) {
            // both url and nice name are not provided, delete the parent node
            ugc.deleteParentContent("webpageurl");
        }
        
        if (!ugc.contentHas("imagefile") || ugc.getForm("imageremove").prop('checked')) {
            // no image set or special form option "remove image" has been checked
            // delete the image parent node
            ugc.deleteParentContent("imagefile");
        }

        return ugc.getContent();
    }

    function afterSaveHandler(session) {
        // save the form - step 3 of 3
        // destroy the session and jump back to the list overview page
        ugc.destroySession();
        if (backLink != null) {
            window.location.href = backLink;
        } else {
            alert("Saved and destroyed session.");
        }
    }
    
    function afterUploadHandler(uploadResult) {
        // save the form - step 2 of 3
        // images are already uploaded, now generate the XML content that refers the images from all the form values
        ugc.saveContent(updateValues(uploadResult), afterSaveHandler);
    }

    function save() {
        // save the form - step 1 of 3
        // first the uploads must be handled, afterwards the form itself is processed in a callback
        ugc.uploadFiles([ "imagefile" ], afterUploadHandler);
    }

    function cancel() {
        // cancel the form operation, go back to previous page
        if (backLink != null) {
            window.location.href = backLink;
        } else {
            alert("Form operation was canceled.")
        }
    }

    function validate() {
        // validation of the form in this example relies on the server side, so we need another callback handler
        ugc.validate(updateValues(), validateHandler)
    }

    function validateHandler(errors) {
        // form validation handler that displays the results of the server side validation in a simple alert
        if ($.isEmptyObject(errors)) {
            alert("The values are valid!");
        } else {
            var out = "The following errors occurred:\n"
            for ( var key in errors) {
                out += "\n" + key + " : " + errors[key];
            }
            alert(out);
        }
    }
    
    
    window.initUgc = function() {
        if (ugc.initForm()) {

            // read the variables from the form HTML
            var sessionId = ugc.getForm().attr("ugc-id");            
            backLink = ugc.getForm().attr("back-link");

            // initialize the form
            ugc.init(sessionId);
            
            // attach event handlers to the action buttons
            $("#saveButton").click(save);
            $("#validateButton").click(validate);
            $("#cancelButton").click(cancel)
        }
    }

    $(window).unload(function() {
        // make sure to kill the UGC session if the page is just left
        ugc.destroySession();
    });
});