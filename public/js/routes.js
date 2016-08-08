app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/home.html",
            resolve: {
                loadProfile: function(searchService) {
                    return searchService.profiles.search();
                }
            }

        })
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
        })
       // .state('powermode', {
       //     url: "/power",
       //     templateUrl: "partials/powermode.html",
       //     resolve: {
       //         loadData: function(searchService, profilesService, fileService) {
       //             return searchService.profiles.search().then(function (profiles){
       //                 return profilesService.findByName(profiles[0].name).then(function(){
       //                     return fileService.updateSchema().then(function(files){
       //                         return fileService.getFile(profiles[0].name, files[0].name);
       //                     });
       //                 });
       //             });
       //         }
       //     }
       //
       // })
       //.state('profile', {
       //    url: "/profiles/:name",
       //    templateUrl: "partials/profile.html",
       //    controller: "viewProfileController",
       //    resolve: {
       //        loadProfile: function($stateParams, profilesService, searchService, fileService) {
       //            return fileService.updateSchema().then(function () {
       //                return searchService.files.search().then(function () {
       //                    return profilesService.findByName($stateParams.name);
       //                });
       //            });
       //        }
       //    }
       //})
       //.state('profile.edit', {
       //    url: "/:file/edit",
       //    templateUrl: "partials/editor.html",
       //    controller: "editorController",
       //    resolve: {
       //        fetchFile: function($stateParams, fileService) {
       //            return fileService.getFile($stateParams.name, $stateParams.file);
       //        }
       //    }
       //})
       // .state('profile.edit.diff', {
       //    url: "/diff",
       //    templateUrl: "partials/editor/diff.html",
       //    resolve: {
       //        fetchFile: function($stateParams, fileService) {
       //            return fileService.getFile($stateParams.name, $stateParams.file);
       //        }
       //    }
       //})
    ;
});
