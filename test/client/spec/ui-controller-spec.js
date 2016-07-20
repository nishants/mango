describe('UIController', function() {
    beforeEach(module('mango'));

    var $controller,
        controller,
        $scope = {};

    beforeEach(inject(function(_$controller_){
        $controller = _$controller_;
    }));

    describe('$scope.grade', function() {
        beforeEach(inject(function(_$controller_){
            controller = $controller('uiController', { $scope: $scope });
        }));

        it('should set services no top scope', function() {
            expect($scope.ui).not.toBeNull();
            expect($scope.ui.schema).not.toBeNull();
            expect($scope.ui.profiles).not.toBeNull();
        });
    });
});