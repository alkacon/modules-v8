<%@page import="org.opencms.file.*, org.opencms.main.*, org.opencms.util.*, org.opencms.widgets.*"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="locale" value="${cms:vfs(pageContext).context.locale}" />

<div class="googlemap-wrapper ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "" }">
<cms:formatter var="map" val="value" rdfa="rdfa">
	<c:choose>
	<c:when test="${cms.element.inMemoryOnly}">
		<c:if test="${cms.element.settings.hidetitle ne 'true'}"><h1>${value.Headline}</h1></c:if>
		<p>Please edit the Google Map Element.</p>
	</c:when>
	<c:when test="${cms.edited}">
		<c:if test="${cms.element.settings.hidetitle ne 'true'}"><h1>${value.Headline}</h1></c:if>
		<p>The Google Map Element has been edited, the page will reload...</p>
		${cms.enableReload}
	</c:when>
	<c:otherwise>
	<%-- calculate map size: width and height --%>
	<c:set var="mapw">600</c:set>
	<c:set var="maph">400</c:set>
	<c:set var="mapsize">${map.value.MapSize}</c:set>
	<c:set var="sizesep">${fn:indexOf(mapsize, "x")}</c:set>
	<c:if test="${sizesep != -1}">
		<c:set var="mapw">${fn:trim(fn:substringBefore(mapsize, "x"))}</c:set>
		<c:set var="maph">${fn:trim(fn:substringAfter(mapsize, "x"))}</c:set>
	</c:if>
	<c:if test="${not fn:contains(mapw, '%')}">
		<c:set var="mapw">${mapw}px</c:set>
	</c:if>
	<c:if test="${not fn:contains(maph, '%')}">
		<c:set var="maph">${maph}px</c:set>
	</c:if>
	<c:if test="${mapw != '100%'}">
		<c:set var="mapw">width: ${mapw};</c:set>
	</c:if>
	<c:if test="${mapw == '100%'}">
		<c:set var="mapw"></c:set>
	</c:if>
	<c:set var="maph">height: ${maph};</c:set>
	<c:set var="elemid" value="${cms.element.id}"/><%
	          CmsUUID id = (CmsUUID)pageContext.getAttribute("elemid");
	          int hc = id.hashCode();
	          String suffix = "" + hc;
	          if (hc < 0) {
			  	suffix = "" + (-hc + (System.currentTimeMillis() % 1000));
			  }
	          pageContext.setAttribute("varsuffix", suffix);
	%>

	<%-- include Google Maps JS --%>
	<c:if test="${empty googlemapscript}">
	    <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false&amp;language=${locale}"></script>
		<c:set var="googlemapscript" scope="request" value="loaded"/>
	</c:if>
	<script type="text/javascript">
		// map object
		var map${varsuffix};
		// geocoder used to get address data of coordinates
		var geocoder${varsuffix} = new google.maps.Geocoder();
		// set default map center
		var mapCenterLatLng${varsuffix} = new google.maps.LatLng(50.941690,6.958183);
		// global arrays of the markers, marker coords and info windows
		var marker${varsuffix} = [];
		var mapMarkerLatLng${varsuffix} = [];
		var infoWindow${varsuffix} = [];
		// stores the query error count
		var queryErrors${varsuffix} = 0;
		
		<%-- get first manually entered coordinate, it is used as map center --%>
		<c:forEach var="mapcoord" items="${map.valueList.MapCoord}" end="0">
			<c:set var="loccent">${mapcoord.value.Coord}</c:set>
			<%
				CmsLocationPickerWidgetValue val = new CmsLocationPickerWidgetValue((String)pageContext.getAttribute("loccent"));
				pageContext.setAttribute("loccent", val);
			%>
			mapCenterLatLng${varsuffix} = new google.maps.LatLng(${loccent.lat}, ${loccent.lng});
		</c:forEach>

		function showGoogleMap${varsuffix}() {
			
			// set the map options
			var mapOptions = {
				zoom: ${map.value.MapZoom},
				center: mapCenterLatLng${varsuffix},
				mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DEFAULT, mapTypeIds: new Array(google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.HYBRID)},
				mapTypeId: google.maps.MapTypeId.${map.value.MapType}
			};
			// create the map
			map${varsuffix} = new google.maps.Map(document.getElementById("googlemap${cms.element.id}"), mapOptions);

			var contentString, newMarker;
			<jsp:useBean id="usedMarkers" class="java.util.LinkedHashMap" />
			<c:forEach var="mapcoord" items="${map.valueList.MapCoord}" varStatus="status">
				<c:set var="loc">${mapcoord.value.Coord}</c:set>
				<%
					CmsLocationPickerWidgetValue val = new CmsLocationPickerWidgetValue((String)pageContext.getAttribute("loc"));
					pageContext.setAttribute("loc", val);
				%>
					// set coordinates
					mapMarkerLatLng${varsuffix}[${status.index}] = new google.maps.LatLng(${loc.lat}, ${loc.lng});
					<c:set var="title" value="" />
					<c:if test="${not mapcoord.value.Caption.isEmptyOrWhitespaceOnly}">
						<c:set var="title">,title: "${mapcoord.value.Caption}"</c:set>
					</c:if>
					// create new marker with coordinates
					newMarker = new google.maps.Marker({
						position: mapMarkerLatLng${varsuffix}[${status.index}],
						<c:if test="${value.ShowMarkers.exists && value.ShowMarkers != 'true'}">visible: false,</c:if>
						map: map${varsuffix}
						${title}
					});

					<c:if test="${mapcoord.value.MarkerGroup.isSet}">
						newMarker.category = "${mapcoord.value.MarkerGroup}";
						<c:set target="${usedMarkers}" property="${mapcoord.value.MarkerGroup.stringValue}" value="1"/>
					</c:if>
					marker${varsuffix}[${status.index}] = newMarker;

					// create content for info window
					contentString = "";
					<c:if test="${not mapcoord.value.Caption.isEmptyOrWhitespaceOnly}">
						contentString += "<b>${mapcoord.value.Caption}</b><br/>";
					</c:if>
					
					<c:choose>
						<c:when test="${mapcoord.value.Address.exists}">
							<c:set var="gAdr">${mapcoord.value.Address}</c:set>
							<%
								String gAdr = (String)pageContext.getAttribute("gAdr");
								pageContext.setAttribute("gAdr", CmsStringUtil.escapeJavaScript(CmsStringUtil.escapeHtml(gAdr)));
							%>
							contentString += "${gAdr}";
							<c:set var="callgeocode">false</c:set>
						</c:when>
						<c:otherwise>
							contentString += "ebkAddr";
							<c:set var="callgeocode">true</c:set>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${map.value.Route == 'true'}">
						// add calculate route form input
						contentString += "<br/><br/>Show route to this location:<br/>Please enter your start address."
							+ "<form action=\"https://maps.google.com/maps\" method=\"get\" target=\"_blank\">"
							+ "<input type=\"text\" size=\"15\" maxlength=\"60\" name=\"saddr\" value=\"\" />"
							+ "&nbsp;&nbsp;<input value=\"Show Route\" type=\"submit\"><input type=\"hidden\" name=\"daddr\" value=\""
							+ "${loc.lat},${loc.lng}\"/>";
					</c:if>

					infoWindow${varsuffix}[${status.index}] = new google.maps.InfoWindow({
						content: contentString
					});

					google.maps.event.addListener(marker${varsuffix}[${status.index}], 'click', function() {
						mapOpenInfo(${status.index}, map${varsuffix}, marker${varsuffix}, infoWindow${varsuffix});
					});

					<c:if test="${callgeocode == true}">
					geoCodeCoords${varsuffix}(${status.index});
					</c:if>
			</c:forEach>


		}
		
		// tries to geocode the given map coordinate
		function geoCodeCoords${varsuffix}(mIndex) {
			geocoder${varsuffix}.geocode({'latLng': mapMarkerLatLng${varsuffix}[mIndex] }, function(results, status) {
				setMapInfoWindowContent${varsuffix}(results, status, mIndex);
			});
		}
		
		// sets the content of the specified info window
		function setMapInfoWindowContent${varsuffix}(results, status, winIndex) {
			var infoContent = infoWindow${varsuffix}[winIndex].getContent();
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					infoContent = infoContent.replace(/ebkAddr/, getMapInfoAddress(results[0]));
				}
			} else {
				if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT && queryErrors${varsuffix} <= 20) {
					setTimeout("geoCodeCoords${varsuffix}(" + winIndex + ");", 500 + (queryErrors${varsuffix} * 50));
					queryErrors${varsuffix}++;
				} else {
					infoContent = infoContent.replace(/ebkAddr/, "");
				}
			}
			infoWindow${varsuffix}[winIndex].setContent(infoContent);
		}
		
		function showMarkers${varsuffix}(category) {
			for (var i = 0; i < marker${varsuffix}.length; i++) {
				if (marker${varsuffix}[i].category == category || category == '') {
					marker${varsuffix}[i].setVisible(true);
				} else {
					marker${varsuffix}[i].setVisible(false);
				}
			}
		}
        
        // returns the address from a geocode result in nicely formatted way
        function getMapInfoAddress(result) {
        	var street = "", strNum = "", zip = "", city = "", foundAdr = false;
        	for (var i = 0; i < result.address_components.length; i++) {
        		var t = String(result.address_components[i].types);
        		if (street == "" && t.indexOf("route") != -1) {
        			street = result.address_components[i].long_name;
        			foundAdr = true;
        		}
        		if (t.indexOf("street_number") != -1) {
        			strNum = result.address_components[i].long_name;
        			foundAdr = true;
        		}
        		if (t.indexOf("postal_code") != -1) {
        			zip = result.address_components[i].long_name;
        			foundAdr = true;
        		}
        		if (city == "" && t.indexOf("locality") != -1) {
        			city = result.address_components[i].long_name;
        			foundAdr = true;
        		}
        	}
        	if (foundAdr == true) {
        		return street + " " + strNum + "<br/>" + zip + " " + city;
        	} else {
        		return result.formatted_address;
        	}
        }
        
        // open the info window for the clicked marker and close other open info windows
        function mapOpenInfo(mIndex, map, marker, infoWindow) {
        	for (var i = 0; i < marker.length; i++) {
        		if (i != mIndex) {
        			infoWindow[i].close();
        		}
        	}
        	infoWindow[mIndex].open(map, marker[mIndex]);
        }
	</script>

	<c:if test="${cms.element.settings.hidetitle ne 'true'}"><div class="headline"><h1 ${rdfa.Headline}>${value.Headline}</h1></div></c:if>
	<c:if test="${value.Text.isSet}"><div class="googlemaptext" ${rdfa.Text}>${value.Text}</div></c:if>

	<div id="googlemap${cms.element.id}" class="map ${cms.element.setting.wrapperclass.isSet ? "" : "mb-20" }" style="${mapw}${maph}"></div>
	<c:if test="${not empty usedMarkers || (value.ShowMarkers.exists && value.ShowMarkers != 'true')}">
		<div class="googlemapmarkerbuttons">
			<c:choose>
				<c:when test="${not empty usedMarkers}">
					<button class="btn btn-default" onclick="showMarkers${varsuffix}('');">Show all markers</button>
					<c:forEach var="markergroup" items="${usedMarkers}">
						<button class="btn btn-default" onclick="showMarkers${varsuffix}('<c:out value="${markergroup.key}" />');">Show ${markergroup.key}</button>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<button class="btn btn-default" onclick="showMarkers${varsuffix}('');">Show markers</button>
				</c:otherwise>
			</c:choose>
			<button class="btn btn-default" onclick="showMarkers${varsuffix}('ebkhide');">Hide markers</button>
		</div>
	</c:if>

	</c:otherwise>
	</c:choose>
</cms:formatter>
<script type="text/javascript">
	// show map after loading
	showGoogleMap${varsuffix}();	                               
</script>
</div>