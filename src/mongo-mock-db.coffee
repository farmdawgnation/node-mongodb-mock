MongoMockCollection = require './mongo-mock-collection'

class MongoMockDb
  constructor: (initialData) ->
    @collections = {}

    try
      for collectionName, collectionData of initialData
        throw "Was not passed an array for collection data" unless collectionData.indexOf?
        @collections[collectionName] = new MongoMockCollection collectionData
    catch e
      throw "Invalid mock data passed into MongoMockDb."

  collection: (collectionName) ->
    @collections[collectionName] = new MongoMockCollection() unless @collections[collectionName]?
    @collections[collectionName]

module.exports = MongoMockDb
