'use strict'


# *Modules*
path = require 'path'

# *Class*
FileSystem    = require '../../lib/filesystem'


describe 'lib', ->

  describe 'manifest class', ->

    before ->
      dir = path.resolve(__dirname, '../_tmp')
      @fileSystem = new FileSystem('XYZ', dir)

    after ->
      @fileSystem = null


    it 'should be a class', ->
      expect(@fileSystem).to.be.instanceof(FileSystem)


    it 'should have properties', ->
      expect(@fileSystem).to.have.property('name', 'xyz')
      expect(@fileSystem).to.have.property('dir', '/Users/Mikasa/Projects/personal/localdb/test/_tmp')
      expect(@fileSystem).to.have.property('file', '/Users/Mikasa/Projects/personal/localdb/test/_tmp/xyz.json')


    it 'should have public methods', ->
      expect(@fileSystem).to.have.property('read')
      expect(@fileSystem).to.have.property('write')
      expect(@fileSystem).to.have.property('exist')
      expect(@fileSystem).to.have.property('writeDefaultJSON')
      expect(@fileSystem).to.have.property('getJSON')


    it 'should write a file', (done) ->
      @fileSystem.write('[]').then ->
        done()

    it 'should read a file', (done) ->
      @fileSystem.read().then (results) ->
        expect(results).to.be.instanceof(Array)
        done()


    it 'should check if file exist', (done) ->
      @fileSystem.exist().then (results) ->
        expect(results).to.equals(true)
        done()

    it 'should get json if it exist and create json if not', (done) ->
      @fileSystem.getJSON().then (results) ->
        expect(results).to.be.instanceof(Array)
        done()