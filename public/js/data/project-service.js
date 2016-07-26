window.app.service("projectService", ["$http", function($http){
    
    var getAll =  $http.get("/projects");
    var service = {
        all: [],
        current : undefined,
        all: function () {
            return getAll.then(function (response) {
                service.all = response.data.data;
                return service.all;
            })
        }
    };
    return service;
}]);
