app.controller("viewProfileController", ["$scope", "fileService", "loadProfile", function($scope, fileService, loadProfile){
    fileService.updateSchema();
    $scope.ui.search.files.search();
}]);
