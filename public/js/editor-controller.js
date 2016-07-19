app.controller("editorController", ["$scope", "profilesService", "$timeout", function($scope, profilesService, $timeout){

    var editor = {
        options: {
            mode: 'code',
            change: function(arg, arg){
                console.log("something changed");
            },
            onLoad: function (instance) {
                this.instance = instance;
                instance.expandAll();
                $timeout(function(){
                    instance.expandAll();
                },500);
            }
        }
    };

    var viewer = {
        options: {
            mode: 'tree',
            change: function(arg, arg){
                console.log("something changed");
            }
        },
        onLoad: function (instance) {
            this.instance = instance;
            $timeout(function(){
                instance.expandAll();
            });
        }
    };

    $scope.editor = editor;
    $scope.viewer = viewer;
}]);
