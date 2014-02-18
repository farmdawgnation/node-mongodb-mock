class MongoMockQuery
  constructor: (@query) ->

  match: (doc) ->
    false

module.exports = MongoMockQuery
