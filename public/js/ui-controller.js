app.controller("uiController", ["$rootScope", "$scope", "profilesService", function($rootScope, $scope, profilesService){
    $scope.profiles = profilesService;
    profilesService.all();
    profilesService.schema();

    $rootScope.$on('$stateChangeSuccess',
        function(event, toState, toParams){
            if(toState.name == "profile"){
                profilesService.findByName(toParams.name)
            }
            if(toState.name == "profile.edit"){
                profilesService.getFile(toParams.name, toParams.file)
            }
        });
}]);
