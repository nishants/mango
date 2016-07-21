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
            return getProfiles.then(function(){
                for(var i =0; i< service.list.length; i++){
                    if(service.list[i].name == name){
                        service.current = service.list[i];
                        return service.current;
                    }
                }
            });
        }
    };
    return service
}]);
