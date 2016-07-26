describe('UIController', function() {
    beforeEach(module('mango'));

    var $controller,
        controller,
        projectService,
        profilesService,
        $scope = {};

    beforeEach(inject(function(_$controller_, _projectService_, _profilesService_){
        $controller = _$controller_;
        projectService = _projectService_;
        profilesService = _profilesService_;
    }));

    describe('$scope.grade', function() {
        beforeEach(inject(function(_$controller_){
            controller = $controller('uiController', { $scope: $scope });
        }));

        it('should set services no top scope', function() {
            expect($scope.ui).not.toBeNull();
            expect($scope.ui.schema).not.toBeNull();
            expect($scope.ui.profiles).toBe(profilesService);
            expect($scope.ui.projects).toBe(projectService);
        });
    });
});