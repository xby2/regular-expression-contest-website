"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/regexPuzzleRepository"],
    function (angular, moment, lodash, regexPuzzleRepository) {

        var homeController = function ($scope) {
            $scope.progress = 0;

            function Puzzle(id, description, problem, goal) {
                this.id = id;
                this.description = description;
                this.problem = problem;
                this.goal = goal;
            }

            function Answer(puzzleId, regex) {
                this.Id = puzzleId;
                this.Regex = regex;
            }

            $scope.number = 1;
            $scope.answers = [];
            $scope.puzzles = [];
            $scope.email = "";

            regexPuzzleRepository.get()
                .then(function (puzzles) {
                    $scope.puzzles = puzzles;
                })
                .then(function () {
                    
                    var puzzle = $scope.puzzles.shift();

                    $scope.puzzleId = puzzle.Id;
                    $scope.description = puzzle.Description;
                    $scope.problemData = puzzle.Problem;
                    $scope.goal = puzzle.Goal;

                    $scope.filteredResults = "";
                    $scope.regex = "";

                    $scope.nextButtonDisabled = true;

                });

            $scope.regexChange = function () {
                var regexInternal;

                try {
                    regexInternal = new RegExp($scope.regex, 'g');
                }
                catch (e) {
                    $scope.filteredResults = 'There was an error trying to construct the regular expression: '
                        + e.message;
                }

                var match = $scope.problemData.match(regexInternal);
                if (match) {
                    $scope.filteredResults = match.toString().replace(/,/g, "\n");
                }
                else {
                    $scope.filteredResults = "";
                }

                $scope.filteredResults.trim() == $scope.goal.trim() ? $scope.nextButtonDisabled = 0 : $scope.nextButtonDisabled = 1;
            };

            $scope.setProgressBarWidth = function () {
                return {
                    "width": $scope.progress + "%"
                };
            };

            $scope.updateProgress = function () {
                // store problem data and regex answer
                $scope.answers.push(new Answer($scope.puzzleId, $scope.regex));
                console.log($scope.answers);

                if ($scope.progress < 100) {
                    //TODO: This number will be changed when we know the number of REGEX puzzles
                    $scope.progress += 20;
                    $scope.nextButtonDisabled = 1;

                    if ($scope.puzzles.length > 0) {
                        $scope.number++;
                        var puzzle = $scope.puzzles.shift();

                        $scope.problemId = puzzle.Id;
                        $scope.description = puzzle.Description;
                        $scope.problemData = puzzle.Problem;
                        $scope.goal = puzzle.Goal;
                    }
                }
                if ($scope.progress >= 100) {
                    //repository call
                    alert('call the repository');
                    regexPuzzleRepository.validateRegex($scope.answers, "test", $scope.email);
                }
            };

            /*
            $scope.puzzles.push(new Puzzle(
                1,
                "Only the bad Star Wars movies.",
                "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
            ))
            $scope.puzzles.push(new Puzzle(
                2,
                "any re, lowercase g, any e and then any number of lowercase x",
                "regex\nReGeX\nrEgEx\nregExxxxxx\nRegEx",
                "regex\nrEgEx\nregExxxxx\nRegEx"
            ))
            $scope.puzzles.push(new Puzzle(
                3,
                "Any number of letters, then whitespace, then Blue (capital B enforced)",
                "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
            ))
            $scope.puzzles.push(new Puzzle(
                4,
                "Capital Letter and length of 8",
                "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
            ))
            $scope.puzzles.push(new Puzzle(
                5,
                "0101",
                "Star Wars\nStar Wars Episode V\nStar Wars Episode VI\nStar Wars Episode I\nStar Wars Episode II\nStar Wars Episode III",
                "Star Wars Episode I\nStar Wars Episode II\nStar Wars Episode III"
            ))
            */
        };
        return homeController;
    });