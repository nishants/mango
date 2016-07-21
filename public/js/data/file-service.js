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
            return $http.put(url,contents).then(function(response){
                return response.data;
            });
        },
        applyToAll :function (fileName, contents) {
            var url ="/profiles/apply-to-all/files/:file".replace(":file",fileName)
            return $http.put(url,contents).then(function(response){
                return response.data;
            });
        },
        getFile: function (profileName, fileName) {
            var self = this;
            return $http.get("/profiles/"+profileName+"/files/"+fileName).then(function(response){
                self.fileEditing = response.data;
                return response.data;
            });

        }
    };
}]);
