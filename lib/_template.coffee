'use strict'

# *Modules*

class Template

  constructor: ->
     # Create new instance of Template Class.
    if not (@ instanceof Template)

      # This will return object {}
      return new Template()

  exec: ->

module.exports = Template

