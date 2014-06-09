@derby_app.controller "skatersController", ["$scope", "$http", ($scope, $http) ->
  $scope.predicate         = 'derby_name'
  $scope.init = ->
    $scope.skaters           = []
    $scope.skatersDisplayed  = []
    $scope.currentSkater     = new Skater
    $scope.pullSkaters().then =>
      $scope.showAll()

  $scope.pullSkaters = ->
    $http.get("/skaters.json").then (skaters_data) =>
      for skater_data in skaters_data.data
        skater = new Skater(skater_data)
        Skaters.save skater
      $scope.skaters = Skaters.all

  $scope.showAll = ->
    $scope.skatersDisplayed = $scope.skaters

  $scope.setCurrentSkater = (skater) ->
    $scope.currentSkater = skater

  $scope.newSkater = ->
    $scope.currentSkater = new Skater

  $scope.saveCurrentSkater = ->
    data = skater: {
      first_name: $scope.currentSkater.first_name.current
      last_name:  $scope.currentSkater.last_name.current
      email:      $scope.currentSkater.email.current
      derby_name: $scope.currentSkater.derby_name.current}
    if $scope.currentSkater.persisted()
      $http.put("/skaters/#{$scope.currentSkater.id.current}.json", data).success (skater) =>
        $scope.pullSkaters()
    else
      $http.post("/skaters.json", data).success (skater) =>
        $scope.currentSkater.id = skater.id
        $scope.pullSkaters()

  $scope.deleteCurrentSkater= ->
    if confirm "Are you sure you want to delete this skater? This can't be undone."
      if confirm "Are you absolutely sure this isn't an accident? It's kind of a big deal for you to be sure you want to delete #{$scope.currentSkater.derby_name.current}... this will kill all records of her attendence."
        $http.delete("/skaters/#{$scope.currentSkater.id.current}.json").then =>
          Skaters.remove($scope.currentSkater.id.current)
          $scope.pullSkaters().then => $scope.showAll()


  $scope.search = (property, value)->
    if value
      skaters = Skaters.fuzzy_find_by_property(property, value)
      $scope.skatersDisplayed = skaters
    else
      $scope.showAll()

  $scope.init()
]
