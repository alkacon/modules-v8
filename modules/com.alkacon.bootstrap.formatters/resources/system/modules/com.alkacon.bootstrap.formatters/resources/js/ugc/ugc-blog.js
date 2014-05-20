$(function() {
    // the user generated content handler object
    var ugc = new UGC("ugcForm");

    // optional back links
    var backLinkCancel = null;
    var backLinkSuccess = null;

    function initMappings() {
        ugc.map("title", "Title[1]", ugc.OPTIONAL);
        ugc.map("text", "Paragraph[1]/Text[1]");
        ugc.map("imagefile", "Paragraph[1]/Image[1]/Image[1]", ugc.UPLOAD);
        ugc.map("imagetitle", "Paragraph[1]/Image[1]/Title[1]", ugc.OPTIONAL);
        ugc.map("imagedescription", "Paragraph[1]/Image[1]/Description[1]", ugc.OPTIONAL);
        ugc.map("webpageurl", "Paragraph[1]/Link[1]/URI[1]");
        ugc.map("webpagenice", "Paragraph[1]/Link[1]/Text[1]");
        ugc.map("author", "Author[1]");
        ugc.map("authormail", "AuthorMail[1]", ugc.OPTIONAL);
    }

    function updateValues(uploadResults) {

        // fill the content in the UCG object with the mappings
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
            // both url and nice name are not provided, so delete the parent
            // node
            ugc.deleteParentContent("webpageurl");
        }

        if (!ugc.contentHas("imagefile")) {
            ugc.deleteParentContent("imagefile");
        }

        if (ugc.getForm("imageremove").prop('checked') == true) {
            // special form check "remove image" has been set, so delete the
            // image parent node
            ugc.deleteParentContent("imagefile");
        }

        return ugc.getContent();
    }

    function saveHandler(uploadResult) {
        ugc.getSession().saveContent(updateValues(uploadResult), afterSaveHandler, errorHandler);
    }

    function afterSaveHandler(session) {
        ugc.destroySession();
        if (backLinkSuccess != null) {
            window.location.href = backLinkSuccess;
        } else {
            alert("Saved and destroyed session.");
        }
    }

    function save() {
        ugc.getSession().uploadFiles([ "imagefile" ], saveHandler, errorHandler);
    }

    function validateHandler(errors) {
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

    function validate() {
        ugc.getSession().validate(updateValues(), validateHandler)
    }

    function cancel() {
        if (backLinkCancel != null) {
            window.location.href = backLinkCancel;
        } else {
            alert("Just go to another page to cancel.")
        }
    }

    function waitCallback(isWaiting) {
        if (isWaiting) {
            $("#postFormLoading").show();
        } else {
            $("#postFormLoading").hide();
        }
    }

    function errorHandler(errorType, message, additionalData) {
        var out = "Error of type: " + errorType + ": " + message;
        if (!$.isEmptyObject(additionalData)) {
            out += "\n\nAdditional information:\n";
            for ( var key in additionalData) {
                out += "\n" + key + ": " + additionalData[key];
            }
        }
        window.alert(out);
    }

    function newSessionHandler(session) {
        ugc.setSession(session);
        initMappings();
        ugc.setForm();
    }

    function showPicture() {
        var link = ugc.content["Paragraph[1]/Image[1]/Image[1]"];
        if (link != null) {
            ugc.getSession().getLink(link, function(cmslink) {
                var out = "<h2>The current picture</h2>";
                out += "<img src='" + cmslink + "' />";
                $('#showPicture').html(out);
                $('#showPicture').removeClass("invisible");
            })
        }
    }

    window.initUserContentForm = function() {
        if (ugc.getForm() != null) {
            var sessionId = ugc.getForm().attr("session-id");
            backLinkSuccess = ugc.getForm().attr("back-link-success");
            backLinkCancel = ugc.getForm().attr("back-link-cancel");
            OpenCmsXmlContentFormApi.setWaitIndicatorCallback(waitCallback);
            OpenCmsXmlContentFormApi.initFormForSession(sessionId, ugc.form, newSessionHandler, errorHandler);
            $("#saveButton").click(save);
            $("#validateButton").click(validate);
            $("#cancelButton").click(cancel)
        }
    }

    $(window).unload(function() {
        ugc.destroySession();
    });
});