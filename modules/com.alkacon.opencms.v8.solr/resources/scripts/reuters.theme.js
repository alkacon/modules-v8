(function ($) {

AjaxSolr.theme.prototype.result = function (doc, snippet) {
  var output = '<div><h2>' + doc.Title_prop + '</h2>';
  output += '<p id="links_' + doc.path + '" class="links">'+doc.path+'</p>';
  output += '<p>' + snippet + '</p></div>';
  return output;
};

AjaxSolr.theme.prototype.snippet = function (doc) {
  var output = '';
  if (doc.content_en && doc.content_en.toString().length > 300) {
    output = doc.content_en.toString();
    var rest = output.substring(300, output.length);
    output = output.substring(0, 300);
    output += '<span style="display:none;">' + rest;
    output += '</span> <a href="#" class="more">more</a>';
  }
  else {
    output += doc.content_en;
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
  return 'no items found in current selection';
};

})(jQuery);