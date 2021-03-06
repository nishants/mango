app.directive("diffEditor", [function () {

return {
    restrict : "C",
    scope : true,
    transclude : false,
    link :function ($scope) {

        var aceDiff = new AceDiff({
                mode: "ace/mode/json",
                maxDiffs: 100, // No of max diff's to show.
                left: {
                    editable: false,
                    content: JSON.stringify($scope.editor.savedContent.base(), null, "\t"),
                },
                right: {
                    editable: false,
                    content: JSON.stringify($scope.editor.content, null, "\t"),
                }
            }),
            aceEditor = aceDiff.editors.right.ace;
        $scope.diffEditor = aceDiff;
    }
};
}]);
