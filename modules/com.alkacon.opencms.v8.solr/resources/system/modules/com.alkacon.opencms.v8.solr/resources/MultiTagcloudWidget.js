(function ($) {

AjaxSolr.MultiTagcloudWidget = AjaxSolr.AbstractFacetWidget.extend({

field: null,
multivalue: false,
  
init: function () {
    this.manager.store.add('facet.field', new AjaxSolr.Parameter( { 
        name: 'facet.field', 
        value: this.field, 
        locals: { ex: this.field } 
    })); 
    this.initStore();
},

set: function (value) {
    return this.changeSelection(function () {
        var indices = this.manager.store.find('fq', new RegExp('^-?' + this.field + ':')); 
        if (indices) {
            this.manager.store.params['fq'][indices[0]] = new AjaxSolr.Parameter({ name: 'fq', value: this.manager.store.params['fq'] [indices[0]].val() + ' OR ' + this.fq(value), locals: { tag: this.field } });
            return true; 
        } else {
            return this.manager.store.add('fq', new AjaxSolr.Parameter({ name: 'fq', value: this.fq(value), locals: { tag: this.field } }));
        }
    }); 
},

add: function (value) {
    return this.changeSelection(function () { 
        return this.manager.store.add('fq', new AjaxSolr.Parameter({ name: 'fq', value: this.fq(value), locals: { tag: this.field } })); 
    }); 
}, 

afterRequest: function () {
    if (this.manager.response.facet_counts.facet_fields[this.field] === undefined) {
      $(this.target).html(AjaxSolr.theme('no_items_found'));
      return;
    }

    var maxCount = 0;
    var objectedItems = [];
    for (var facet in this.manager.response.facet_counts.facet_fields[this.field]) {
      var count = parseInt(this.manager.response.facet_counts.facet_fields[this.field][facet]);
      if (count > maxCount) {
        maxCount = count;
      }
      objectedItems.push({ facet: facet, count: count });
    }
    objectedItems.sort(function (a, b) {
      return a.facet < b.facet ? -1 : 1;
    });

    $(this.target).empty();
    for (var i = 0, l = objectedItems.length; i < l; i++) {
      var facet = objectedItems[i].facet;
//      $(this.target).append(AjaxSolr.theme('tag', facet, parseInt(objectedItems[i].count / maxCount * 10), this.clickHandler(facet)));
      $(this.target).append(AjaxSolr.theme('facet_link2', facet, objectedItems[i].count, this.clickHandler(facet)));
      
    }
  }
});

})(jQuery);