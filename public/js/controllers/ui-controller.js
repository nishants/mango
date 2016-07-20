app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "fileService", "$stateParams", function($rootScope, $scope, profilesService, searchService, fileService, $stateParams){

    $scope.ui = {
        state : $stateParams, 
        search : searchService, 
        profiles: profilesService,
        schema: fileService,
    };
}]);
