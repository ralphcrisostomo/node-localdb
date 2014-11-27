'use strict'

# *Modules*
_         = require 'underscore'
Backbone  = require 'backbone'
Q         = require 'q'
moment    = require 'moment'
uuid      = require 'node-uuid'

# *Class*
FileSystem = require './filesystem'


# *Backbone*
Model = Backbone.Model.extend
  idAttribute: '_id'
  defaults:
    _id:         null
    _updated_at: null
    _created_at: moment().format()
  initialize: ->
    @set('_id', uuid.v4()) if @get('_id') is null

Collection = Backbone.Collection.extend
  model: Model


class Entities extends FileSystem
  #
  # To let all the finish first before we write to JSON
  #
  debounce: _.debounce (collection, event, results) ->
    @write(JSON.stringify(collection.toJSON(), null, 4)).then ->
      collection.trigger "written:#{event}", results


  getCollection: ->
    deferred  = Q.defer()
    @getJSON().then (results) =>
      @collection = new Collection(results)

      # Always write collection to json for all events!
      @collection.listenTo @collection, 'all', (event, results) =>

        # TODO - only limit event on 'add, remove, update, change'
        if _.contains ['change', 'add', 'remove'], event
          @debounce(@collection, event, results)

      deferred.resolve @collection
    deferred.promise

module.exports = Entities

