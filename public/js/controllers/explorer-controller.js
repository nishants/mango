app.controller("explorerController", ["$scope", "profilesService", "fileService", "$state", function( $scope, profilesService, fileService, $state){
    var explorer = {
        profiles: [],
        toggle : function (profile) {
            profile.__expand = !profile.__expand;
        }
    };
    var reset = function () {
        profilesService.all().then(function (profiles) {
            explorer.profiles = profiles;
            return fileService.updateSchema().then(function(files){
                explorer.profiles.forEach(function (profile) {
                    profile.files = files;
                    profile.__expand = true;
                });
            })
        });        
    }
    reset();
    $scope.explorer = explorer
}]);
