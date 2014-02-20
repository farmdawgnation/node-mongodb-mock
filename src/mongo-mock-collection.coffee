MongoMockQuery = require './mongo-mock-query'
_ = require 'lodash'

class MongoMockCollection
  constructor: (@documents = []) ->
    unless _.isArray @documents
      throw "Documents in a MongoMockCollection should be an array."

    for document in @documents
      unless document._id?
        throw "Mock documents require an _id"

  find: (query, fields, options, callback) ->
    if _.isFunction fields
      callback = fields
      fields = null

    if _.isFunction options
      callback = options
      options = null

    mockQuery = new MongoMockQuery query

    matchingDocumentsFilter = (matchingDocuments, documentToTest) ->
      if mockQuery.match(documentToTest)
        matchingDocuments.concat [documentToTest]
      else
        matchingDocuments

    results = _.reduce(@documents, matchingDocumentsFilter, [])

    if _.isFunction callback
      callback null, results

    results

  findOne: (query, fields, options, callback) ->
    if _.isFunction fields
      callback = fields
      fields = null

    if _.isFunction options
      callback = options
      options = null

    @find query, (err, results) ->
      callback(err, results[0])

  insert: (document, options, callback) ->
    if _.isFunction options
      callback = options
      options = null

  update: (query, updates, options, callback) ->
    callback()

  save: (document, options, callback) ->
    if _.isFunction options
      callback = options
      options = null

    if document._id?
      @update {_id: document._id}, document, options, callback
    else
      @insert document, options, callback

  remove: (query, callback) ->
    callback()

module.exports = MongoMockCollection
