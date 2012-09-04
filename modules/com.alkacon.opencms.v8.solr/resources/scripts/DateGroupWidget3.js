(function ($) {

AjaxSolr.DateGroupWidget3 = AjaxSolr.AbstractFacetWidget.extend({


  addFacet: function (label, query) {

    $(this.target).append(AjaxSolr.theme('facet_link2', label, -1, this.clickHandler(query)));
  },

  init: function () {

    this.initStore();

    var lastweek = '[NOW-7DAY/DAY TO NOW]';
    var lastmonth = '[NOW-1MONTH/DAY TO NOW]';
    var lastyear = '[NOW-1YEAR/DAY TO NOW]';
    var beforelastyear = '[* TO NOW-1YEAR/DAY]';

    this.addFacet("Last week", lastweek);
    this.addFacet("Last month", lastmonth);
    this.addFacet("Last year", lastyear);
    this.addFacet("Before last year", beforelastyear);
  }

});

})(jQuery);