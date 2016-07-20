app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "$stateParams", function($rootScope, $scope, profilesService, searchService, $stateParams){
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
    $scope.ui = {state : $stateParams, search : searchService}
    
}]);
