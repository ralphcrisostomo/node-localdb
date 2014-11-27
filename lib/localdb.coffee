'use strict'

# *Modules*
Q         = require 'q'
_         = require 'underscore'
moment    = require 'moment'
Entities  = require './entities'


# Local DB Class
# =============================================
#
# Create a local database using json with Backbone data management.
# Simple CRUD (Create, Read, Update and Delete)
# With mongoDB style querying
#
class LocalDB extends Entities

  #
  #     @param {object or array} params
  #     @param {function} callback
  #     @return {object or array} results of create
  #
  create: (params, callback) ->
    _.extend params, {_created_at: moment().format()}
    @getCollection().then (collection) ->
      collection.listenTo collection, 'written:add written:change', (model) ->
        callback(null, model.toJSON()) if callback
      collection.set params, {remove:false}



  # Will take filter and param
  #
  #     @param {object} filters
  #     @param {object} params
  #     @param {function} callback
  #
  update: (filters, params, callback) ->
    _.extend params, {_updated_at: moment().format()}
    @getCollection().then (collection) ->
      collection.listenTo collection, 'written:change', (model) ->
        callback(null, model.toJSON()) if callback
      model = collection.findWhere(filters)
      model.set params


  # To delete a model
  #
  #     @param {object} filters
  #     @param {function} callback
  #
  delete: (filters, callback) ->
    @getCollection().then (collection) ->
      collection.listenTo collection, 'written:remove', (model) ->
        callback(null, model.toJSON()) if callback
      model = collection.findWhere(filters)
      collection.remove model


  #
  #     @param {object} filters
  #     @param {function} callback
  #
  find: (filters, callback) ->
    arr = []
    @getCollection().then (collection) ->
      results = collection.where(filters)
      _.each results, (model) ->
        arr.push model.toJSON()
      callback(null, arr) if callback


  #
  #     @param {object} filter
  #     @param {function} callback
  #
  findOne: (filters, callback) ->
    @getCollection().then (collection) ->
      model = collection.findWhere(filters)
      callback(null, model?.toJSON() or null) if callback


module.exports = LocalDB

