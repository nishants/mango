app.controller("uiController", ["$rootScope", "$scope", "profilesService", "searchService", "fileService", "$stateParams", function($rootScope, $scope, profilesService, searchService, fileService, $stateParams){

    var ui = {
                state : $stateParams,
                search : searchService,
                profiles: profilesService,
                schema: fileService,
                loader: {show : true}
        },
        showLoader = function () {ui.loader.show = true;},
        hideLoader = function () {ui.loader.show = false;};
    
    $rootScope.$on('$stateChangeStart', showLoader);
    $rootScope.$on('$stateChangeSuccess',hideLoader);

    $scope.ui = ui;
}]);
