"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/testRepository"],
    function (angular, moment, lodash, testRepo, activityRepo, projectRepo) {

        var homeController = function ($scope) {
            function Puzzle(id, description, problem, goal) {
                this.id = id;
                this.description = description;
                this.problem = problem;
                this.goal = goal;
            }

            function Answer(puzzleId, regex) {
                this.puzzleId = puzzleId;
                this.regex = regex;
            }

            function populatePuzzles() {
                var puzzleArray = [];
                puzzleArray.push(new Puzzle(
                    1,
                    "Only the bad Star Wars movies.",
                    "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                    "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
                ))
                puzzleArray.push(new Puzzle(
                    2,
                    "any re, lowercase g, any e and then any number of lowercase x",
                    "regex\nReGeX\nrEgEx\nregExxxxxx\nRegEx",
                    "regex\nrEgEx\nregExxxxx\nRegEx"
                ))
                puzzleArray.push(new Puzzle(
                    3,
                    "Any number of letters, then whitespace, then Blue (capital B enforced)",
                    "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                    "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
                ))
                puzzleArray.push(new Puzzle(
                    4,
                    "Capital Letter and length of 8",
                    "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                    "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
                ))
                puzzleArray.push(new Puzzle(
                    5,
                    "0101",
                    "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                    "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
                ))

                return puzzleArray;
            }

            $scope.setProgressBarWidth = function () {
                return {
                    "width": $scope.progress + "%"
                };
            };

            $scope.progress = 0;
            $scope.number = 1;
            $scope.answerCollection = [];
            $scope.puzzles = populatePuzzles();

            $scope.updateProgress = function () {
                // store problem data and regex answer
                $scope.answerCollection.push(new Answer($scope.puzzleId, $scope.regex));
                console.log($scope.answerCollection);

                if ($scope.progress < 100) {
                    //TODO: This number will be changed when we know the number of REGEX puzzles
                    $scope.progress += 20;
                    $scope.nextButtonDisabled = 1;
                    $scope.filteredResults = "";
                    $scope.regex = "";

                    if ($scope.puzzles.length > 0)
                    {
                        $scope.number++;
                        var puzzle = $scope.puzzles.shift();

                        $scope.problemId = puzzle.id;
                        $scope.description = puzzle.description;
                        $scope.problemData = puzzle.problem;
                        $scope.answers = puzzle.goal;

                        // check if the puzzles array is empty - display final container
                        if ($scope.puzzles.length == 0)
                        {
                            $("#nextButton").hide();
                            $("#finalDataContainer").show();
                        }
                    }
                }
                if ($scope.progress >= 100) {
                    //repository call
                    alert('call the repository');
                }
            };

            // initialize data
            var puzzle = $scope.puzzles.shift();

            $scope.puzzleId = puzzle.id;
            $scope.description = puzzle.description;
            $scope.problemData = puzzle.problem;
            $scope.answers = puzzle.goal;

            $scope.filteredResults = "";
            $scope.regex = "";

            $scope.regexChange = function () {
                var regexInternal;

                try {
                    regexInternal = new RegExp($scope.regex, 'g');
                }
                catch (e) {
                    // still need to figure out what to do about this
                }

                $scope.filteredResults =
                    $scope.problemData.match(regexInternal).toString().replace(/,/g, "\n");
                $scope.filteredResults == $scope.answers ?
                    $scope.nextButtonDisabled = 0 :
                    $scope.nextButtonDisabled = 1;
            };

            $scope.nextButtonDisabled = true;
        };

        return homeController;
    });