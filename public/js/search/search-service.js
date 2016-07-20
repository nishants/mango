window.app.service("searchService", ["profilesService", "filterService", function(profilesService, filterService){
    
    var 
        service =  {
        results : [],
        searchProfiles : function (key) {
            profilesService.all().then(function (profiles) {
                this.results = [];
                service.results = filterService.filterProfiles(key, profiles);
            });
        }
    }
    return service;
}]);
