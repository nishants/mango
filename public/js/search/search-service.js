window.app.service("searchService", ["profilesService", "filterService","schemaService", function (profilesService, filterService, schemaService) {
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
            files: {
                key    : null,
                results: [],
                search : function () {
                    var noKey   = !this.key || !this.key.length,
                        key     = noKey ? defaultKey : this.key;
                    schemaService.updateSchema().then(function (files) {
                        service.files.results = [];
                        service.files.results = filterService.filterFiles(key, files);
                    });
                }

            }
        }
    return service;
}]);
