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
//                    .state('state1.list', {
//                        url: "/list",
//                        templateUrl: "partials/state1.list.html",
//                        controller: function($scope) {
//                            $scope.items = ["A", "List", "Of", "Items"];
//                        }
//                    })
});
