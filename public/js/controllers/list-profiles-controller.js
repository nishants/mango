app.controller("listProfilesController", ["$scope", "profiles", "projectService", "$stateParams", function( $scope, profiles, projectService, $stateParams){

  $scope.profiles = {
    list: profiles,
    update: function(profile, form){
      projectService.updateProfile($stateParams.project, profile.name, form);
    },
    search: {
      results: profiles,
    }
  };
}]);
