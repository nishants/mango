window.app = angular.module("mango", ["ui.router", "ng.jsoneditor"]);
window.app.run(function (projectService) {
    return projectService.all().then(function () {
        if(projectService.list.length > 0){projectService.select(projectService.list[0].name);}
    });
});