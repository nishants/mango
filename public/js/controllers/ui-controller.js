app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "schemaService", "$stateParams", function($rootScope, $scope, profilesService, searchService, schemaService, $stateParams){

    $scope.ui = {
        state : $stateParams, 
        search : searchService, 
        profiles: profilesService,
        schema: schemaService,
    };
}]);
