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
        }
    };
    return service;
}]);
