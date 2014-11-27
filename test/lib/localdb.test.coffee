'use strict'

# PSUEDO CODE
# =============================================
#
# - it should do CRUD operation
# - it should save to .json
# - it should update .json
# - it should delete .json
# - it should find and findOne .json

# *Modules*
fs          = require 'fs'
path        = require 'path'
Backbone    = require 'backbone'

LocalDB     = require '../../lib/localDB'
_id         = ''


describe 'lib', ->

  describe 'localDB class', ->

    before ->
      dir = path.resolve(__dirname, '../_tmp')
      @localDB = new LocalDB('RGB', dir)

    after ->
      @localDB = null

    it 'should be a class', ->
      expect(@localDB).to.be.instanceof(LocalDB)


    it 'should have public methods', ->
      expect(@localDB).to.have.property('create')
      expect(@localDB).to.have.property('update')
      expect(@localDB).to.have.property('delete')
      expect(@localDB).to.have.property('find')
      expect(@localDB).to.have.property('findOne')
      expect(@localDB).to.have.property('drop')

    it 'should create', (done) ->
      @localDB.create {}, (error, results) ->
        _id = results._id
        expect(results).to.be.an('object')
        expect(results).to.have.property('_id')
        expect(results).to.have.property('_created_at')
        expect(results).to.have.property('_updated_at')
        done()

    it 'should update', (done) ->
      setTimeout =>
        @localDB.update {_id: _id}, {}, (error, results) ->
          done()
      , 100

    it 'should find', (done) ->
      @localDB.find {_id:_id}, (error, results) ->
        expect(results).to.be.instanceof(Array)
        expect(results[0]).to.be.an('object')
        expect(results[0]).to.have.property('_id')
        expect(results[0]).to.have.property('_created_at')
        expect(results[0]).to.have.property('_updated_at')
        done()

    it 'should findOne', (done) ->
      @localDB.findOne {_id:_id}, (error, results) ->
        expect(results).to.be.an('object')
        expect(results).to.have.property('_id')
        expect(results).to.have.property('_created_at')
        expect(results).to.have.property('_updated_at')
        done()

    it 'should delete', (done) ->
      @localDB.delete {_id:_id}, (error, results) ->
        expect(results).to.be.an('object')
        expect(results).to.have.property('_id')
        expect(results).to.have.property('_created_at')
        expect(results).to.have.property('_updated_at')
        done()