app.controller("editorController", ["$scope", "fetchFile", "fileService", "$stateParams", "diffService", "$state", function ($scope, fetchFile, fileService, $stateParams, diffService, $state) {

    var editor = {
            canSave     : false,
            treeView    : undefined,
            content     : fetchFile,
            savedContent    : diffService.create(fetchFile),
            showSchemaDialog : false,
            schemaDiff  : undefined,
            file        : undefined,

            reload : function () {
                $state.go("profile.edit", {name: $scope.ui.profiles.current.name, file: editor.file.name})
            },
            updateSchema: function () {
                console.log("save");
                editor.showSchemaDialog = false;
            },
            closeSchemaDialog : function () {
                editor.showSchemaDialog = false;
            },
            confirmSchemaUpdate: function () {
                editor.showSchemaDialog = true;
            },
            codeChanged: function () {
                this.schemaDiff = editor.savedContent.schemaDiff(editor.content)
                editor.canSave = true;
            },
            updateSchemaForFile: function () {
                fileService.updateSchemaFor($stateParams.file, editor.schemaDiff.changes).then(function () {
                    editor.canSave      = false;
                    editor.savedContent = diffService.create(editor.content);
                    editor.schemaDiff   = editor.savedContent.schemaDiff(editor.content);
                    editor.showSchemaDialog = false;
                    fileService.getFile($stateParams.name, $stateParams.file).then(function (data) {
                        editor.content = data;
                    });
                }, function (err) {
                    editor.showSchemaDialog = false;
                });
            },
            save: function () {
                fileService.save($stateParams.name, $stateParams.file, editor.content).then(function () {
                    editor.canSave      = false;
                    editor.savedContent = diffService.create(editor.content);
                    editor.schemaDiff   = editor.savedContent.schemaDiff(editor.content);
                }, function (err) {
                    console.error(err);
                });
            }
        },
        onCodeChange = function (arg, arg) {
            editor.codeChanged();
        };

    fileService.setFile($stateParams.file);
    
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
    editor.file = $scope.ui.schema.files.filter(function (file) {
        return file.name == $stateParams.file;
    })[0];
}]);
