app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/listing.html"
        })
//                    .state('state1', {
//                        url: "/state1",
//                        templateUrl: "partials/state1.html"
//                    })
//                    .state('state1.list', {
//                        url: "/list",
//                        templateUrl: "partials/state1.list.html",
//                        controller: function($scope) {
//                            $scope.items = ["A", "List", "Of", "Items"];
//                        }
//                    })
});
