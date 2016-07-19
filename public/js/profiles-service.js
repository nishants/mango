window.app.service("profilesService", ["$http", function($http){
    $http.get("/profiles").then(function(){})
    return {
        list: [],
        waiting: true,
        current: undefined,
        all : function(){
            var self = this;
            return $http.get("/profiles").then(function(response){
                self.list = response.data;
                self.waiting = false;
                return response;
            });
        },
        findByName : function(name){
            for(var i =0; i< this.list.length; i++){
                if(this.list[i].name == name){
                    this.current = this.list[i];
                    return this.current;
                }
            }
        },
        schema : function(){
            var self = this;
            return $http.get("/schema").then(function(response){
                self.schema = response.data;
                return response.data;
            });
        },
        getFile: function (profileName, fileName) {
            var self = this;
            self.fileEditing = null;
            return $http.get("/profiles/"+profileName+"/files/"+fileName).then(function(response){
                self.fileEditing = response.data;
                return response.data;
            });

        }

    }
}]);
