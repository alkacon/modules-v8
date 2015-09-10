
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    'compile-handlebars': {
       
       template: {
         template: 'handlebars/*.hb',
         templateData: 'template/*.json',
         partials: ['handlebars/parts/*.hb', 'handlebars/components/*.hb'],
         output: 'output/*.html',
         files: [{
             expand: true,
             flatten: true,
             src: 'handlebars/*.hb',
             dest: 'output/',
             ext: '.html'
         }],
       },
     },

    sass: {
	    dist: {
	      options: {
	    	  sourcemap: 'auto',
	    	  lineNumbers: true, 
	    	  style: 'nested',
	      },
	      files: [{
	    	  expand: true,
	    	  cwd: 'components/scss',
	    	  src: ['style-blue.scss'],
	    	  dest: 'output/resources/css',
	    	  ext: '.css'
	      	},
	      	{
	    	  expand: true,
	    	  cwd: 'components/scss',
	    	  src: ['style-red.scss'],
	    	  dest: 'output/resources/css',
	    	  ext: '.css'
	      	}
	      ]
	    }
	  },

	cssmin: {
	  options: {
		shorthandCompacting: true,
		roundingPrecision: -1
	  },
	  target: {
		files: [
		{
		  'output/resources/css/style-blue.min.css': [
			'output/resources/css/style-blue.css', 
			'!output/resources/css/*.min.css'
		  ]
		},
		{
			  'output/resources/css/style-red.min.css': [
				'output/resources/css/style-red.css', 
				'!output/resources/css/*.min.css'
			  ]
		},
		{
			'output/resources/css/styles-main.min.css': [
				'components/css/fonts.css',
				'components/plugins/bootstrap/css/bootstrap.min.css', 
				'components/css/style.css',
				'components/css/headers/header-default.css',
				'components/css/footers/footer-default.css',
				'components/css/footers/footer-v1.css',
				'components/plugins/animate.css',
	    		'components/plugins/line-icons/line-icons.css',
	    		'components/plugins/font-awesome/css/font-awesome.min.css',
	    		'components/plugins/fancybox/source/jquery.fancybox.css',
	   			'components/plugins/parallax-slider/css/parallax-slider.css',
	    		'components/plugins/owl-carousel/owl-carousel/owl.carousel.css',
				'!output/resources/css/*.min.css'
			  ]
		}
		
		]
	  }
	},

	uglify: {
		my_target: {
		  files: {
		    'output/resources/js/scripts-all.min.js': [
		
				'components/plugins/jquery/jquery.min.js',
				'components/plugins/jquery/jquery-migrate.min.js',
				'components/plugins/bootstrap/js/bootstrap.min.js',
				'components/plugins/bootstrap-paginator/bootstrap-paginator.min.js',
				'components/plugins/back-to-top.js',
				'components/plugins/smoothScroll.js',
				'components/plugins/fancybox/source/jquery.fancybox.js',
				'components/js/plugins/fancy-box.js',
				'components/plugins/parallax-slider/js/modernizr.js',
				'components/plugins/parallax-slider/js/jquery.cslider.js',
				'components/plugins/owl-carousel/owl-carousel/owl.carousel.js',
				'components/js/app.js'
			]
		  }
		}
	  },
	  
    copy: {
	  main: {
		  files: [{
			  expand: true, 
			  flatten: true, 
			  src: ['output/resources/css/*.min.css'], 
			  dest: '/home/user/opencms-mount/docker-2/demo/system/modules/com.alkacon.unify.basics/resources/css/', 
			  filter: 'isFile'
		},{
			  expand: true, 
			  flatten: true, 
			  src: ['output/resources/js/*.min.js'], 
			  dest: '/home/user/opencms-mount/docker-2/demo/system/modules/com.alkacon.unify.basics/resources/js/', 
			  filter: 'isFile'
		}],
	  },
	},	  

    watch: {
		handlebars: {
			files: '**/*.hb',
	   	   	tasks: ['compile-handlebars']	
		},
		scss: {
			files: '**/*.scss',
			tasks: ['sass', 'cssmin', 'copy']
		},
		uglify: {
			files: 'components/**/*.js',
			tasks: ['uglify', 'copy']
		}
    },


  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-compile-handlebars');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-copy');
  
  // Default task.
  // By default, lint and run all tests.
  grunt.registerTask('default', ['sass', 'cssmin', 'uglify']);

};
