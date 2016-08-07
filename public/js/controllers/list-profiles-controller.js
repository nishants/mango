app.controller("listProfilesController", ["$scope", "profiles", "projectService", "$stateParams", function( $scope, profiles, projectService, $stateParams){

  var profiles = {
    list: profiles,
    setContracts: function () {
      profiles.list.forEach(function(profile){
        projectService.getContracts($stateParams.project, profile.id).then(function(contracts){
          profile.contracts = contracts;
        });
      });
    },
    update: function (profile, form) {
      projectService.updateProfile($stateParams.project, profile.id, form).then(function () {
        projectService.profilesOf($stateParams.project).then(function (profiles) {
          profiles.list = profiles;
        });
      });
    },
    search: {
      results: profiles,
    }
  };

  profiles.setContracts();
  $scope.profiles = profiles;
}]);
