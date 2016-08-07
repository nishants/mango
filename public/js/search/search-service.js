window.app.service("searchService", ["profilesService", "filterService","fileService", "projectService", function (profilesService, filterService, fileService, projectService) {
    var defaultKey = ".*";

    var
        service = {
            profiles: {
                key    : null,
                results: [],
                search : function () {
                    var noKey   = !this.key || !this.key.length,
                        key     = noKey ? defaultKey : this.key;
                        return profilesService.all().then(function (profiles) {
                            service.profiles.results = [];
                            service.profiles.results = filterService.filterProfiles(key, profiles);
                            return profiles;
                        });
                }

            },
            files: {
                key    : null,
                results: [],
                search : function () {
                    var noKey   = !this.key || !this.key.length,
                        key     = noKey ? defaultKey : this.key;
                    return fileService.updateSchema().then(function (files) {
                        service.files.results = [];
                        service.files.results = filterService.filterFiles(key, files);
                        return files;
                    });
                }

            },
            projects: {
                key    : null,
                results: [],
                search : function () {
                    var noKey   = !this.key || !this.key.length,
                        key     = noKey ? defaultKey : this.key;
                    return projectService.all().then(function (projects) {
                        service.projects.results = [];
                        service.projects.results = filterService.filterProjects(key, projects);
                        return projects;
                    });
                }

            }

        }
    return service;
}]);
