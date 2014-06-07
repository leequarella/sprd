@derby_app.controller "practicesController", ($scope, $http) ->
  $scope.practices = []
  $scope.currentPractice = {}
  $scope.init = ->
    $scope.pullPractices()

  $scope.pullPractices = ->
    $http.get("/practices.json").success (data) =>
      $scope.practices = data

  $scope.setCurrentPractice = (practice) ->
    $scope.currentPractice = practice

  $scope.newPractice = ->
    $scope.currentPractice = {}

  $scope.saveCurrentPractice = ->
    data = practice: {
      date: $scope.currentPractice.date}
    if $scope.currentPractice.id
      $http.put("/practices/#{$scope.currentPractice.id}.json", data).success => $scope.pullPractices()
    else
      $http.post("/practices.json", data).success => $scope.pullPractices()

  $scope.init()

  $scope.today = ->
    $scope.dt = new Date()

  $scope.today()

  $scope.clear = ->
    $scope.dt = null

  $scope.toggleMin = ->
    $scope.minDate = $scope.minDate ? null : new Date()

  $scope.toggleMin()

  $scope.open = ($event)->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.opened = true

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1}

  $scope.initDate = new Date('2016-15-20')
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate']
  $scope.format = $scope.formats[0]
