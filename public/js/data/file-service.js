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
        updateSchemaFor :function (fileName, updates) {
            var url ="/profiles/files/:file/update-schema".replace(":file",fileName)
            return $http.put(url, updates).then(function(response){
                return response.data;
            });
        },
        setFile: function (fileName) {
            this.current = files.filter(function(file){return file.name == fileName;});
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
