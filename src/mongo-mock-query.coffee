_ = require 'underscore'

class MongoMockQuery
  constructor: (@query) ->

  valueMatchesComplexQuery: (value, complexQuery) ->
    if complexQuery['$gt']?
      value > complexQuery['$gt']
    else if complexQuery['$gte']?
      value >= complexQuery['$gte']
    else if complexQuery['$in']?
      complexQuery['$in'].indexOf(value) > -1
    else if complexQuery['$lt']?
      value < complexQuery['$lt']
    else if complexQuery['$lte']?
      value <= complexQuery['$lte']
    else if complexQuery['$ne']?
      value != complexQuery['$ne']
    else if complexQuery['$nin']?
      complexQuery['$nin'].indexOf(value) == -1
    else if complexQuery['$exists']?
      if complexQuery['$exists']
        typeof value != "undefined"
      else
        typeof value == "undefined"
    else if complexQuery['$type']?
      typeof value == complexQuery['$type']
    else
      "Unknown complex query."

  match: (doc) ->
    partMatches = for targetField, queryPart of @query
      if typeof queryPart == 'object'
        @valueMatchesComplexQuery(doc[targetField], queryPart)
      else
        doc[targetField] == queryPart

    reduceFunc = (memo, individual) -> memo && individual
    _.reduce partMatches, reduceFunc, true

module.exports = MongoMockQuery
