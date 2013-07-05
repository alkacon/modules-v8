function myWidgetInitializationCall(){
  registerWidgetFactory({
    /**
     * The widget name and identifier.
     */         
    widgetName: "mywidgetname",
    /**
     * Creates a new widget instance according to the configuration.
     */         
    createNativeWidget: function(/*String*/configuration){
      var widget ={
        _value: "",
        _element: null,
        _active: true,
        /**
         * Returns the widget root element.
         */                 
        getElement: function(){
          if (!this._elmenet){
            this._element=document.createElement("div");
          }
          return this._element;
        },
        /**
         * Returns the widget value.
         */                 
        getValue: function(){
          return this._value
        },
        /**
         * Returns if the widget is active.
         */                 
        isActive: function(){
          return this._active;
        },
        /**
         * Will be called once the widget element is attached to the DOM.
         */
        onAttachWidget: function(){
            cmsAddEntityChangeListener({
                onChange: function(entity){
                    // do something
                }
            }, "path to content field to watch eg. '/Title'")
        },
        /**
         * Activates or deactivates the widget.
         */
        setActive: function(/*boolean*/active){
          this._active=active;
        },
        /**
         * Sets the widget value and fires the change event if required.
         */                
        setValue: function(/*String*/value, /*boolean*/fireEvent){
          this._value=value;
          if (this._element.innerTex){
            this._element.innerText=value;
    	  } else {
    		this._element.textContent=value;
    	  }
          if (fireEvent&& typeof this.onChangeCommand ==="function"){
            this.onChangeCommand();
          }
        },
        /**
         * Delegates the value change event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function every time the widget value changes.
         * Changes that are not propagated through this function won't be saved.                           
         */                           
        onChangeCommand: null,
        /**
         * Delegates the focus event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function on widget focus, so the editor 
         * highlighting can be updated.                   
         */
        onFocusCommand: null
      }
      return widget;
    },
    
    
    /**
     * Creates a new inline editing widget instance according to the configuration.
     */         
    createNativeWrapedElement: function(/*String*/configuration, /*Element*/ element){
      var widget ={
        _value: "",
        _element: element,
        _active: true,
        /**
         * Returns the widget root element.
         */                 
        getElement: function(){
          return this._element;
        },
        /**
         * Returns the widget value.
         */                 
        getValue: function(){
          return this._value
        },
        /**
         * Returns if the widget is active.
         */                 
        isActive: function(){
          return this._active;
        },
        /**
         * Will be called once the widget element is attached to the DOM.
         */
        onAttachWidget: function(){},
        /**
         * Activates or deactivates the widget.
         */
        setActive: function(/*boolean*/active){
          this._active=active;
        },
        /**
         * Sets the widget value and fires the change event if required.
         */                
        setValue: function(/*String*/value, /*boolean*/fireEvent){
          this._value=value;
          if (this._element.innerTex){
            this._element.innerText=value;
    	  } else {
    		this._element.textContent=value;
    	  }
          if (fireEvent&& typeof this.onChangeCommand ==="function"){
            this.onChangeCommand();
          }
        },
        /**
         * Delegates the value change event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function everytime the widget value changes.
         * Changes that are propagated through this function won't be saved.                           
         */                           
        onChangeCommand: null,
        /**
         * Delegates the focus event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function on widget focus, so the editor 
         * highlighting can be updated.                   
         */
        onFocusCommand: null
      }
      return widget;
    }
  });
}
