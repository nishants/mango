window.app.service("projectService", ["$http", function($http){
    
    var service = {
        list: [],
        current : undefined,
        all: function () {
            return $http.get("/projects").then(function (response) {
                service.list = response.data;
                return service.list;
            })
        },
        select: function (name) {
            return service.all().then(function () {
                var selected = service.list[_.findIndex(service.list, function(project) { return project.name == name; })];
                return service.current = selected;
            })
        },
        create: function (name, path) {
            var url = "/projects/:name/import".replace(":name", name);
            service.error = null;
            return $http.put(url, {path: path}).then(function (response) {
                return service.current = response.data;
            }, function (response) {
                return service.error = response.data.error;
            });
        },
        update: function(project, form){
            var url = "/projects/:name".replace(":name", project.name);
            return $http.put(url, form).then(function (response) {
                service.all();
                return response.data;
            }, function (response) {
                console.error(response);
            });
        },
        remove: function(project){
            var url = "/projects/:name/remove".replace(":name", project.name);
            return $http.put(url).then(function (response) {
                return service.all();
            }, function (response) {
                console.error(response);
            });
        }
    };
    return service;
}]);
