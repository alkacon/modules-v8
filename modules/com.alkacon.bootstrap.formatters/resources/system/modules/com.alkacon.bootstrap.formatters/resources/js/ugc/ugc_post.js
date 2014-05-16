 function UGC (formId) {
    // UCG session
    this.session = null;
    // the content as it wsa provided from the server
    this.content = null;
    // the id of the form in the HTML
    this.formId = formId;
    
    // the mappings from form field id's to XML content xpath
    this.mappings = {};
    // a copy / clone of the content, used for the modified result
    this.contentClone = null;
    
    this.OPTIONAL = "OPTIONAL";
    this.UPLOAD = "UPLOAD";
 }
 
function UGCMapping (ugc, args) {
    // this is the main mapping object that maps a form Id to a content xpath
    this.formId = args[0];
    this.contentPath = args[1];
    this.isUpload = false;
    this.deleteEmptyValue = false;
    this.notEmpty = false;
    if (args.length > 1) {
        // check the additional arguments for further options
        for (i = 2; i < args.length; i++) {
            if (ugc.UPLOAD === args[i]) {
                // mark this as an upload field, which means we don't fill it automatically in the form and content             
                this.isUpload = true;               
            } else if (ugc.OPTIONAL === args[i]) {
                // decides if an empty value is actually deleted in the modified content, 
                // or kept as an empty string (the default)
                // use this for optional values in the XML content that should be fully removed
                // if only an empty string is provided in the form
                this.deleteEmptyValue = true;
            }
            // else { alert("Ignoring: " + args[i]); }
        }
    }
}

UGC.prototype.map = function() {
    // add a new mapping
    var mapping = new UGCMapping(this, arguments);
    // this.debugMap(mapping);
    this.mappings[arguments[0]] = mapping;
}
 
UGC.prototype.debugMap = function(mapping) {
    alert("Xpath: " + mapping.contentPath + "\nFormId: " +  mapping.formId + "\nDeleteEmpty: " + mapping.deleteEmptyValue + "\nUpload: " + mapping.isUpload);
}       

UGC.prototype.debugContent = function(contentArray) {
    var result = "";
    for (var key in contentArray) {
        if (contentArray.hasOwnProperty(key)) {
            var value = contentArray[key];
            result += "Xpath: " + key + "\nValue: " + value + "\n\n";
        }
    }
    alert(result);
}

 UGC.prototype.getForm = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // lookup the form element with the given name
        return $("#" + this.formId + " :input[name='" + arguments[0] + "']");
    } else if (arguments.length == 0) {
        // zero arguments, return the complete form
        return $("#" + this.formId);        
    }
    // no argument returns null
    return null;
}; 

UGC.prototype.getFormVal = function(name) {
    // lookup the value from the form element with the given name
    return this.getForm(name).val();
};

UGC.prototype.getXpath = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        return this.mappings[arguments[0]].contentPath;
    }
    return null;
}

 UGC.prototype.formHas = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the form element with the given name
        return this.getFormVal(arguments[0]).trim().length > 0;
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; i++) {    
            if (this.formHasNot(arguments[i])) {
                return false;
            }
        }
        return true;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.formHasNot = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the form element with the given name
        return this.getFormVal(arguments[0]).trim().length <= 0;
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; ++i) {
            if (this.formHas(arguments[i])) {
                return false;
            }
        }   
        return true;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.formHasOne = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the form element with the given name
        return this.formHas(arguments[0]);
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; ++i) {
            if (this.formHas(arguments[i])) {
                return true;
            }
        }   
        return false;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.contentHas = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the content array
        var value = this.getContent(arguments[0]);
        return (typeof value === "undefined") ? false : true;
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; i++) {    
            if (this.contentHasNot(arguments[i])) {
                return false;
            }
        }
        return true;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.contentHasNot = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the content array
        var value = this.getContent(arguments[0]);
        return (typeof value === "undefined") ? true : false;
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; i++) {    
            if (this.contentHas(arguments[i])) {
                return false;
            }
        }
        return true;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.contentHasOne = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // single value: lookup the value from the content array
        return this.contentHas(arguments[0]);
    } else {
        // iterate the array of arguments and check for all with shout-circuit
        for (i = 0; i < arguments.length; ++i) {
            if (this.contentHas(arguments[i])) {
                return true;
            }
        }   
        return false;
    }
    // in case of no arguments at all
    return false;
};

 UGC.prototype.setForm = function() {
    // check if the name parameter was provided, if not we have to initialize everything later
    if (this.content != null) {
        if (arguments.length == 1) {
            // set the form element with the given name to the content value stored in the mapping with the same name
            this.getForm(arguments[0]).val(this.content[this.mappings[arguments[0]].contentPath]);
        } else {
            // fill the complete form with all mapped values
            this.fillForm();
        }
    }
};

 UGC.prototype.setContent = function() {
    // check if the name parameter was provided, if not we have to initialize everything later
    var formId = (arguments.length > 0) ? arguments[0] : null;
    if (this.contentClone == null) {
        // initialize the content clone on first call
        this.createContentClone();  
    }
    if (formId != null) {
        // set the content (clone) value stored in the mapping with the given name to the form element value with the same 
        var value = (arguments.length > 1) ? arguments[1] : this.getFormVal(formId);
        var mapping = this.mappings[formId];
        this.contentClone[mapping.contentPath] = value;
        if (value.trim().length <= 0) {
            if (mapping.deleteEmptyValue) {
                this.contentClone[mapping.contentPath] = null;
            }       
        }
    } else {
        // no form id provided, set the complete content with all mapped values
        this.fillContent();     
    }
};

 UGC.prototype.deleteContent = function(name) {
    if (this.contentClone != null) {
        // delete the content (clone) value stored in the mapping with the given name
        this.contentClone[this.mappings[name].contentPath] = null;
    }
};

 UGC.prototype.deleteParentContent = function(name) {
    if (this.contentClone != null) {
        // delete the content (clone) value stored in the mapping with the given name
        var xpath = this.mappings[name].contentPath;
        var parentName = xpath.substring(0, xpath.lastIndexOf("/"));
        for (var key in this.contentClone) {
            if (this.content.hasOwnProperty(key) && (key.indexOf(parentName) == 0)) {
                delete this.contentClone[key];
            }
        }
        this.contentClone[parentName] = null;
    }
};

 UGC.prototype.getContent = function() {
    // check if we have one or more arguments
    if (arguments.length == 1) {
        // return the selected value from the original content array
        return this.contentClone[this.getXpath(arguments[0])];
    } 
    // return the content complete clone map
    return this.contentClone;
};

