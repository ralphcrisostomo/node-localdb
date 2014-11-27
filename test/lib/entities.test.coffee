'use strict'

# *Modules*
Backbone    = require 'backbone'
path        = require 'path'

# *Class*
Entities    = require '../../lib/entities'


describe 'lib', ->

  describe 'manifest class', ->

    before ->
      dir = path.resolve(__dirname, '../_tmp')
      @entities = new Entities('ABC', dir)

    after ->
      @entities = null

    it 'should be a class', ->
      expect(@entities).to.be.instanceof(Entities)

    it 'should have public methods', ->
      expect(@entities).to.have.property('getCollection')


    it 'should have get backbone collection', (done) ->
      @entities.getCollection().then (collection) ->
        expect(collection).to.be.instanceof(Backbone.Collection)
        done()

    it 'should create a model', (done) ->
      @entities.getCollection().then (collection) ->
        collection.set([{},{}])
        expect(collection.length).to.equals(2)
        expect(collection.at(0).attributes).to.have.property('_id')
        expect(collection.at(0).attributes).to.have.property('_created_at')
        expect(collection.at(0).attributes).to.have.property('_updated_at')
        collection.add({foo:'bar'})
        collection.add({bar:'foo'})
        done()

