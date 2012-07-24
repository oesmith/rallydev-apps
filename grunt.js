module.exports = function (grunt) {

  grunt.loadNpmTasks('grunt-coffee');
  grunt.loadNpmTasks('grunt-less');
  grunt.loadNpmTasks('grunt-handlebars');

  // Project configuration.
  grunt.initConfig({
    coffee: {
      app: {
        src: ['src/**/*.coffee'],
        dest: 'build'
      }
    },
    less: {
      app: {
        src: 'less/app.less',
        dest: 'public/css/app.css',
        options: {
          compress: true
        }
      }
    },
    handlebars: {
      templates: {
        src: 'templates',
        dest: 'build/0-templates.js'
      }
    },
    concat: {
      'public/js/app.js': ['build/**/*.js']
    },
    watch: {
      files: [
        '<config:coffee.app.src>',
        '<config:less.app.src>',
        '<config:handlebars.templates.src>/**/*.handlebars'
      ],
      tasks: 'default'
    }
  });

  // Default task.
  grunt.registerTask('default', 'coffee handlebars concat less');
}
