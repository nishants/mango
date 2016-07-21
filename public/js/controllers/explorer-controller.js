app.controller("explorerController", ["$scope", "profilesService", "fileService", function( $scope, profilesService, fileService){
    var explorer = {profiles: []};
    var reset = function () {
        profilesService.all().then(function (profiles) {
            explorer.profiles = profiles;
            return fileService.updateSchema().then(function(files){
                explorer.profiles.forEach(function (profile) {
                    profile["files"] = files;
                });
            })
        });        
    }
    reset();
    $scope.explorer = explorer
}]);
