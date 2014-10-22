<%@page buffer="none" session="false" taglibs="c,cms,fmt" import="org.opencms.jsp.CmsJspActionElement,org.opencms.file.CmsRequestContext,org.opencms.main.OpenCms"%>
<% org.opencms.util.CmsRequestUtil.setNoCacheHeaders(response); %>
<c:set var="locale"><cms:info property="opencms.request.locale" /></c:set>
<fmt:setLocale value="${locale}" />
<cms:bundle basename="com.alkacon.bootstrap.formatters.messages">
    var GWTsearchUIConfiguration = {
        "general" : {
            "searchUrl" : '<cms:link>/handleSolrSelect</cms:link>',
            "spellUrl" : '<cms:link>/handleSolrSpell</cms:link>',
            "titleQuery" : '?wt=json&q=*:*&rows=0&fl=Title_prop&fq=con_locales:*&facet=true&facet.field=Title_exact&facet.limit=1000&fq=parent-folders:"/sites/default/"',
            "rows" : 5,
            "defaultQuery" : "?wt=json&fq=con_locales:*&q=",
            "defaultSort" : 'lastmodified+desc',
            "qt" : "edismax",
            "fl" : [     "id",
                         "path",
                         "link",
                         "type",
                         "size",
                         "state",
                         "suffix",
                         "lastmodified",
                         "parent-folders",
                         "con_locales",
                         "Title_exact",
                         "Title_prop",
                         "category"],
             "hl" : true,
             "hl.fl" : [ "spell", "content_en", "content_de", "Title_prop" ],
             "hl.fragsize" : 200,
             "hl.useFastVectorHighlighter" : true,
             "jsonp" : false,
             "facet" : true,
             "facet.mincount" : 1,
             "facet.limit" : 15,
             "auto.complete.delay" : 300
        },
        "autocomplete" : {
            "id" : "searchWidgetAutoComplete",
            "label" : '<fmt:message key="label.search" />',
            "fields" : [ "spell", "content_en", "content_de", "Title_exact" ]
        },
        "autocompleteHeader" : {
            "id" : "searchWidgetAutoCompleteHeader",
            "label" : '<fmt:message key="label.search" />',
            "fields" : [ "spell", "content_en", "content_de", "Title_exact" ]
        },
        "textFacets" : {
            "id" : 'searchWidgetTextFacet',
            "facets" : [
                         { "field" : "type",           "label" : 'Type',     "alphasort"  : "facetCountDESC", "showAll" : true,  "defaultCount" : 5 },
                         { "field" : "category_exact", "label" : 'Category', "alphasort"  : "facetLabelASC",  "showAll" : true, "defaultCount" : 5 },
                         { "field" : "con_locales",    "label" : 'Language', "alphasort"  : "facetLabelASC",  "showAll" : false, "defaultCount" : 5 }
                       ]
        },
        "resetFacets" : {
            "id" : 'searchWidgetResetFacets',
            "label" :  '<fmt:message key="label.reset" />'
        },
        "sortBar" : {
            "id" : "searchWidgetSortBar",
            "label" : '<fmt:message key="label.sort.by" />',
            "fields" : [ "score", "lastmodified", "created", "Title_exact" ],
            "labels" : [ '<fmt:message key="label.sort.relevance" />', '<fmt:message key="label.sort.modified" />', '<fmt:message key="label.sort.created" />', '<fmt:message key="label.sort.title" />' ]            
        },
        "resultCount" : {
            "id" : "searchWidgetResultCount",
            "label" : '<fmt:message key="label.show.results" />'
        },
        "resultList" : {
            "id" : "searchWidgetResultList"
        },
        "resultTable" : {
            "id" : "searchWidgetResultTable",
            "fields" : [ "Title_prop",  "con_locales", "lastmodified", "state", "type", "size" ]
        },
        "resultPagination" : {
            "id" : "searchWidgetResultPagination"
        },
        "advisorButton" : {
            "id" : "searchWidgetAdvisorButton",
            "label" :  '<fmt:message key="label.advice" />'
        },
        "shareResult" : {
            "id" : "searchWidgetShareResult",
            "label" : '<fmt:message key="label.share" />'
        }
    };
</cms:bundle>
