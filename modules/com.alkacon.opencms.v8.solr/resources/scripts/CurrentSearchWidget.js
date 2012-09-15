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
      
AjaxSolr.CurrentSearchWidget = AjaxSolr.AbstractWidget.extend({
  afterRequest: function () {
    var self = this;
    var links = [];

    var fq = this.manager.store.values('fq');
    for (var i = 0, l = fq.length; i < l; i++) {
      var field = fq[i].split(':');
      console.log(field);
      if (field[0] == 'lastmodified') {
        var displayValue = 'lastmodified:' + AjaxSolr.formatSolrDate(field[1].split('TO ')[0].split('T')[0].slice(1));
      } else {
        var displayValue = fq[i];
      }
      links.push($('<a href="#"/>').text('(x) ' + displayValue).click(self.removeFacet(fq[i])));
    }

    if (links.length > 1) {
      links.unshift($('<a href="#"/>').text(GUI_REMOVE_ALL_FACETS_0).click(function () {
        self.manager.store.remove('fq');
        self.manager.doRequest(0);
        return false;
      }));
    }

    if (links.length) {
      AjaxSolr.theme('list_items', this.target, links);
    }
    else {
      $(this.target).html('<div>' + GUI_VIEWING_ALL_DOCS_0 + '</div>');
    }
  },

  removeFacet: function (facet) {
    var self = this;
    return function () {
      if (self.manager.store.removeByValue('fq', facet)) {
        self.manager.doRequest(0);
      }
      return false;
    };
  }
});

})(jQuery);
