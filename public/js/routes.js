app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/projects");
    $stateProvider
        .state('projects', {
            url: "/projects",
            templateUrl: "partials/projects.html",
            controller: "projectsController",
            resolve: {
                projects: function(searchService) {
                    return searchService.projects.search();
                }
            }
        })
        .state('projects.profiles', {
            url: "/:project/profiles",
            templateUrl: "partials/list-profiles.html",
            controller:  "listProfilesController",
            resolve: {
                profiles: function($stateParams, projectService) {
                    return projectService.profilesOf($stateParams.project);
                }
            }
        })
        .state('projects.profiles.contract', {
            url: "/:profile/contracts/:contract",
            templateUrl: "partials/edit-profile-contract.html",
            controller:  "contractEditorController",
            resolve: {
                fetchFile: function($stateParams, projectService) {
                    return projectService.getFile($stateParams.project, $stateParams.profile, $stateParams.contract);
                }
            }
        })
         .state('projects.profiles.contract.diff', {
            url: "/diff",
            templateUrl: "partials/editor/diff.html",
            resolve: {
                fetchFile: function($stateParams, projectService) {
                    return projectService.getFile($stateParams.project, $stateParams.profile, $stateParams.contract);
                }
            }
        });
});
