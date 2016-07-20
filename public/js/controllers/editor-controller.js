app.controller("editorController", ["$scope", "fetchFile", function ($scope, fetchFile) {

    var editor = {
            changed: false,
            treeView: undefined
        },
        onCodeChange = function (arg, arg) {
            editor.changed = true;
        };


    $scope.codeView = codeView = {
        options: {
            mode: 'code',
            change: onCodeChange,
            onLoad: function (instance) {
                this.instance = instance;
                instance.expandAll();
            }
        }
    };
    $scope.treeView = treeView = {
        options: {
            mode: 'tree',
            change: onCodeChange
        },
        onLoad: function (instance) {
            editor.treeView = instance;
            editor.treeView.expandAll();
        }
    };
    $scope.editor = editor;
}]);
