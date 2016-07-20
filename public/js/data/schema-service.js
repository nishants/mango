window.app.service("schemaService", ["$http", function($http){
    return {
        files : [],
        root  : undefined,
        updateSchema : function(){
            var self = this;
            return $http.get("/schema").then(function(response){
                self.files = response.data.files;
                self.root  = response.data.base;
                return self.files;
            });
        }
    }
}]);
