app.directive("backButton", ["$window", function($window){
    return {
        restrict: "C",
        scope: false,
        transclude: false,
        link: function (scope, element) {
            element.on("click", function(){
                $window.history.back();
            })
        }
    }

}]);
