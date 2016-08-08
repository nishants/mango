app.controller("contractEditorController", ["$scope", "fetchFile", "fileService", "$stateParams", "diffService", "$state", "projectService", function ($scope, fetchFile, fileService, $stateParams, diffService, $state, projectService) {

  var editor = {
        canSave     : false,
        treeView    : undefined,
        content     : fetchFile,
        schemaDiff  : undefined,
        file        : undefined,
        savedContent     : diffService.create(fetchFile),
        showSchemaDialog : false,
        reload : function () {
          $state.go("profile.edit", {name: $scope.ui.profiles.current.name, file: editor.file.name});
        },
        updateSchema: function () {
          editor.showSchemaDialog = false;
        },
        closeSchemaDialog : function () {
          editor.showSchemaDialog = false;
        },
        confirmSave : function () {
          $state.go("projects.profiles.contract.diff");
        },
        confirmSchemaUpdate: function () {
          editor.showSchemaDialog = true;
        },
        codeChanged: function () {
          this.schemaDiff = editor.savedContent.schemaDiff(editor.content)
          editor.canSave = true;
        },
        updateSchemaForFile: function () {
          projectService.updateContractSchema($stateParams.project, $stateParams.contract, editor.schemaDiff.changes).then(function () {
            editor.canSave      = false;
            editor.savedContent = diffService.create(editor.content);
            editor.schemaDiff   = editor.savedContent.schemaDiff(editor.content);
            editor.showSchemaDialog = false;
            projectService.getFile($stateParams.project, $stateParams.profile, $stateParams.contract).then(function (data) {
              editor.content = data;
            });
          }, function (err) {
            editor.showSchemaDialog = false;
          });
        },
        save: function () {
          editor.canSave      = false;
          $state.go("projects.profiles.contract");
          projectService.saveFile($stateParams.project, $stateParams.profile, $stateParams.contract, editor.content).then(function () {
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
