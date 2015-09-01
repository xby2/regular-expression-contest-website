"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/testRepository"],
    function (angular, moment, lodash, testRepo, activityRepo, projectRepo) {

        var homeController = function ($scope) {
            $scope.progress = 0;

            $scope.setProgressBarWidth = function () {
                return {
                    "width": $scope.progress + "%"
                };
            };

            $scope.updateProgress = function () {
                if ($scope.progress < 100) {
                    //TODO: This number will be changed when we know the number of REGEX puzzles
                    $scope.progress += 10;
                    $scope.nextButtonDisabled = 1;
                }
                if ($scope.progress >= 100) {
                    //repository call
                }
            };

            $scope.problemData = "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III";

            $scope.answers = "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III";

            $scope.filteredResults = $scope.problemData;

            $scope.regex = "";

            $scope.regexChange = function () {
                var regexInternal;

                try {
                    regexInternal = new RegExp($scope.regex, 'g');
                }
                catch (e) {
                    alert('There was an error trying to construct the regular expression: '
                        + e.message);
                }

                $scope.filteredResults = $scope.problemData.match(regexInternal).toString().replace(/,/g, "\n");
                $scope.filteredResults == $scope.answers ? $scope.nextButtonDisabled = 0 : $scope.nextButtonDisabled = 1;
            };

            $scope.problemMetadata = {
                "number": "1",
                "difficulty": "1",
                "title": "Star Wars only the bad ones."
            };

            $scope.nextButtonDisabled = true;
        };
        return homeController;
    });