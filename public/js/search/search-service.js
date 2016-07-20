window.app.service("searchService", ["profilesService", "filterService", function (profilesService, filterService) {
    var defaultKey = ".*";

    var
        service = {
            profiles: {
                key    : null,
                results: [],
                search : function () {
                    var noKey   = !this.key || !this.key.length,
                        key     = noKey ? defaultKey : this.key;
                        profilesService.all().then(function (profiles) {
                            service.profiles.results = [];
                            service.profiles.results = filterService.filterProfiles(key, profiles);
                        });
                }

            },
        }
    return service;
}]);
