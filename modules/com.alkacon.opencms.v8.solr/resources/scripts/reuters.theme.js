(function ($) {

AjaxSolr.formatSolrDate = function (solrDatestamp) {
    var startdate = $.datepicker.parseDate('yy-mm-dd', solrDatestamp.split('T')[0]);
    var date = dateFormat(startdate, GUI_DATE_FORMAT_0);
    return date;
}
AjaxSolr.theme.prototype.result = function (doc, snippet) {
  var title = doc.Title_en;
  if (opencmsLocale == 'de') {
    var title = doc.Title_de;
  }
  if (!title || title == 'undefined' || title == null) {
    title = doc.Title_prop;
  }
  var output = '<div>';
  output += '<h5><a class="titlelink" href="' + doc.link + '">' + title + '</a></h5>';
  output += '<p><small><strong>'+AjaxSolr.formatSolrDate(doc.lastmodified)+'</strong></small></p>'
  output += '<p>' + snippet + '</p>';
  output += '<span><strong>' + GUI_TAGS_LABEL_0 + '&nbsp;</strong></span>';
  output += '<span id="links_' + doc.id + '"></span>';
  output += '</div>';
  return output;
};

AjaxSolr.theme.prototype.snippet = function (doc) {
  var content = doc.content_en;
  if (opencmsLocale == 'de') {
    var content = doc.content_de;
  }
  if (!content || content == 'undefined' || content == null) {
	  content = doc.content;
  }
  var output = '';
  if (content && content.toString().length > 300) {
    output = content.toString();
    var rest = output.substring(300, output.length);
    output = output.substring(0, 300);
    output += '<span style="display:none;">' + rest;
    output += '</span> <a href="#" class="more">' + GUI_MORE_0 + '</a>';
  }
  else {
    output += content;
  }
  if (!output || output == 'undefined' || output == null) {
	  output = GUI_NO_CONTENT_AVAILABLE_0;
  }
  return output;
};

AjaxSolr.theme.prototype.tag = function (value, weight, handler) {
  return $('<a href="#" class="tagcloud_item"/>').text(value).addClass('tagcloud_size_' + weight).click(handler);
};

AjaxSolr.theme.prototype.facet_link2 = function (value, count, handler) {
  var res = $('<div></div>');
  var link = $('<a href="#" class="tagcloud_item"/>').text(value).click(handler);
  if (count == -1) {
    link = $('<a href="#" class="tagcloud_item"/>').text(value).click(handler);
  } else {
    link = $('<a href="#" class="tagcloud_item"/>').text(value).append(" (" + count + ")").click(handler);
  }
  res.append(link);
  res.append('<br/>');
  return res;
};

AjaxSolr.theme.prototype.facet_link = function (value, handler) {
  return $('<a href="#" class="facet_link"/>').text(value).click(handler);
};

AjaxSolr.theme.prototype.no_items_found = function () {
  return GUI_NO_ITEMS_FOUND_0;
};

})(jQuery);