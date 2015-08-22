"use strict";
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

        $scope.progress = 0;

        //Sets the width of the progress bar
        $scope.setProgressBarWidth = function() {
            return {
                "width": $scope.progress + "%"
            };
        };

        $scope.updateProgress = function() {
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

        $scope.regex="";
        
        $scope.regexChange = function () {
            var regexInternal = new RegExp($scope.regex, 'g');
            $scope.filteredResults = $scope.problemData.match(regexInternal).toString().replace(/,/g, "\n");
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