


/*
 * Example complex widget for rendering the nested content defined in /system/modules/org.opencms.dev.demo/schemas/nested/script.xsd .
 * 
 */

function render_examplewidget_form(elem, entity, vie, config) {

   // for available methods on the arguments entity and vie, see the classes in com.alkacon.acacia.client.export package, which get exported to Javascript using
   // gwt-exporter.

   var widget = $("<div><div class='explanation' /><table class='examplewidget'><tr><td>Script</td><td>NoScript</td></tr><tr><td class='x'><td class='y'></tr></table></div>");
   var module ="org.opencms.dev.demo";

   // append widget to form widget container 
   widget.appendTo(elem); 
   
   var schemas = "opencms://system/modules/" + module + "/schemas/nested/";
   var attr_x = schemas + "script.xsd/OpenCmsDevDemoScript/Script";
   var attr_y = schemas + "script.xsd/OpenCmsDevDemoScript/NoScript";
   
   widget.find(".explanation").text("This is a custom widget which renders a complete nested content.");
   
   var locations = [];
   locations[attr_x] = ".x";
   locations[attr_y] = ".y"; 
   var fields = {}; 


   for (var attrName in locations) { 
      var field = $("<textarea rows='20' cols='50'>");
      widget.find(locations[attrName]).append(field); 
      fields[attrName] = field; 
   } 

   function save()  {
      // first, remove existing attributes from the entity
      var type = vie.getType(entity.getTypeName());
      var attrNames = type.getAttributeNames();
      for ( var i = 0; i < attrNames.length; i++) {
         var name = attrNames[i];
         if (entity.getAttribute(name)) {
            entity.removeAttribute(name);
            }
         }

      // store values from input fields in entity 
      for (var attrName in fields) { 
         entity.addAttributeValueString(attrName, fields[attrName].val()); 
      } 
    }
     
     
   // show values from entity in input fields 
   for (var attrName in fields) { 
      if (entity.hasAttribute(attrName)) { 
         fields[attrName].val(entity.getAttribute(attrName).getSimpleValue()); 
      } 
   }
   
   $("textarea", widget).keypress(function(e){
      save();
   });
}


// name of the initialization function is "init_" + widget name 
function init_examplewidget() {
   
   return {
      renderForm: render_examplewidget_form,
      renderInline: function() { /*do nothing*/ } 
   };
}



