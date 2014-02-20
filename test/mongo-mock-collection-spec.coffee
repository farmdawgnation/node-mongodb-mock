MongoMockCollection = require '../src/mongo-mock-collection'
chai = require 'chai'

should = chai.should()

describe "MongoMockCollection", ->
  exampleCollectionData = [
    {_id: "abc123", owner: "matt", someNumber: 4}
    {_id: "def456", owner: "matt", someNumber: 4}
    {_id: "okokok", owner: "matt", someNumber: 4}
    {_id: "zzzzzz", owner: "matt", someNumber: 4}
    {_id: "xxxxxx", owner: "matt", someNumber: 4}
  ]

  suiteCollection = new MongoMockCollection exampleCollectionData

  it 'should instantiate when a correclty formatted array of documents', ->
    someDocsBro = [
      {_id: "abc123", bigBots: "i like them"}
      {_id: "def456", smallBots: false}
    ]

    newCollection = new MongoMockCollection someDocsBro

    (newCollection).should.have.a.property("find")

  it 'should throw an error if a nonarray is passed in', ->
    notAnArray = {_id: "LOL!"}

    newCollection = -> new MongoMockCollection notAnArray

    (newCollection).should.Throw("Documents in a MongoMockCollection should be an array.")

  it 'should throw an error if an incorrectly formatted array is passed in', ->
    someDocsBro = [
      {_id: "abc123", bigBots: "i like them"}
      {smallBots: false}
    ]

    newCollection = -> new MongoMockCollection someDocsBro

    (newCollection).should.Throw("Mock documents require an _id")

  describe "#find", ->
    it 'should find a single doc when a single doc matches', (done) ->
      suiteCollection.find {_id: "abc123"}, (err, docs) ->
        should.not.exist err
        docs.should.have.length(1)
        docs[0]._id.should.equal "abc123"
        done()

    it 'should find no docs when no docs match', (done) ->
      suiteCollection.find {_id: "aaaaaa"}, (err, docs) ->
        should.not.exist err
        docs.should.have.length(0)
        done()

    it 'should find multiple docs when multiple match', (done) ->
      suiteCollection.find {}, (err, docs) ->
        should.not.exist err
        docs.should.have.length(exampleCollectionData.length)
        done()

  describe "#findOne", ->
    it 'should find a single doc when a single doc matches', (done) ->
      suiteCollection.findOne {_id: "abc123"}, (err, doc) ->
        should.not.exist err
        should.exist doc
        doc._id.should.equal "abc123"
        done()

    it 'should find a single doc when multiple docs match', (done) ->
      suiteCollection.findOne {}, (err, doc) ->
        should.not.exist err
        should.exist doc
        doc._id.should.equal "abc123"
        done()

    it 'should find no docs when no docs match', (done) ->
      suiteCollection.findOne {_id: "aaaaaa"}, (err, doc) ->
        should.not.exist err
        should.not.exist doc
        done()

  describe "#insert", ->
    it 'should insert a new document'

  describe "#update", ->
    it 'should update a single match when only one matches w/ multi off'

    it 'should update a single match when only one matches w/ multi on'

    it 'should update a single match when multiple match w/ multi off'

    it 'should update all matches w/ multiple matches and multi on'

    it 'should update a single doc with no query and mutli off'

    it 'should update all docs with no query and multi on'

    it 'should upsert a doc if there are no matches w/ upsert on'

    it 'should update no docs when none match w/ multi off'

    it 'should update no docs when none match w/ multi on'

  describe "#remove", ->
    it 'should remove all documents matching a query'

    it 'should remove no documents if no documents match'

    it 'should remove all documents with no query provided'
