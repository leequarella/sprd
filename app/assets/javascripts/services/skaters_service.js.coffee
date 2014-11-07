@derby_app.factory 'skaters', ["$http", ($http) ->
  skatersFactory = {}
  skatersFactory.data = ''

  skatersFactory.all = ->
    @data = $http.get('/skaters.json').then (data) => return data

  skatersFactory.active = ->
    @data = $http.get('/skaters.json?status=Active').then (data) => return data

  skatersFactory
]
