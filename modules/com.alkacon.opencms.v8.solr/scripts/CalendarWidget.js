(function ($) {

AjaxSolr.CalendarWidget = AjaxSolr.AbstractFacetWidget.extend({
  afterRequest: function () {
    var self = this;
    $(this.target).datepicker('destroy').datepicker({
      dateFormat: 'yy-mm-dd',
      defaultDate: new Date(),
      maxDate: $.datepicker.parseDate('yy-mm-dd', this.manager.store.get('facet.date.end').val().substr(0, 10)),
      minDate: $.datepicker.parseDate('yy-mm-dd', this.manager.store.get('facet.date.start').val().substr(0, 10)),
      nextText: '&gt;',
      prevText: '&lt;',
      region: opencmsLocale,
      beforeShowDay: function (date) {
        var value = $.datepicker.formatDate('yy-mm-dd', date) + 'T00:00:00Z';
        var count = self.manager.response.facet_counts.facet_dates[self.field][value];
        return [ parseInt(count) > 0, '', count + ' ' + GUI_DOCUMENTS_FOUND_0 ];
      },
      onSelect: function (dateText, inst) {
        if (self.add('[' + dateText + 'T00:00:00Z TO ' + dateText + 'T23:59:59Z]')) {
          self.manager.doRequest(0);
        }
      }
    });
  }
});

})(jQuery);
