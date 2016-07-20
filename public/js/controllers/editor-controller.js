app.controller("editorController", ["$scope", "fetchFile", "fileService", "$stateParams", function ($scope, fetchFile, fileService, $stateParams) {

    var editor = {
            canSave: false,
            treeView: undefined,
            content : fetchFile,
            save: function () {
                fileService.save($stateParams.name, $stateParams.file, editor.content).then(function () {
                    editor.canSave = false;
                }, function (err) {
                    console.error(err);
                })
            }
        },
        onCodeChange = function (arg, arg) {
            editor.canSave = true;
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
