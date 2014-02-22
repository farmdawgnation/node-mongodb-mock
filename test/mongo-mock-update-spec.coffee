MongoMockUpdate = require '../src/mongo-mock-update'
chai = require 'chai'
_ = require 'lodash'

chai.should()

describe 'MongoMockUpdate', ->
  it 'should update a document using the $inc operator', ->
    exampleDoc = {bacon: 1}
    targetDoc = {bacon: 2}
    updateInstruction = {"$inc": {"bacon": 1}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document using the $rename operator', ->
    exampleDoc = {bacon: "bok"}
    targetDoc = {zztop: "bok"}
    updateInstruction = {"$rename": {"bacon": "zztop"}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document using the $set operator', ->
    exampleDoc = {bacon: "zz", matt: true, josh: 2}
    targetDoc = {bacon: "awesome", matt: true, josh: 2}
    updateInstruction = {"$set": {"bacon": "awesome"}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document using the $unset operator', ->
    exampleDoc = {bacon: "zz", matt: true, josh: 2}
    targetDoc = {matt: true, josh: 2}
    updateInstruction = {"$unset": {"bacon": true}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document using the $addToSet operator', ->
    exampleDoc = {someSet: ["a", "b", "d"]}
    targetDoc = {someSet: ["a", "b", "d", "c"]}
    updateInstruction = {"$addToSet": {"someSet": "c"}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document using the $pop operator', ->
    exampleDoc = {someSet: ["a", "b", "d"]}
    targetDoc = {someSet: ["a", "b"]}
    updateInstruction = {"$pop": {"someSet": 1}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

    exampleDoc = {someSet: ["a", "b", "d"]}
    targetDoc = {someSet: ["b", "d"]}
    updateInstruction = {"$pop": {"someSet": -1}}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(targetDoc, updatedDoc).should.equal true

  it 'should update a document wholesale when modifiers are not used', ->
    exampleDoc = {bacon: "top"}
    updateInstruction = {josh: true, mike: 4}

    update = new MongoMockUpdate updateInstruction

    updatedDoc = update.update exampleDoc

    _.isEqual(updatedDoc, updateInstruction).should.equal true
