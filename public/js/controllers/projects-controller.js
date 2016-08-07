app.controller("projectsController", ["$scope", "projects", "projectService", function ($scope, projects, projectService) {

  var workspace = {
    newProject : {
      path: "",
      name: "untitled",
      add : function(){
        projectService.create(this.name, this.path).then(function(){
          projectService.all();
        });
      }
    }
  };
  $scope.workspace = workspace;
}]);