UGC.prototype.createContentClone = function() {
    // initialize the clone array
    this.contentClone = {}; 
    if (this.content != null) {
        // copy all the elements from the content to the clone
        for (var key in this.content) {
            if (this.content.hasOwnProperty(key)) {
                this.contentClone[key] = this.content[key];
            }
        }
    }
    // return the generated clone
    return this.contentClone;
}

UGC.prototype.fillForm = function() {
    // iterate over all mappings, fill the form with the mapped values
    for (var key in this.mappings) {
        var mapping = this.mappings[key];
        if (!mapping.isUpload) { 
            this.setForm(mapping.formId);
        } // else { alert("Ignoring: " + mapping.contentPath); }
    }
}

UGC.prototype.fillContent = function() {
    // iterate over all mappings, fill the content with values from the mapped form elements
    for (var key in this.mappings) {
        var mapping = this.mappings[key];   
        if (!mapping.isUpload) { 
            this.setContent(mapping.formId);
        } // else { alert("Ignoring: " + mapping.contentPath); }
    }
}

UGC.prototype.setSession = function(session) {
    // set the session to the provided parameter
    this.session = session;
    // initialize the content from the session
    this.content = this.session.getValues();
};

UGC.prototype.getSession = function() {
    // wrapper for session
    return this.session;
};

UGC.prototype.destroySession = function() {
    // wrapper for session
    if (this.session != null) this.session.destroy();
};

$(function() {
    // the user generated content handler object
    var ugc = new UGC("ugcForm");
    
    // optional back links
    var backLinkCancel = null;
    var backLinkSuccess = null;
    
    function initMappings() {
        ugc.map("headline",         "Paragraph[1]/Headline[1]", ugc.OPTIONAL);
        ugc.map("text",             "Paragraph[1]/Text[1]");
        ugc.map("imagefile",        "Paragraph[1]/Image[1]/Image[1]", ugc.UPLOAD);
        ugc.map("imagetitle",       "Paragraph[1]/Image[1]/Title[1]", ugc.OPTIONAL);
        ugc.map("imagedescription", "Paragraph[1]/Image[1]/Description[1]", ugc.OPTIONAL);
        ugc.map("webpageurl",       "Paragraph[1]/Link[1]/URI[1]");
        ugc.map("webpagenice",      "Paragraph[1]/Link[1]/Text[1]");
        ugc.map("author",           "Author[1]");
        ugc.map("authormail",       "AuthorMail[1]", ugc.OPTIONAL);
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
            // both url and nice name are not provided, so delete the parent node
            ugc.deleteParentContent("webpageurl");
        }
        
        if(! ugc.contentHas("imagefile")) {
            ugc.deleteParentContent("imagefile");
        }
        
        if (ugc.getForm("imageremove").prop('checked') == true) {
            // special form check "remove image" has been set, so delete the image parent node
            ugc.deleteParentContent("imagefile");
        }
        
        return ugc.getContent(); 
    }
    
    function saveHandler(uploadResult) {
        ugc.getSession().saveContent(updateValues(uploadResult), afterSaveHandler, errorHandler);      
    }
    
    function afterSaveHandler(session) {
        ugc.destroySession();
        if(backLinkSuccess != null) {
            window.location.href = backLinkSuccess;             
        } else {
            alert("Saved and destroyed session.");
        }
    }   
    
    function save() { 
        ugc.getSession().uploadFiles(["imagefile"], saveHandler, errorHandler);
    }
    
    function validateHandler(errors) {
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
            for (var key in additionalData) {
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
        if ( link != null) {
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
            OpenCmsXmlContentFormApi.initFormForSession(sessionId, ugc.getForm()[0], newSessionHandler, errorHandler);      
            $("#saveButton").click(save);
            $("#validateButton").click(validate);
            $("#cancelButton").click(cancel)
        }
    }
        
    $(window).unload(function() {
        ugc.destroySession();
    });
});