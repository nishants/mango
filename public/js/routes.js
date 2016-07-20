app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/home.html"
        })
       .state('profile', {
           url: "/profiles/:name",
           templateUrl: "partials/profile.html",
           controller: "viewProfileController",
           resolve: {
               loadProfile: function($stateParams, profilesService) {
                   return profilesService.findByName($stateParams.name);
               }
           }
       })
       .state('profile.edit', {
           url: "/edit/:file",
           templateUrl: "partials/editor.html",
           controller: "editorController",
           resolve: {
               fetchFile: function($stateParams, profilesService) {
                   return profilesService.getFile($stateParams.name, $stateParams.file);
               }
           }
       });
});
