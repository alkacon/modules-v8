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
    if (initLocale && initLocale != null) {
        if (window.location.hash) {
            string = window.location.hash.slice(1, window.location.hash.length);
            this.store.parseString(string);
            initLocale = null;
        } else {
            var loc = "con_locales:" + initLocale;
            this.store.addByValue('fq', loc);
            string = this.store.string();
            initLocale = null;
        }
    }
    string = string || this.store.string();
    window.location.hash = this.store.string();
    
    var self = this;
    handler = handler || function (data) {
      self.handleResponse(data);
      jQuery('#docs').fadeIn('fast');
    };
    if (this.proxyUrl) {
      jQuery.post(this.proxyUrl, { query: string }, handler, 'json');
    }
    else {
      jQuery.getJSON(this.solrUrl + servlet + '?' + string + '&wt=json&json.wrf=?', {}, handler);
    }
  }
});
