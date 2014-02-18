MongoMockDb = require '../src/mongo-mock-db'
chai = require 'chai'

chai.should()

describe "MongoMockDb", ->
  it 'should instantiate with a properly formatted hash', ->
    correctHash =
      colName1: [
        {_id: 'abc', field: 1}
        {_id: 'def', field: 3}
      ],
      colName2: [
        {_id: 'wat', bacon: true}
        {_id: 'who', mattRocks: true}
      ]

    newDb = new MongoMockDb correctHash

    newDb.should.have.property('collection')

  it 'should throw an error if a properly formatted hash is not passed in', ->
    incorrectHash =
      colName1:
        _id: 'baddddd'
        toTheBone: true

    dbInstantiation = -> new MongoMockDb incorrectHash

    (dbInstantiation).should.Throw("Invalid mock data passed into MongoMockDb.")

  it 'should return a MongoMockCollection for a valid collection name', ->
    someInitialData =
      myAwesomeCollection: []

    newDb = new MongoMockDb someInitialData

    myAwesomeCollection = newDb.collection("myAwesomeCollection")
    myAwesomeCollection.should.be.a("object")

  it 'should create a new MongoMockCollection for a new collection name and return it', ->
    someInitialData =
      myAwesomeCollection: []

    newDb = new MongoMockDb someInitialData

    newCollection = newDb.collection("newCollection")
    newCollection.should.be.a("object")
