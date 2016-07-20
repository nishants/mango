window.app.service("schemaService", ["$http", function($http){
    return {
        files : [],
        updateSchema : function(){
            var self = this;
            return $http.get("/schema").then(function(response){
                self.files = response.data.files;
                return self.files;
            });
        }
    }
}]);
