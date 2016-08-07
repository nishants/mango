app.controller("listProfilesController", ["$scope", "profiles", function( $scope, profiles){

  $scope.profiles = {
    list: profiles,
    search: {
      results: profiles,
    }
  };
}]);
