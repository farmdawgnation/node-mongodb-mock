MongoMockQuery = require './mongo-mock-query'
MongoMockUpdate = require './mongo-mock-update'
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

    unless document._id?
      document._id = Math.random().toString(36).substring(7)

    @documents.push(document)

    if _.isFunction callback
      callback null, document

  update: (query, updates, options, callback) ->
    if _.isFunction options
      callback = options
      options = null

    matchingDocuments = @find query
    updateToMake = new MongoMockUpdate updates

    unless options?.multi
      matchingDocuments = [_.first(matchingDocuments)]

    updatedDocuments = for document in matchingDocuments
      updateToMake.update document

    if _.isFunction callback
      callback null, updatedDocuments.length

    updatedDocuments.length

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
