"use strict";
define(["angular",
    "moment",
    "lodash",
    "Repository/testRepository"],
    function (angular, moment, lodash, testRepo, activityRepo, projectRepo) {

    var homeController = function ($scope) {
        $scope.phones = [
            {
                'name': "Nexus S",
                'snippet': "Fast just got faster with Nexus S."
            },
            {
                'name': "Motorola XOOM™ with Wi-Fi",
                'snippet': "The Next, Next Generation tablet."
            },
            {
                'name': "MOTOROLA XOOM™",
                'snippet': "The Next, Next Generation tablet."
            }
        ];
    };
    return homeController;
});

//Note that this is not defining an Angular controller yet
//We are defining the controller logic which will be assigned to an Angular controller later