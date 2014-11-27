
# Initial Setup
# =============================================
#
# Set all GLOBAL variables here

# *Modules*

Q                           = require 'q'
_                           = require 'underscore'
moment                      = require 'moment'
chai                        = require 'chai'
chaiJSONSchema              = require 'chai-json-schema'
superagent                  = require 'superagent'
sinon                       = require 'sinon'
faker                       = require 'faker'


# Set
chai.use chaiJSONSchema
expect                      = chai.expect
assert                      = chai.assert
agent                       = superagent.agent()

# Set Globals
GLOBAL._                    = _
GLOBAL.Q                    = Q
GLOBAL.sinon                = sinon
GLOBAL.expect               = expect
GLOBAL.assert               = assert
GLOBAL.moment               = moment
GLOBAL.superagent           = superagent
GLOBAL.agent                = agent
GLOBAL.faker                = faker
