class @Model
  constructor: (data) ->
    data = {} if !data
    for property in @properties
      @[property] = {current: data[property], backup: null}
    @init(data) if @init

  get: (property) -> @[property].current

  set: (property, value) -> @[property].current = value

  restore: ->
    for i in  @properties
      this[i].current = this[i].backup

  backup: ->
    for i in @properties
      console.log i
      this[i].backup = this[i].current

  unsavedFields: ->
    fields = []
    for property in @properties
      fields.push(property) if @[property].current != @[property].backup
    return fields

  isUnsaved: ->
    if @unsavedFields().length > 0
      true
    else
      false
