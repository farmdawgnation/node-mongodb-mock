MongoMockQuery = require './mongo-mock-query'
_ = require 'lodash'

class MongoMockCollection
  constructor: (@documents = []) ->
    unless _.isArray @documents
      throw "Documents in a MongoMockCollection should be an array."

    for document in @documents
      unless document._id?
        throw "Mock documents require an _id"

  find: (query, callback) ->
    mockQuery = new MongoMockQuery query

    matchingDocumentsFilter = (matchingDocuments, documentToTest) ->
      if mockQuery.match(documentToTest)
        matchingDocuments.concat [documentToTest]
      else
        matchingDocuments

    results = _.reduce(@documents, matchingDocumentsFilter, [])

    callback null, results

  findOne: (query, callback) ->
    @find query, (err, results) ->
      callback(err, results[0])

  insert: (document, callback) ->
    callback()

  update: (query, updates, options, callback) ->
    callback()

  remove: (query, callback) ->
    callback()

module.exports = MongoMockCollection
