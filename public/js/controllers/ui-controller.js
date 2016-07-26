app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "fileService", "$stateParams", "projectService", function($rootScope, $scope, profilesService, searchService, fileService, $stateParams, projectService){

    var ui = {
                state : $stateParams,
                search : searchService,
                profiles: profilesService,
                schema: fileService,
                projects : projectService,
                loader: {show : true}
        },
        showLoader = function () {ui.loader.show = true;},
        hideLoader = function () {ui.loader.show = false;};
    
    $rootScope.$on('$stateChangeStart', showLoader);
    $rootScope.$on('$stateChangeSuccess',hideLoader);
    
    $scope.ui = ui;
}]);
