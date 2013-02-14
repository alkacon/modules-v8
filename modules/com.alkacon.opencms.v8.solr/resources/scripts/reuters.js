var Manager;

(function ($) {

  $(function () {
    Manager = new AjaxSolr.Manager({
      solrUrl: opencmsServlet
    });
    Manager.addWidget(new AjaxSolr.ResultWidget({
      id: 'result',
      target: '#docs'
    }));
    Manager.addWidget(new AjaxSolr.PagerWidget({
      id: 'pager',
      target: '#pager',
      prevLabel: '&lt;',
      nextLabel: '&gt;',
      innerWindow: 1,
      renderHeader: function (perPage, offset, total) {
        $('#pager-header').html($('<span/>').text(Math.min(total, offset + 1) + ' - ' + Math.min(total, offset + perPage) + ' (' + total + ')'));
      }
    }));
    Manager.addWidget(new AjaxSolr.CurrentSearchWidget({
      id: 'currentsearch',
      target: '#selection'
    }));
    Manager.addWidget(new AjaxSolr.AutocompleteWidget({
      id: 'text',
      target: '#search',
      field: 'content_' + opencmsLocale,
      fields: [ 'Title_prop', 'category_exact', 'type' ]
    }));
    var fields = [ 'type' ];
    for (var i = 0, l = fields.length; i < l; i++) {
      Manager.addWidget(new AjaxSolr.MultiTagcloudWidget({
        id: fields[i],
        target: '#' + fields[i],
        field: fields[i],
        operator: 'OR',
        count: 30
      }));
    }
    var fields = [ 'category_exact' ];
    for (var i = 0, l = fields.length; i < l; i++) {
      Manager.addWidget(new AjaxSolr.SingleFacet({
        id: fields[i],
        target: '#' + fields[i],
        field: fields[i],
        count: 30,
        sort: 'name'
      }));
    }
    var fields = [ 'con_locales' ];
    for (var i = 0, l = fields.length; i < l; i++) {
      Manager.addWidget(new AjaxSolr.TagcloudWidget({
        id: fields[i],
        target: '#' + fields[i],
        field: fields[i],
      }));
    }
    Manager.addWidget(new AjaxSolr.CalendarWidget({
      id: 'calendar',
      target: '#calendar',
      field: 'lastmodified'
    }));
    Manager.init();
    Manager.store.addByValue('q', '*:*');
    var params = {
      facet: true,
	  'rows': 5,
      'facet.field': [ 'Title_prop', 'category_exact', 'con_locales', 'lastmodified' ],
      'facet.mincount': 1,
      'facet.limit': 15,
      'facet.sort': 'count',
      'facet.date': 'lastmodified',
      'facet.date.start': '2012-05-01T00:00:00.000Z/DAY',
      'facet.date.end': '2020-01-01T00:00:00.000Z/DAY+1DAY',
      'facet.date.gap': '+1DAY',
      'json.nl': 'map'
    };
    for (var name in params) {
      Manager.store.addByValue(name, params[name]);
    }
    Manager.doRequest();
  });

  $.fn.showIf = function (condition) {
    if (condition) {
      return this.show();
    }
    else {
      return this.hide();
    }
  }

})(jQuery);