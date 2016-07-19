app.controller("profileController", ["$scope", "profilesService", function($scope, profilesService){
    $scope.profiles = profilesService;
    profilesService.all()
    profilesService.schema()
}]);
