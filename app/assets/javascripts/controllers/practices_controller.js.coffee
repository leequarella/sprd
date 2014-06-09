@derby_app.controller "practicesController", ["skaters", "$scope", "$http", (skaters, $scope, $http) ->
  $scope.practices = []
  $scope.currentPractice = null
  $scope.init = ->
    $scope.pullPractices()
    $scope.updateSkaters()

  $scope.updateSkaters = ->
    $scope.skaters = skaters.all().then (skaters) ->
      $scope.skaters = skaters.data

  $scope.pullPractices = ->
    $http.get("/practices.json").success (data) =>
      $scope.practices = data

  $scope.setCurrentPractice = (practice) ->
    $scope.currentPractice = practice
    $scope.getStatuses()

  $scope.deleteCurrentPractice = ->
    if confirm "Are you sure you want to delete this practice? This can't be undone."
      $http.delete("/practices/#{$scope.currentPractice.id}.json").then =>
        $scope.pullPractices()

  $scope.getStatuses = ->
    $http.get("/practices/#{$scope.currentPractice.id}/statuses").then (statuses) =>
      $scope.appendStatuses statuses.data

  $scope.appendStatuses = (statuses) ->
    for skater in $scope.skaters
      match = {status: '', id: null}
      for status in statuses
        match = status if status.skater_id == skater.id
      skater.status = match

  $scope.newPractice = ->
    $scope.currentPractice = null

  $scope.saveCurrentPractice = ->
    data = practice: {
      date: $scope.currentPractice.date}
    if $scope.currentPractice.id
      $http.put("/practices/#{$scope.currentPractice.id}.json", data)
        .success => $scope.pullPractices()
    else
      $http.post("/practices.json", data).success => $scope.pullPractices()

  $scope.showSkaters = ->
    $scope.predicate = 'derby_name'
    $scope.displayPracticeSkaters = true

  $scope.hideSkaters = ->
    $scope.displayPracticeSkaters = false

  $scope.saveStatus = (skater)->
    data = skater_practice:
      skater_id: skater.id
      practice_id: $scope.currentPractice.id
      status: skater.status.status
    if skater.status.id
      $http.put("/skater_practices/#{skater.status.id}.json", data)
    else
      $http.post("/skater_practices.json", data).then (response) =>
        skater.status = response.data

  $scope.clearStatus = (skater) ->
    $http.delete("/skater_practices/#{skater.status.id}.json").then =>
      skater.status = {status: '', id: null}

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
