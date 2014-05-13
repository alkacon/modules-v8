 $(function() {
    var session = null;
    var content = null;
    var formId = "ugcForm";
    var formIdHash = "#" + formId;
    var backLinkCancel = null;
    var backLinkSuccess = null;

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
            for (var key in additionalData) {
                out += "\n" + key + ": " + additionalData[key];
            }
        }
        window.alert(out);
    }
    
    function onNewSession(s) {
        session = s;
        content = session.getValues();
        fillForm();
        //showPicture();
    }       
    
    function create(ugcConfig) { 
        var elem = document.getElementById( formId );
        OpenCmsXmlContentFormApi.initFormForNewContent( ugcConfig, elem
                                                       , onNewSession
                                                       , errorHandler
                                                      );    
    }
    
    function access(sessionId) {
        var elem = document.getElementById( formId );
        OpenCmsXmlContentFormApi.initFormForSession( sessionId, elem
                                                    , onNewSession
                                                    , errorHandler
                                                   );
    }
    
    function updateValues() { 
        var result = {} ; 
        if (content != null) {
            for (var key in content) {
                if (content.hasOwnProperty(key)) {
                    result[key]=content[key];
                }
            }
        }
        result["Paragraph[1]/Headline[1]"] =  $(formIdHash +" input[name='headline']").val();
        result["Paragraph[1]/Text[1]"] =  $(formIdHash +" textarea[name='text']").val(); 
        if ($(formIdHash +" input[name='imagefile']").val() !== '') {
            result["Paragraph[1]/Image[1]/Title[1]"] =  $(formIdHash +" input[name='imagetitle']").val(); 
            result["Paragraph[1]/Image[1]/Description[1]"] =  $(formIdHash +" input[name='imagedescription']").val(); 
        }
        var webpageurl = $(formIdHash +" input[name='webpageurl']").val();
        var webpagenice = $(formIdHash +" input[name='webpagenice']").val();
        if (webpageurl === '' && webpagenice === '') {
            delete result["Paragraph[1]/Link[1]/URI[1]"];
            delete result["Paragraph[1]/Link[1]/Text[1]"];
        } else {
            result["Paragraph[1]/Link[1]/URI[1]"] =  $(formIdHash +" input[name='webpageurl']").val(); 
            result["Paragraph[1]/Link[1]/Text[1]"] =  $(formIdHash +" input[name='webpagenice']").val(); 
        }
        result["Author[1]"] =  $(formIdHash +" input[name='author']").val();
        var authormail = $(formIdHash +" input[name='authormail']").val();
        if (authormail != "") {
            result["AuthorMail[1]"] = authormail;
        } else {
            delete result["AuthorMail[1]"];
        }
        if ($(formIdHash +" input[name='imageremove']").prop('checked') == true) {
            // the file cannot be deleted, it is only removed from the content
            result["Paragraph[1]/Image[1]"] = null;
            delete result["Paragraph[1]/Image[1]/Image[1]"];
            delete result["Paragraph[1]/Image[1]/Title[1]"];
            delete result["Paragraph[1]/Image[1]/Description[1]"];
        }
        return result; 
    }
    
    function fillForm() {
        if (content != null) {
            $(formIdHash +" input[name='headline']").val(content["Paragraph[1]/Headline[1]"]);
            $(formIdHash +" textarea[name='text']").val(content["Paragraph[1]/Text[1]"]); 
            $(formIdHash +" input[name='imagetitle']").val(content["Paragraph[1]/Image[1]/Title[1]"]); 
            $(formIdHash +" input[name='imagedescription']").val(content["Paragraph[1]/Image[1]/Description[1]"]); 
            $(formIdHash +" input[name='webpageurl']").val(content["Paragraph[1]/Link[1]/URI[1]"]); 
            $(formIdHash +" input[name='webpagenice']").val(content["Paragraph[1]/Link[1]/Text[1]"]); 
            $(formIdHash +" input[name='author']").val(content["Author[1]"]);
            $(formIdHash +" input[name='authormail']").val(content["AuthorMail[1]"]);
        }
    }
    function saveContent(uploadResult) {
        // alert("UploadResult: " + uploadResult["imagefile"]);
        var newValues = updateValues();
        var pic = uploadResult["imagefile"];
        if (pic) { // file for upload is given
            newValues["Paragraph[1]/Image[1]/Image[1]"] = pic;
        } 
        session.saveContent(
            newValues
            , function(s) {
                session.destroy();
                if(backLinkSuccess != null) {
                    window.location.href = backLinkSuccess;             
                } else {
                    alert("Saved and destroyed session.");
                }
            }
            , errorHandler
        );      
    }
    function save() { 
        session.uploadFiles(["imagefile"], saveContent, errorHandler);
    }
    
    function validate() {
        var newValues = updateValues();
        session.validate(newValues, validationSuccessHandler)
    }
    
    function cancel() {
        //alert("Cancel");
        if (backLinkCancel != null) {
            window.location.href = backLinkCancel;
        } else {
            alert("Just go to another page to cancel.")
        }
    }
    
    function validationSuccessHandler(errors) {
        if ($.isEmptyObject(errors)) {
            alert("The values are valid!");
        } else {
            var out = "The following errors occurred:\n"
            for(var key in errors) {
                out += "\n" + key + " : " + errors[key];
            }
            alert(out);
        }
    }
    
    function showPicture() {
        var link = content["Paragraph[1]/Image[1]/Image[1]"];
        if ( link != null) {
            session.getLink(link, function(cmslink) {
                var out = "<h2>The current picture</h2>";
                out += "<img src='" + cmslink + "' />";
                $('#showPicture').html(out);
                $('#showPicture').removeClass("invisible");
            })
        }
    }
    
    window.initUserContentForm = 
        function() {
            var form = $( formIdHash );
            if (form != null) {
                var sessionId = form.attr("session-id");
                var ugcConfig = form.attr("ugc-config");
                backLinkSuccess = form.attr("back-link-success");
                backLinkCancel = form.attr("back-link-cancel");
                if (ugcConfig != null && ugcConfig !== "") {
                    OpenCmsXmlContentFormApi.setWaitIndicatorCallback(waitCallback);
                    if (sessionId != null && sessionId === "") {
                        create(ugcConfig);      
                    } else {
                        access(sessionId);          
                    }
                    $("#saveButton").click(save);
                    $("#validateButton").click(validate);
                    $("#cancelButton").click(cancel)
                }
            }
        }
        
    $(window).unload(function() {
        if (session != null) { session.destroy(); }
    });
}); 