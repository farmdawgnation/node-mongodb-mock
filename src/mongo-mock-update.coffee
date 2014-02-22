_ = require 'lodash'

class MongoMockUpdate
  constructor: (@rawUpdate) ->

  dollarSignUpdate: (doc, updateInstruction, updateValue) ->
    switch updateInstruction
      when '$inc'
        for fieldName, incrementAmount of updateValue
          doc[fieldName] += incrementAmount

      when '$rename'
        for fieldName, newName of updateValue
          doc[newName] = doc[fieldName]
          delete doc[fieldName]

      when '$set'
        for fieldName, newValue of updateValue
          doc[fieldName] = newValue

      when '$unset'
        for fieldName, unsetOrNot of updateValue
          if unsetOrNot
            delete doc[fieldName]

      when '$addToSet'
        for setName, valueToAdd of updateValue
          if doc[setName].indexOf(valueToAdd) == -1
            doc[setName].push(valueToAdd)

      when '$pop'
        for fieldName, popValue of updateValue
          if popValue == 1
            doc[fieldName].pop()
          else if popValue == -1
            doc[fieldName].shift()

    doc


  update: (doc) ->
    for targetField, newValue of @rawUpdate
      if targetField[0] == "$"
        @dollarSignUpdate(doc, targetField, newValue)
      else
        doc = @rawUpdate
        return doc

    doc

module.exports = MongoMockUpdate
