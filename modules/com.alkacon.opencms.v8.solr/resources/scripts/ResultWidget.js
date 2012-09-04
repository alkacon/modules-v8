(function ($) {

AjaxSolr.ResultWidget = AjaxSolr.AbstractWidget.extend({
  beforeRequest: function () {
    $(this.target).html($('<img/>').attr('src', 'system/modules/com.alkacon.opencms.v8.solr/resources/css/images/ajax-loader.gif'));
  },

  facetLinks: function (facet_field, facet_values) {
    var links = [];
    if (facet_values) {
      for (var i = 0, l = facet_values.length; i < l; i++) {
        if (facet_values[i] !== undefined) {
          links.push(AjaxSolr.theme('facet_link', facet_values[i], this.facetHandler(facet_field, facet_values[i])));
        }
        else {
          links.push(AjaxSolr.theme('no_items_found'));
        }
      }
    }
    return links;
  },

  facetHandler: function (facet_field, facet_value) {
    var self = this;
    return function () {
      self.manager.store.remove('fq');
      self.manager.store.addByValue('fq', facet_field + ':' + AjaxSolr.Parameter.escapeValue(facet_value));
      self.manager.doRequest(0);
      return false;
    };
  },

  afterRequest: function () {
    $(this.target).empty();
    for (var i = 0, l = this.manager.response.response.docs.length; i < l; i++) {
      var doc = this.manager.response.response.docs[i];
      $(this.target).append(AjaxSolr.theme('result', doc, AjaxSolr.theme('snippet', doc)));

      var items = [];
      items = items.concat(this.facetLinks('category_exact', doc.category_exact));
//      items = items.concat(this.facetLinks('search-title', doc.search-title));
      items = items.concat(this.facetLinks('res_locales', doc.res_locales));
      items = items.concat(this.facetLinks('lastmodified', doc.lastmodified));
      items = items.concat(this.facetLinks('type', doc.type));
      AjaxSolr.theme('list_items', '#links_' + doc.id, items);
    }
  },

  init: function () {
    $('a.more').livequery(function () {
      $(this).toggle(function () {
        $(this).parent().find('span').show();
        $(this).text('less');
        return false;
      }, function () {
        $(this).parent().find('span').hide();
        $(this).text('more');
        return false;
      });
    });
  }
});

})(jQuery);