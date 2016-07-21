app.controller("editorController", ["$scope", "fetchFile", "fileService", "$stateParams", "diffService", function ($scope, fetchFile, fileService, $stateParams, diffService) {

    var editor = {
            canSave: false,
            treeView: undefined,
            content : fetchFile,
            savedContent    : diffService.create(fetchFile),
            showSchemaDialog : true,
            updateSchema: function () {
                console.log("save");
                editor.showSchemaDialog = false;
            },
            closeSchemaDialog : function () {
                editor.showSchemaDialog = false;
            },
            codeChanged: function () {
                editor.canSave = true;
            },
            applyToAll: function () {
                fileService.applyToAll($stateParams.file, editor.content).then(function () {
                    editor.canSave = false;
                }, function (err) {
                    console.error(err);
                });
            },
            save: function () {
                var difference = this.savedContent.schemaDiff(editor.content);
                if(difference){
                    console.log("schema changed");
                }
                fileService.save($stateParams.name, $stateParams.file, editor.content).then(function () {
                    editor.canSave      = false;
                    editor.savedContent = diffService.create(editor.content);
                }, function (err) {
                    console.error(err);
                });
            }
        },
        onCodeChange = function (arg, arg) {
            editor.codeChanged();
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
