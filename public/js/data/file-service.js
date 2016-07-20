window.app.service("fileService", ["$http", function($http){
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
        },
        save :function (profileName, fileName, contents) {
            var url ="/profiles/:name/files/:file".replace(":name",profileName).replace(":file",fileName)
            return $http.put(url).then(function(response){
                return response.data;
            });
        }
    }
}]);
