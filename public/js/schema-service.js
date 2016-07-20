window.app.service("schemaService", ["$http", function($http){
    return {
        schema: undefined,
        updateSchema : function(){
            var self = this;
            return $http.get("/schema").then(function(response){
                self.schema = response.data;
                return response.data;
            });
        }
    }
}]);
