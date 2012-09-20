(function ($) {

AjaxSolr.MultiTagcloudWidget = AjaxSolr.AbstractFacetWidget.extend({

    field: null,
    multivalue: false,
    operator: 'OR',
    sort: 'count',
    count: 0,

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
            this.manager.store.params['fq'][indices[0]] = new AjaxSolr.Parameter({ name: 'fq', value: this.manager.store.params['fq'] [indices[0]].val() + " " + this.operator + " " + this.fq(value), locals: { tag: this.field } });
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

    $(this.target).empty();
    var added = 0;
    for (var i = 0, l = objectedItems.length; i < l; i++) {
      var facet = objectedItems[i].facet;
      var fq = this.manager.store.values('fq');
      var show = true;
      for (var j = 0; j < fq.length; j++) {
        var field = fq[j].split(':');
        for (var k = 1; k < field.length; k++) {
            var fac = facet + " ";
            if (field[k] == facet || field[k].slice(0, fac.length) == fac) {
                show = false;
            }
        }
      }
      if (show && this.count > added) {
          $(this.target).append(AjaxSolr.theme('facet_link2', facet, objectedItems[i].count, this.clickHandler(facet)));
          added++;
      }
    }
  }
});

})(jQuery);