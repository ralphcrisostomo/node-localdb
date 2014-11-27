'use strict'

# *Modules*
Q         = require 'q'
fs        = require 'fs'
path      = require 'path'

class FileSystem

  constructor: (name, dir) ->
     # Create new instance of FileSystem Class.
    if not (@ instanceof FileSystem)

      # This will return object {}
      return new FileSystem(name, dir)

    # Set
    @dir  = dir
    @name = name?.toLowerCase()

    # TODO - Update!
    @file = "#{@dir}/#{@name}.json"


  read: ->
    deferred = Q.defer()
    fs.readFile @file, 'utf-8', (err, results) ->

      if err
        deferred.reject err
      else
        deferred.resolve  if results.length is 0 then false else JSON.parse(results)
    deferred.promise


  write: (data) ->
    deferred = Q.defer()
    fs.writeFile @file, data, (err) ->
      if err
        deferred.reject err
      else
        deferred.resolve()
    deferred.promise


  exist: ->
    deferred = Q.defer()
    fs.exists @file, (exist) ->
      deferred.resolve exist
    deferred.promise

  drop: ->
    @write('[]')

  #
  # To write default json
  #
  writeDefaultJSON: (deferred) ->
    @write('[]')
    .then(_.bind(@read, @))
    .then (results) ->
      deferred.resolve results

  #
  # To get JSON if file exist
  # To create JSON if file not exist
  #
  getJSON: ->
    deferred = Q.defer()
    @exist().then (exist) =>
      if exist
        @read()
        .then (results) =>
          if results
            deferred.resolve results
          else
            @writeDefaultJSON(deferred)
      else
        @writeDefaultJSON(deferred)
    deferred.promise

module.exports = FileSystem

