﻿"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/testRepository"],
    function (angular, moment, lodash, testRepo, activityRepo, projectRepo) {

    var homeController = function ($scope) {
        /* needs review, may be better
        $scope.problemObject = {
            "dataPreRegex": "Star Wars\n" +
                        "Star Wars Episode V\n" +
                        "Star Wars Episode VI\n" +
                        "Star Wars Episode I\n" +
                        "Star Wars Episode II\n" +
                        "Star Wars Episode III";
            "answer":"String.."
            "dataPostRegex" = function(){
            }
        }
        */
        $scope.problemData = "";

        $scope.answers = "A";

        $scope.filteredResults = $scope.problemData;

        $scope.regex = "";

        $scope.regexChange = function () {
            $scope.filteredResults = $scope.problemData + $scope.regex;
            $scope.filteredResults == $scope.answers ? $scope.nextButtonDisabled = 0 : $scope.nextButtonDisabled = 1;
        };

        $scope.problemMetadata = {
            "number": "1",
            "difficulty": "1",
            "title":"Star Wars only the bad ones."
        }
        $scope.nextButtonDisabled = 1;
    };
    return homeController;
});

//Note that this is not defining an Angular controller yet
//We are defining the controller logic which will be assigned to an Angular controller later