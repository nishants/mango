app.controller("viewProfileController", ["$scope", "schemaService", "loadProfile", function($scope, schemaService, loadProfile){
    schemaService.updateSchema();
    $scope.ui.search.files.search();
}]);
