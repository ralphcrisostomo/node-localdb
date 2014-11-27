'use strict'


# *Class*
Template    = require '../../lib/_template'


describe 'lib', ->

  describe 'manifest class', ->

    before ->
      @template = new Template()

    after ->
      @template = null

    it 'should be a class', ->
      expect(@template).to.be.instanceof(Template)

    it 'should have public methods', ->
      expect(@template).to.have.property('exec')