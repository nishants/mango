app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "schemaService", "$stateParams", function($rootScope, $scope, profilesService, searchService, schemaService, $stateParams){
    $rootScope.$on('$stateChangeSuccess',
        function(event, state, params){
            var showingProfiles = state.name == "profile",
                showingFiles    = state.name == "profile.edit";

            // showingProfiles && profilesService.findByName(params.name);
        });
    
    $scope.ui = {
        state : $stateParams, 
        search : searchService, 
        profiles: profilesService,
        schema: schemaService,
    };
    
    $scope.ui.search.profiles.search();
    profilesService.all();
}]);
