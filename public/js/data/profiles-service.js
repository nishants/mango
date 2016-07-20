window.app.service("profilesService", ["$http", function($http){
    return {
        list: [],
        waiting: true,
        current: undefined,
        all : function(){
            var self = this;
            self.waiting = true;
            return $http.get("/profiles").then(function(response){
                self.list = response.data;
                self.waiting = false;
                return self.list;
            });
        },
        findByName : function(name){
            for(var i =0; i< this.list.length; i++){
                if(this.list[i].name == name){
                    this.current = this.list[i];
                    this.current.dir = this.current.name;
                    return this.current;
                }
            }
        },
        updateSchema : function(){
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
