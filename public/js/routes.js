app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/listing.html"
        })
       .state('profile', {
           url: "/profiles/:name",
           templateUrl: "partials/profile.html"
       })
       .state('profile.edit', {
           url: "/edit/:file",
           templateUrl: "partials/editor.html"
       });
});
