require.config({

    //Sets the base url for all other references in Require
    //e.g. to access homeController in a define, put 'app/components/home/homeController' as a dependency
    baseUrl: "AngularApp",

    //resources outside baseUrl and shorthand paths
    //for example we can reference 'angular' or 'angular-route' instead of the full pathname
    //  or 'componentsPath/home/phoneDetailCtrl' instead of 'app/components/home/phoneDetailCtrl
    paths: {
        'angular': "../Scripts/angular.min",
        'angular-route': "../Scripts/angular-route.min",
        'moment': "../Scripts/moment.min",
        'lodash': "../Scripts/lodash.min",
        'componentsPath': "app/components"
    },

    //setting up dependencies for the resources in paths
    shim: {

        //sets up Angular with Require; without this, Angular would not load
        'angular': {
            exports: "angular"
        },

        //sets angular as a dependency for angular-route to ensure angular loads before angular-route
        'angular-route': {
            deps: ["angular"]
        }
    }
});

//require() is how we actually load and use our modules
//in our case, our main logic is in app.js
require(["app/app"], function(app) {
    app.init();
})