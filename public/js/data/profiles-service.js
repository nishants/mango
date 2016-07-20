window.app.service("profilesService", ["$http", "$q", function($http, $q){
    var getProfiles = $http.get("/profiles").then(function(response){
            service.list = response.data;
            service.waiting = false;
            return response.data;
        }),
        service = {
        list: [],
        waiting: true,
        current: undefined,
        all : function(){
            return getProfiles.then();
        },
        findByName : function(name){
            for(var i =0; i< this.list.length; i++){
                if(this.list[i].name == name){
                    this.current = this.list[i];
                    return this.current;
                }
            }

            return getProfiles.then(function(){

            });
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

    };
    return service
}]);
