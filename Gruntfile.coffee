'use strict'

module.exports = (grunt) ->

  # Load all grunt task automatically
  require('load-grunt-tasks') grunt,
    pattern: [
      'grunt-*'
    ]

  # Time how long tasks take.
  # Can help when optimizing build times
  require('time-grunt')(grunt)

  # Grunt Task Configuration
  # ===============
  grunt.initConfig

  # Coffeelint all coffeescripts.
    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'
      gruntfile:
        src: ['Gruntfile.coffee']
      src:
        src: ['lib/**/*.coffee']
      test:
        src: ['test/**/*.coffee']


  # BDD Testing with mocha!
    mochaTest:
      options:
        ui: 'bdd'
        reporter: 'nyan'
        ignoreLeaks: false
        require: [
          'test/_require/global.coffee'
        ]
      src:
        src: [
          'test/**/*.test.coffee'
          ]


  # `grunt test` will run test.
  grunt.registerTask 'test', [
    'coffeelint'
    'mochaTest:src'
  ]

  # `grunt` will run default task with nodeunit test.
  grunt.registerTask 'default', [
    'test'
  ]