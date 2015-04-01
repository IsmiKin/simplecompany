'use strict';

var scApp = angular.module('scApp', ['ngRoute','admincMod']);

scApp.config(function($routeProvider){
    $routeProvider

        .when('/', {
            templateUrl : 'views/home.html',
            controller  : 'mainController'
        })

        .when('/company/admin/', {
            templateUrl : 'views/admincompany.html',
             controller  : 'admincController'
        })

        .when('/company/show/:idcompany', {
            templateUrl : 'views/details.html',
            controller  : 'detailsController'
        })

        .when('/company/edit/:idcompany', {
            templateUrl : 'views/edit.html'/*,
            controller  : 'editController'*/
        })

        .when('/company/create/', {
            templateUrl : 'views/create.html',
            controller  : 'createController'
        })
        .otherwise({ redirectTo: '/' });


});


scApp.controller('mainController', function($scope) {

    // create a message to display in our view
    $scope.message = 'Everyone come and see how good I look!';
});

scApp.factory('companyFactory',['$http',function($http){

    var urlBase = '/api';
    var dataFactory = {};

    dataFactory.getCompanies = function () {
        return $http.get(urlBase + "/company/all/");
    };

    dataFactory.getCompany = function (id) {
        return $http.get(urlBase + '/company/' + id);
    };

    dataFactory.insertCompany = function (ncompany) {
        return $http.post(urlBase + '/company/', ncompany);
    };

    dataFactory.updateCompany = function (ucompany) {
        return $http.put(urlBase + '/company/', ucompany)
    };

    dataFactory.insertPerson = function (nperson) {
        return $http.post(urlBase + '/person/', nperson);
    };

    return dataFactory;

}]);

