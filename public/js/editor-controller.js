app.controller("editorController", ["$scope", "profilesService", function($scope, profilesService){
    $scope.obj = {
        options: {
            mode: 'tree',
            change: function(arg, arg){
                console.log("something changed");
            }
        }
    };
    $scope.onLoad = function (instance) {
        $scope.instance = instance;
        instance.expandAll();
    };
    $scope.changeData = function () {
        $scope.instance.expandAll();
    };
    $scope.changeOptions = function () {
        $scope.obj.options.mode = $scope.obj.options.mode == 'tree' ? 'code' : 'tree';
    };

    //other
    $scope.pretty = function (obj) {
        return angular.toJson(obj, true);
    }
}]);
