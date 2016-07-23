app.directive("diffEditor", [function () {

return {
    restrict : "C",
    scope : true, 
    transclude : false,
    link :function (scope, element) {
        var aceDiffer = new AceDiff({
            mode: "ace/mode/json",
            left: {
                content: JSON.stringify(scope.editor.content),
            }
        });
    }
};
}]);
