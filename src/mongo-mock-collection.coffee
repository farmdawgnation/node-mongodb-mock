class MongoMockCollection
  constructor: (@documents) ->

  find: (query, callback) ->
    callback()

  findOne: (query, callback) ->
    callback()

  insert: (query, callback) ->
    callback()

  update: (query, updates, options, callback) ->
    callback()

  remove: (query, callback) ->
    callback()

module.exports = MongoMockCollection
