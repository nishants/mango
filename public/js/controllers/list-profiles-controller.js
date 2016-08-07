app.controller("listProfilesController", ["$scope", "profiles", "projectService", "$stateParams", function( $scope, profiles, projectService, $stateParams){

  $scope.profiles = {
    list: profiles,
    update: function(profile, form){
      projectService.updateProfile($stateParams.project, profile.id, form).then(function(){
        projectService.profilesOf($stateParams.project).then(function(profiles){
          $scope.profiles.list = profiles;
        });
      });
    },
    search: {
      results: profiles,
    }
  };
}]);
