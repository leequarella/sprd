class @Collection
  all: []

  save: (item) ->
    console.log item
    if @find(item.id.current)
      @update(item)
    else
      @all.push item

  find: (id) ->
    for item in @all
      return item if item.id.current == id
    return null

  find_by_property: (property, value) ->
    items = []
    for item in @all
      if item[property] && item[property].current &&
      item[property].current.toLowerCase()== value.toLowerCase()
        items.push(item)
    items

  fuzzy_find_by_property: (property, value) ->
    regex = new RegExp(value,'i')
    items = []
    for item in @all
      if item[property] && regex.test(item[property].current)
        items.push(item)
    items

  remove: (id) ->
    for item, index in @all
      if item.id.current == id
        @all.splice(index, 1)
        break

  update: (item) ->
    for search, index in @all
      if search.id.current == item.id.current
        @all[index] = item
        break

  removeAll: ->
    @all = []
