@derby_app.controller "skatersController", ($scope, $http) ->
  $scope.skaters = []
  $scope.currentSkater = {}
  $scope.init = ->
    $scope.pullSkaters()

  $scope.pullSkaters = ->
    $http.get("/skaters.json").success (data) =>
      $scope.skaters = data

  $scope.setCurrentSkater = (skater) ->
    $scope.currentSkater = skater

  $scope.newSkater = ->
    $scope.currentSkater = {}

  $scope.saveCurrentSkater = ->
    data = skater: {
      first_name: $scope.currentSkater.first_name
      last_name:  $scope.currentSkater.last_name
      derby_name: $scope.currentSkater.derby_name}
    if $scope.currentSkater.id
      $http.put("/skaters/#{$scope.currentSkater.id}.json", data).success => $scope.pullSkaters()
    else
      $http.post("/skaters.json", data).success => $scope.pullSkaters()

  $scope.init()
