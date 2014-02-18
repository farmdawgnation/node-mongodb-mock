chai = require 'chai'

chai.should()

describe "MongoMockCollection", ->
  it 'should instantiate when a correclty formatted array of documents'

  it 'should throw an error if an incorrectly formatted array is passed in'

  describe "#find", ->
    it 'should find a single doc when a single doc matches'

    it 'should find no docs when no docs match'

    it 'should find multiple docs when multiple match'

  describe "#findOne", ->
    it 'should find a single doc when a single doc matches'

    it 'should find a single doc when multiple docs match'

    it 'should find no docs when no docs match'

  describe "#insert", ->
    it 'should insert a new, properly formatted document'

    it 'should error for an inproperly formatted document'

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
