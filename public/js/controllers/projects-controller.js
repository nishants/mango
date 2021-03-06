app.controller("projectsController", ["$scope", "projects", "projectService", "searchService", function ($scope, projects, projectService, searchService) {

  var workspace = {
    newProject : {
      path: "",
      name: "untitled",
      add : function(){
        var self = this;
        projectService.create(this.name, this.path).then(function(){
          self.path = null;
          searchService.projects.search();
        });
      }
    },
    update: function(project, form){
      projectService.update(project, form).then(function(){
        searchService.projects.search();
      });
    },
    remove: function(project){
      projectService.remove(project).then(function(){
        searchService.projects.search();
      });
    }
  };
  $scope.workspace = workspace;
}]);
