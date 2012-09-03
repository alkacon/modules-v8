(function ($) {

AjaxSolr.getEndDate = function (startdate) {
  return new Date(startdate.getFullYear(), startdate.getMonth()+1, startdate.getDay());
}

AjaxSolr.dateDateToDisplay = function (solrDatestamp) {
  var startdate = $.datepicker.parseDate('yy-mm-dd', solrDatestamp.split('T')[0]);
  var enddate = AjaxSolr.getEndDate(startdate);
  return startdate.getDay() + "." + startdate.getMonth() + "." + startdate.getFullYear() + " bis " + enddate.getDay() + "." + enddate.getMonth() + "." + enddate.getFullYear();
}

AjaxSolr.DateGroupWidget2 = AjaxSolr.AbstractFacetWidget.extend({

  add: function (solrDatestamp) {
    return this.changeSelection(function () {
      var startdate = $.datepicker.parseDate('yy-mm-dd', solrDatestamp.split('T')[0]);
      var enddate = AjaxSolr.getEndDate(startdate);
      var start = startdate.getFullYear() + '-' + startdate.getMonth() + '-' + startdate.getDay();
      var end = enddate.getFullYear() + '-' + enddate.getMonth() + '-' + enddate.getDay();
      query = this.field + ':[' + solrDatestamp + ' TO 2020-12-31T23:59:59Z]';
      if (this.manager.store.add('fq', new AjaxSolr.Parameter( { name: 'fq', value: query } ))) {
        this.manager.doRequest(0);
      }
    }); 
  },

  afterRequest: function () {
    if (this.manager.response.facet_counts.facet_fields[this.field] === undefined) {
      $(this.target).html(AjaxSolr.theme('no_items_found'));
      return;
    }

    var maxCount = 0;
    var objectedItems = [];
    for (var facet in this.manager.response.facet_counts.facet_dates[this.field]) {
      var count = parseInt(this.manager.response.facet_counts.facet_dates[this.field][facet], 10);
      // skip keys like 'gap','end','before'; skip empty ranges
      if (!facet.match(/^\d/) || count == 0)
      {
        continue;
      }
      if (count > maxCount) {
        maxCount = count;
      }
      
      objectedItems.push({ facet: facet, count: count });
    }

    objectedItems.sort(function (a, b) {
      return parseInt(a.facet.substr(0,4)) > parseInt(b.facet.substr(0,4)) ? -1 : 1;
    });

    $(this.target).empty();

    for (var i = 0, l = objectedItems.length; i < l; i++) {
      var facet = objectedItems[i].facet;
      $(this.target).append(AjaxSolr.theme('facet_link2', AjaxSolr.dateDateToDisplay(facet), objectedItems[i].count, this.clickHandler(facet)));
    }
  }
});
})(jQuery);
