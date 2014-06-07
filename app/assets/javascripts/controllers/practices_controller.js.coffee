@derby_app.controller "practicesController", ["skaters", "$scope", "$http", (skaters, $scope, $http) ->
  $scope.practices = []
  $scope.currentPractice = null
  $scope.init = ->
    $scope.pullPractices()
    $scope.skaters = skaters.all().then (skaters) ->
      $scope.skaters = skaters.data

  $scope.pullPractices = ->
    $http.get("/practices.json").success (data) =>
      $scope.practices = data

  $scope.setCurrentPractice = (practice) ->
    $scope.currentPractice = practice

  $scope.newPractice = ->
    $scope.currentPractice = null

  $scope.saveCurrentPractice = ->
    data = practice: {
      date: $scope.currentPractice.date}
    if $scope.currentPractice.id
      $http.put("/practices/#{$scope.currentPractice.id}.json", data).success => $scope.pullPractices()
    else
      $http.post("/practices.json", data).success => $scope.pullPractices()

  $scope.showSkaters = ->
    $scope.displayPracticeSkaters = true

  $scope.hideSkaters = ->
    $scope.displayPracticeSkaters = false


  $scope.init()

  ##############################################
  # Datepicker
  ##############################################
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
]
