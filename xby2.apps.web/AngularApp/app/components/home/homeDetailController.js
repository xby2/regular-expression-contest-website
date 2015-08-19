define(["angular", "angular-route", "componentsPath/home/homeController"], function () {
   var homeDetailController =
        function ($scope, $routeParams) {
            $scope.phoneName = $routeParams.phoneName;
        }
    return homeDetailController;
});

//Note that this is not defining an Angular controller yet
//We are defining the controller logic which will be assigned to an Angular controller later