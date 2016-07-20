app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "schemaService", "$stateParams", function($rootScope, $scope, profilesService, searchService, schemaService, $stateParams){
    $rootScope.$on('$stateChangeSuccess',
        function(event, toState, toParams){
            if(toState.name == "profile"){
                profilesService.findByName(toParams.name)
            }
            if(toState.name == "profile.edit"){
                profilesService.getFile(toParams.name, toParams.file)
            }
        });
    $scope.ui = {
        state : $stateParams, 
        search : searchService, 
        profiles: profilesService,
        scehma: schemaService,
    };
    
    $scope.ui.search.profiles.search();
    profilesService.all();
}]);
