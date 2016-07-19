app.controller("listingController", ["$scope", "profilesService", function($scope, profilesService){
    $scope.profiles = profilesService;
    profilesService.all()
}]);
