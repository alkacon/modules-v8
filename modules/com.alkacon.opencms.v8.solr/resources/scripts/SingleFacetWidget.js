(function ($) {

AjaxSolr.SingleFacet = AjaxSolr.AbstractFacetWidget.extend({

    count: 0,
    sort: 'count',
    
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
    
    if (this.sort == 'name') {
    objectedItems.sort(function (a, b) {
        return a.facet < b.facet ? -1 : 1;
      });
    }

    $(this.target).empty();
    var added = 0;
    for (var i = 0, l = objectedItems.length; i < l; i++) {
      var facet = objectedItems[i].facet;
      var fq = this.manager.store.values('fq');
      var show = true;
      for (var j = 0; j < fq.length; j++) {
        var field = fq[j].split(':');
        if (field[1] == facet) {
            show = false;
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
