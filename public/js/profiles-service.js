window.app.service("profilesService", ["$http", function($http){
    $http.get("/profiles").then(function(){})
    return {
        list: [],
        waiting: true,
        all : function(){
            var self = this;
            return $http.get("/profiles").then(function(response){
                self.list = response.data;
                self.waiting = false;
                return response;
            });
        },
        schema : function(){
            var self = this;
            return $http.get("/schema").then(function(response){
                self.schema = response.data;
                return response.data;
            });
        }

    }
}]);
