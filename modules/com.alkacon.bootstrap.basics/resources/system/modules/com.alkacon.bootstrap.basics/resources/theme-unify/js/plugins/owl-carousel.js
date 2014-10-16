var OwlCarousel = function () {

    return {
        
        //Owl Carousel
        initOwlCarousel: function () {
		    jQuery(document).ready(function() {
		        //Owl Slider v1
		        var owl = jQuery(".owl-slider");
		            owl.owlCarousel({
		                itemsDesktop : [1000,4], //5 items between 1000px and 901px
		                itemsDesktopSmall : [900,4], //4 items betweem 900px and 601px
		                itemsTablet: [600,3], //3 items between 600 and 0;
		                itemsMobile : [479,2] //2 itemsMobile disabled - inherit from itemsTablet option
		            });

		            // Custom Navigation Events
		            jQuery(".next-v1").click(function(){
		                owl.trigger('owl.next');
		            })
		            jQuery(".prev-v1").click(function(){
		                owl.trigger('owl.prev');
		            })
		        });

		        //Owl Slider v2
		        jQuery(document).ready(function() {
		        var owl = jQuery(".owl-slider-v2");
		            owl.owlCarousel({
		            	items: [4],
		                itemsDesktop : [1000,5], //5 items between 1000px and 901px
		                itemsDesktopSmall : [900,4], //4 items betweem 900px and 601px
		                itemsTablet: [600,3], //3 items between 600 and 0;
		                itemsMobile : [479,2], //2 itemsMobile disabled - inherit from itemsTablet option
		                slideSpeed: 1000
		            });

		            // Custom Navigation Events
		            jQuery(".next-v2").click(function(){
		                owl.trigger('owl.next');
		            })
		            jQuery(".prev-v2").click(function(){
		                owl.trigger('owl.prev');
		            })
		        });

		        //Owl Slider v3
		        jQuery(document).ready(function() {
		        var owl = jQuery(".owl-slider-v3");
		            owl.owlCarousel({
		            	items : 9,
		            	autoPlay : 5000,
						itemsDesktop : [1000,5], //5 items between 1000px and 901px
						itemsDesktopSmall : [900,4], // betweem 900px and 601px
						itemsTablet: [600,3], //2 items between 600 and 0
						itemsMobile : [300,2] //2 itemsMobile disabled - inherit from itemsTablet option
		            });
		        });

		        //Owl Slider v4
		        jQuery(document).ready(function() {
		        var owl = jQuery(".owl-slider-v4");
		            owl.owlCarousel({
		                items:3,
		                itemsDesktop : [1000,3], //3 items between 1000px and 901px
		                itemsTablet: [600,2], //2 items between 600 and 0;
		                itemsMobile : [479,1] //1 itemsMobile disabled - inherit from itemsTablet option
		            });
		    });
		}
    };
    
}();