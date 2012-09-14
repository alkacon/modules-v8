// $Id$

/**
 * @see http://wiki.apache.org/solr/SolJSON#JSON_specific_parameters
 * @class Manager
 * @augments AjaxSolr.AbstractManager
 */
AjaxSolr.Manager = AjaxSolr.AbstractManager.extend(
  /** @lends AjaxSolr.Manager.prototype */
  {
  executeRequest: function (servlet, string, handler) {
    var self = this;
    var loc = "";
    if (initLocale && initLocale != null) {
        loc = "con_locales:" + initLocale;
        this.store.addByValue('fq', loc);
        initLocale = null;
    }
    string = string || this.store.string();
    handler = handler || function (data) {
      self.handleResponse(data);
      jQuery('#result').fadeIn('fast');
    };
    if (this.proxyUrl) {
      jQuery.post(this.proxyUrl, { query: string }, handler, 'json');
    }
    else {
      jQuery.getJSON(this.solrUrl + servlet + '?' + string + '&wt=json&json.wrf=?', {}, handler);
    }
  }
});
