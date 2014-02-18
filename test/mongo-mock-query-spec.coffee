MongoMockQuery = require '../src/mongo-mock-query'
chai = require 'chai'

should = chai.should()

describe "MongoMockQuery", ->
  it 'should match a document using a direct value search', ->
    doc1 = {bacon: "zz", wakka: 123}
    doc2 = {bacon: "foek", wakka: 999}
    doc3 = {bacon: "eokf"}

    query = new MongoMockQuery {wakka: 123}

    query.match(doc1).should.equal true
    query.match(doc2).should.equal false
    query.match(doc3).should.equal false

  it 'should match a document using the $gt operator', ->
    doc1 = {someThing: 20}
    doc2 = {someThing: 1}
    doc3 = {someThing: 5}

    query = new MongoMockQuery {someThing: {"$gt": 5}}

    query.match(doc1).should.equal true
    query.match(doc2).should.equal false
    query.match(doc3).should.equal false

  it 'should match a document using the $gte operator', ->
    doc1 = {someThing: 20}
    doc2 = {someThing: 1}
    doc3 = {someThing: 5}

    query = new MongoMockQuery {someThing: {"$gte": 5}}

    query.match(doc1).should.equal true
    query.match(doc2).should.equal false
    query.match(doc3).should.equal true

  it 'should match a document using the $in operator', ->
    doc1 = {bacon: "sauce"}
    doc2 = {bacon: 2}
    doc3 = {bacon: 99}

    query = new MongoMockQuery {bacon: {"$in": ["sauce", 2]}}

    query.match(doc1).should.equal true
    query.match(doc2).should.equal true
    query.match(doc3).should.equal false

  it 'should match a document using the $lt oeprator', ->
    doc1 = {someThing: 20}
    doc2 = {someThing: 1}
    doc3 = {someThing: 5}

    query = new MongoMockQuery {someThing: {"$lt": 5}}

    query.match(doc1).should.equal false
    query.match(doc2).should.equal true
    query.match(doc3).should.equal false

  it 'should match a document using the $lte operator', ->
    doc1 = {someThing: 20}
    doc2 = {someThing: 1}
    doc3 = {someThing: 5}

    query = new MongoMockQuery {someThing: {"$lte": 5}}

    query.match(doc1).should.equal false
    query.match(doc2).should.equal true
    query.match(doc3).should.equal true

  it 'should match a document using the $ne operator', ->
    doc1 = {someThing: 20}
    doc2 = {someThing: 1}
    doc3 = {someThing: 5}

    query = new MongoMockQuery {someThing: {"$ne": 5}}

    query.match(doc1).should.equal true
    query.match(doc2).should.equal true
    query.match(doc3).should.equal false

  it 'should match a document using the $nin operator', ->
    doc1 = {bacon: "sauce"}
    doc2 = {bacon: 2}
    doc3 = {bacon: 99}

    query = new MongoMockQuery {bacon: {"$nin": ["sauce", 2]}}

    query.match(doc1).should.equal false
    query.match(doc2).should.equal false
    query.match(doc3).should.equal true

  it 'should match a document using the $exists operator', ->
    doc1 = {bacon: "zz", wakka: 123}
    doc2 = {bacon: "foek", wakka: 999}
    doc3 = {bacon: "eokf"}

    query1 = new MongoMockQuery {wakka: {"$exists": true}}
    query2 = new MongoMockQuery {wakka: {"$exists": false}}

    query1.match(doc1).should.equal true
    query1.match(doc2).should.equal true
    query1.match(doc3).should.equal false

    query2.match(doc1).should.equal false
    query2.match(doc2).should.equal false
    query2.match(doc3).should.equal true

  it 'should match a document using the $type operator', ->
    doc1 = {bacon: true}
    doc2 = {bacon: 2}

    query = new MongoMockQuery {bacon: {"$type": "number"}}

    query.match(doc1).should.equal false
    query.match(doc2).should.equal true

  it 'should correctly coalesce query terms', ->
    doc1 = {bacon: "zz", wakka: 123}
    doc2 = {bacon: "foek", wakka: 999}
    doc3 = {bacon: "eokf"}

    query = new MongoMockQuery {wakka: {"$exists": true}, wakka: {"$gt": 200}}

    query.match(doc1).should.equal false
    query.match(doc2).should.equal true
    query.match(doc3).should.equal false
