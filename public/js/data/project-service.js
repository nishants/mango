window.app.service("projectService", ["$http", function($http){
    
    var getAll =  $http.get("/projects");
    var service = {
        list: [],
        current : undefined,
        all: function () {
            return getAll.then(function (response) {
                service.list = response.data;
                return service.list;
            })
        },
        select: function (name) {
            return service.all().then(function () {
                var selected = service.list[_.findIndex(service.list, function(project) { return project.name == name; })];
                return service.current = selected;
            })
        }
    };
    return service;
}]);
