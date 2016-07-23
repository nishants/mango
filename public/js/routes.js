app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/home.html",
            resolve: {
                loadProfile: function(searchService) {
                    return searchService.profiles.search();
                }
            }

        })
        .state('powermode', {
            url: "/power",
            templateUrl: "partials/powermode.html",
            resolve: {
                loadData: function(searchService, profilesService, fileService) {
                    return searchService.profiles.search().then(function (profiles){
                        return profilesService.findByName(profiles[0].name).then(function(){
                            return fileService.updateSchema().then(function(files){
                                return fileService.getFile(profiles[0].name, files[0].name);
                            });
                        });
                    });
                }
            }

        })
       .state('profile', {
           url: "/profiles/:name",
           templateUrl: "partials/profile.html",
           controller: "viewProfileController",
           resolve: {
               loadProfile: function($stateParams, profilesService, searchService, fileService) {
                   return fileService.updateSchema().then(function () {
                       return searchService.files.search().then(function () {
                           return profilesService.findByName($stateParams.name);
                       });
                   });
               }
           }
       })
       .state('profile.edit', {
           url: "/:file/edit",
           templateUrl: "partials/editor.html",
           controller: "editorController",
           resolve: {
               fetchFile: function($stateParams, fileService) {
                   return fileService.getFile($stateParams.name, $stateParams.file);
               }
           }
       });
});
