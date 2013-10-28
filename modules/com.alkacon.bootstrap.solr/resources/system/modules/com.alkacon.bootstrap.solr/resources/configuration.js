<%@page buffer="none" session="false" taglibs="c,cms,fmt"%>
<c:set var="locale"><cms:info property="opencms.request.locale" /></c:set>
<fmt:setLocale value="${locale}" />
<fmt:bundle basename="com/alkacon/bootstrap/solr/messages">
    var GWTsolrUIConfiguration = {
        "general" : {
            "solrUrl" : '<cms:link>/handleSolrSelect</cms:link>',
            "spellUrl" : '<cms:link>/handleSolrSpell</cms:link>',
            "titleQuery" : '?wt=json&q=*:*&rows=0&fl=Title_prop&fq=con_locales:*&facet=true&facet.field=Title_exact&facet.limit=1000&fq=parent-folders:"/sites/default/demo/"',
            "rows" : 5,
            "defaultQuery" : "?wt=json&fq=con_locales:*&q=",
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
                         "language",
                         "con_locales",
                         "Title_exact",
                         "Title_prop",
                         "category"],
             "hl" : true,
             "hl.fl" : [ "content_en", "content_de", "Title_prop" ],
             "hl.fragsize" : 200,
             "hl.useFastVectorHighlighter" : true,
             "jsonp" : false,
             "facet" : true,
             "facet.mincount" : 1,
             "facet.limit" : 15,
             "auto.complete.delay" : 300
        },
        "currentSelection" : {
            "id" : "solrWidgetCurrentSelection",
            "label" : '<fmt:message key="label.your.selection" />',
        },
        "autocomplete" : {
            "id" : "solrWidgetAutoComplete",
            "label" : '<fmt:message key="label.search" />',
            "fields" : [ "content_en", "content_de", "Title_exact" ]
        },
        "autocompleteHeader" : {
            "id" : "solrWidgetAutoCompleteHeader",
            "label" : '<fmt:message key="label.search" />',
            "fields" : [ "content_en", "content_de", "Title_exact" ]
        },
        "dateRanges" : {
            "id" : "solrWidgetDateRange",
            "label" : '<fmt:message key="label.last.changes" />',
            "fields" : [ "lastmodified" ]
        },
        "textFacets" : {
            "id" : 'solrWidgetTextFacet',
            "facets" : [
                         { "field" : "type",           "label" : 'Type',     "alphasort"  : "facetCountDESC", "showAll" : true,  "defaultCount" : 5 },
                         { "field" : "category_exact", "label" : 'Category', "alphasort"  : "facetLabelASC",  "showAll" : true, "defaultCount" : 5 },
                         { "field" : "con_locales",    "label" : 'Language', "alphasort"  : "facetLabelASC",  "showAll" : false, "defaultCount" : 5 }
                       ]
        },
        "resetFacets" : {
            "id" : 'solrWidgetResetFacets'
        },
        "sortBar" : {
            "id" : "solrWidgetSortBar",
            "label" : '<fmt:message key="label.sort.by" />',
            "fields" : [ "score", "lastmodified", "created", "Title_exact" ],
            "labels" : [ '<fmt:message key="label.sort.relevance" />', '<fmt:message key="label.sort.modified" />', '<fmt:message key="label.sort.created" />', '<fmt:message key="label.sort.title" />' ]            
        },
        "resultCount" : {
            "id" : "solrWidgetResultCount",
            "label" : '<fmt:message key="label.show.results" />'
        },
        "resultList" : {
            "id" : "solrWidgetResultList"
        },
        "resultTable" : {
            "id" : "solrWidgetResultTable",
            "fields" : [ "Title_prop",  "con_locales", "lastmodified", "state", "type", "size" ]
        },
        "resultPagination" : {
            "id" : "solrWidgetResultPagination"
        },
        "advisorButton" : {
            "id" : "solrWidgetAdvisorButton",
            "label" :  '<fmt:message key="label.advice" />'
        },
        "shareResult" : {
            "id" : "solrWidgetShareResult",
            "label" : '<fmt:message key="label.share" />'
        }
    };
</fmt:bundle>
