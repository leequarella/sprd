window.DatepickerDemoCtrl = ($scope) ->
  $scope.today = ->
    $scope.dt = new Date()

  $scope.today()

  $scope.clear = ->
    $scope.dt = null

  # Disable weekend selection
  $scope.disabled = (date, mode) ->
    return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) )

  $scope.toggleMin = ->
    $scope.minDate = $scope.minDate ? null : new Date()

  $scope.toggleMin()

  $scope.open = ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.opened = true

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1

  $scope.initDate = new Date('2016-15-20')
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate']
  $scope.format = $scope.formats[0]
