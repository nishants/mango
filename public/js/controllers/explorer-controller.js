app.controller("explorerController", ["$scope", "profilesService", "fileService", "$state", function( $scope, profilesService, fileService, $state){
    var explorer = {
        profiles: [],
        toggle : function (profile) {

        },
        showFile : function (profile, file) {
            $state.go("profile.edit", {name: profile.name, file: file.name})
        }
    };
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
