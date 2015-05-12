var app = angular.module('GSDT', ['restangular']);

app.controller('ActionsC', function($scope, Restangular) {
  Restangular.setBaseUrl('/api');
  $scope.actions = Restangular.all('action').getList().$object;
});
