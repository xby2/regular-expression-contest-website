## Summary

Single page application (SPA) website using .net and angular. The site will be used a contest site for computer science puzzles.


## Installation

**Visual Studio 2013 or greater is required**

**Assuming AngularApp folder is exposed to the web**

**Assuming Anonymous Authentication is enabled**

1. Fork/Clone this repo
2. Use nuget (in visual studio) to install/restore packages

## Technology Stack

* [ASP.NET MVC](http://www.asp.net/mvc)
 * Used to serve the initial web page starting the SPA.  Main benifit is user authentication and code to insert all .css and .js files into the initial page if they are included in the /Content/css directory or /Script/
* [ASP.NET Web API](http://www.asp.net/web-api)
 * Used to respond to ajax requests made from angular front-end
* [Angular](http://angularjs.org/)
 * Framework for single page application
 * Structure reasoning for angular (https://scotch.io/tutorials/angularjs-best-practices-directory-structure)
* [Requirejs](http://requirejs.org/)
 * Restricts the scope of javascript files to cleanly manage the angular controllers (aka view models)


## Conventions

### Autofac

Only Repository and Business Service projects are available using inversion of control.

To be used with autofac, the class must have:

* An interface
* That interface file in the contract directory

### Angular

#### App

* Contains the UI content.  Pages are setup in app.js.

* Components - A pairing of a view (html) and controller (js).  

* File names are {pageNameView}.html and {pageName}Controller.html.

#### Repository (Angular App)

* Javascript files that interact with the web api.

* File names {controllerName}Repository.js

#### Assets

* Contains static content and common javascript functions.

* The difference between this folder and xby2.apps.web/Scripts: This folder is javascript YOU WRITE the other folder is javascript from Nuget

### Requirejs

* The base path is set as /xby2.apps.web/AngularApp. Javascript file paths are from that directory.

> EXAMPLE
>
> file: AngularApp/app/components/test/testController.js
>
> define("app/components/test/testController", function(testController) {...});

### Controllers 

* Web Api Pattern: /api/{controllerName}/{methodName}/{id} (id is optional)

* Exposes the business logic with API calls.  Business logic should not exist in here.

* Files should end in {controllerName}Controller.cs

* Should only call functions from the business service or model projects.

### Business Services Project

* The business logic for the app.  

* Files should end in {serviceName}Service.cs

* Can reference other service classes but be careful to avoid circular references.  Should only call functions from the repository or model projects.

### Models Project

* Contains the classes that are used across projects.  This includes models (in the base of the project) and utilities (in the utilities folder).  

### Repository Project

* The project is used to provide a simple interface for getting data from CSV files.

### Git (Source Control)

* We are following a similar structure to [Git Flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow/)

## Contributors

Initial Team

Name | Notes
--- | ---
[Mohammed Hussain](http://github.com/mhhussain) | 
[Jeff Sallans](http://github.com/JeffSallans) | Created initial code base.
[Nickolas Jennings](http://github.com/jenningsnickolas) |
[Jason Brown](http://github.com/jasonrbr) |
[Ali Abdulhamid](http://github.com/abdulaliumich) |


## License

TBD
