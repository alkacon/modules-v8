(function ($) {

AjaxSolr.dateDatestampToLabel = function (solrDatestamp) {
  console.log(solrDatestamp);
  var startdate = $.datepicker.parseDate('yy-mm-dd', solrDatestamp.split('T')[0]);
  // going in 10-year chunks so add 9 to starting year to get end year
  var enddate = new Date(startdate.getFullYear() + 9, 11, 31, 23, 59, 59, 0);
  return startdate.getFullYear() + " to " + enddate.getFullYear();
}

AjaxSolr.dateFqToLabel = function (fqValue) {
  var fqValue = fqValue.replace(/[\[\]\s]/g, "");
  var start = fqValue.split('TO')[0];
  return AjaxSolr.dateDatestampToLabel(start);
}

AjaxSolr.dateLabelToFq = function (displayValue) {
  var years = displayValue.toLowerCase().split(' to ');
  var format = 'yy-mm-dd';
  var start = new Date(years[0], 1, 1, 0, 0, 0, 0);
  var start_str = $.datepicker.formatDate(format, start) + 'T00:00:00Z';
  var end = new Date(years[1], 11, 31, 23, 59, 59, 0);
  var end_str = $.datepicker.formatDate(format, end) + 'T00:00:00Z';
  return '[' + start_str + ' TO ' + end_str + ']';
}

AjaxSolr.DateGroupWidget1 = AjaxSolr.AbstractFacetWidget.extend({
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
      
      var label = AjaxSolr.dateDatestampToLabel(facet);
      objectedItems.push({ label: label, count: count });
    }

    objectedItems.sort(function (a, b) {
      return parseInt(a.label.substr(0,4)) > parseInt(b.label.substr(0,4)) ? -1 : 1;
    });

    $(this.target).empty();

    for (var i = 0, l = objectedItems.length; i < l; i++) {
      var label = objectedItems[i].label;
      $(this.target).append(AjaxSolr.theme('facet_link2', label, objectedItems[i].count, this.clickHandler(label)));
    }
  },

  fq: function (label, exclude) {
    var fq_value = AjaxSolr.dateLabelToFq(label);
    return (exclude ? '-' : '') + this.field + ':' + fq_value;
  }
});

})(jQuery);