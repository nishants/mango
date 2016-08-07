app.directive("pressEnter", [function () {

  return {
    restrict: "A",
    scope: false,
    link: function(scope, element, attrs){
      element.on("keyup", function(){
        var enterPressed = event.keyCode == 13;
        enterPressed && scope.$eval(attrs.pressEnter);
      });

      element.on("blur", function(){
        scope.$eval(attrs.pressEnter)
      });

    }
  };
}]);
