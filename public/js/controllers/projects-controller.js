app.controller("projectsController", ["$scope", "projects", "projectService", "searchService", function ($scope, projects, projectService, searchService) {

  var workspace = {
    newProject : {
      path: "",
      name: "untitled",
      add : function(){
        projectService.create(this.name, this.path).then(function(){
          searchService.projects.search();
        });
      }},
    update: function(project, form){
      projectService.update(project, form).then(function(){
        searchService.projects.search();
      });
    }
  };
  $scope.workspace = workspace;
}]);
