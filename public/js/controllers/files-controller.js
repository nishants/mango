app.controller("profileController", ["$scope", "schemaService", function($scope, schemaService){
    schemaService.updateSchema();
    $scope.ui.search.files.search();
}]);
