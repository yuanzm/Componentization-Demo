module.exports = (grunt)->

  coffeeify = require 'coffeeify'
  stringify = require 'stringify'

  grunt.initConfig
    connect:
      server:
        options:
            port: 3000
            base: '.'

    clean: 
        bin: ['bin']
        dist: ['dist']

    browserify: 
      common:
        options:
            preBundleCB: (b)->
                b.transform(coffeeify)
                b.transform(stringify({extensions: ['.hbs', '.html', '.tpl', '.txt']}))
        expand: true
        flatten: true
        src: ['src/common/common.coffee', 'src/main.coffee']
        dest: 'bin/js/'
        ext: '.js'

      components: 
        options:
            preBundleCB: (b)->
                b.transform(coffeeify)
                b.transform(stringify({extensions: ['.hbs', '.html', '.tpl', '.txt']}))
        expand: true
        flatten: true
        src: ['src/components/**/*.coffee']
        dest: 'bin/js/components/'
        ext: '.js'

    watch:
      compile:
        options:
            livereload: true
        files: ['src/**/*.coffee', 'src/**/*.less', 'src/**/*.html', 'index.html']
        tasks: ['browserify', 'less']

    less:    
      dev:
        files:
            'bin/style.css': ['src/**/*.less']

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ->
    grunt.task.run [
        'connect'
        'clean:bin'
        'browserify'
        'less'
        'watch'
    ]