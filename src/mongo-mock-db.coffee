MongoMockCollection = require './mongo-mock-collection'
_ = require 'lodash'

class MongoMockDb
  constructor: (initialData) ->
    @collections = {}

    try
      for collectionName, collectionData of initialData
        throw "Was not passed an array for collection data" unless collectionData.indexOf?
        @collections[collectionName] = new MongoMockCollection collectionData
    catch e
      throw "Invalid mock data passed into MongoMockDb."

  createCollection: (name, options, callback) ->

  collectionNames: (callback) ->

  collections: (callback) ->

  collection: (collectionName, options, callback) ->
    @collections[collectionName] = new MongoMockCollection() unless @collections[collectionName]?
    @collections[collectionName]

  dropCollection: (collectionName, callback) ->

module.exports = MongoMockDb
