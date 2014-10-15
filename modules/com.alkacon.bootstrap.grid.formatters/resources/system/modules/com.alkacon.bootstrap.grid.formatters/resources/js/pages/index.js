var Index = function () {

    return {
        
        //Parallax Slider
        initParallaxSlider: function () {
			$(function() {
				$('#da-slider').cslider();
			});
        },

        //Layer Slider
        initLayerSlider: function () {
		    $(document).ready(function(){
		        jQuery("#layerslider").layerSlider({
			        skin: 'fullwidth',
			        responsive : true,
			        responsiveUnder : 960,
			        layersContainer : 960,
			        skinsPath: 'assets/plugins/layer-slider/layerslider/skins/'
			    });
		    });     
        },

        //Revolution Slider
        initRevolutionSlider: function () {
		    var revapi;
	        jQuery(document).ready(function() {
	            revapi = jQuery('.tp-banner').revolution(
	            {
	                delay:9000,
	                startwidth:1170,
	                startheight:500,
	                hideThumbs:10
	            });
	        });
        }

    };
}();