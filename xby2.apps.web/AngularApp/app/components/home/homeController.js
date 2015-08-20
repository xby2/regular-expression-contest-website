"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/testRepository"],
    function (angular, moment, lodash, testRepo, activityRepo, projectRepo) {

    var homeController = function ($scope) {
        $scope.problemData = "Star Wars\n" +
            "Star Wars Episode V\n" +
            "Star Wars Episode VI\n" +
            "Star Wars Episode I\n" +
            "Star Wars Episode II\n" +
            "Star Wars Episode III";

        $scope.answers = "Star Wars Episode I\n" +
            "Star Wars Episode II\n" +
            "Star Wars Episode III";

        $scope.filteredResults = "";

        $scope.regex = "";

        $scope.regexChange = function () {
            alert('hello world');
        };
    };
    return homeController;
});

//Note that this is not defining an Angular controller yet
//We are defining the controller logic which will be assigned to an Angular controller later