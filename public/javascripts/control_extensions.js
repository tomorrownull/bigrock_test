/*
 * InPlaceEditor extension that adds a 'click to edit' text when the field is
 * empty.
 */
Ajax.InPlaceEditor.prototype.__initialize = Ajax.InPlaceEditor.prototype.initialize;
Ajax.InPlaceEditor.prototype.__getText = Ajax.InPlaceEditor.prototype.getText;
Ajax.InPlaceEditor.prototype.__onComplete = Ajax.InPlaceEditor.prototype.leaveEditMode;
Ajax.InPlaceEditor.prototype.__handleFormSubmission = Ajax.InPlaceEditor.prototype.handleFormSubmission;
Ajax.InPlaceEditor.prototype = Object.extend(Ajax.InPlaceEditor.prototype, {

    initialize: function(element, url, options){
        this.setOptions(options);
        this.__initialize(element,url,options)
        this._checkEmpty();
    },

    setOptions: function(options){
        if (!options.emptyText)        options.emptyText      = "单击 编辑…";
        if (!options.emptyClassName)   options.emptyClassName = "inplaceeditor-empty";
    },

    _checkEmpty: function(){
        if( this.element.innerHTML.length == 0 ){
            this.element.appendChild(
                Builder.node('span',{
                    className:this.options.emptyClassName
                },this.options.emptyText));
        }
    },

    getText: function(){
        empty_span = this.element.select("." + this.options.emptyClassName).first()
        if (empty_span) {
            empty_span.remove();
        }
        return this.__getText();
    },

    leaveEditMode: function(transport){
        this._checkEmpty();
        this.__onComplete(transport);
    },
    handleFormSubmission: function(e){
        var value = $F(this._controls.editor);
        if (value==this.element.innerHTML) {
            this.leaveEditMode();
            if (e) Event.stop(e);

        }
        else
            this.__handleFormSubmission(e);
    }
});
