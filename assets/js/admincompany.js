
    'use strict';

	var scApp = angular.module('admincMod',[]);

    scApp.controller('admincController' , function($scope,$rootScope,companyFactory,$http) {

        $scope.status;
        $scope.companies;

        getData();

        function getData() {
            companyFactory.getCompanies()
                .success(function (dataresponse) {
                    $scope.companies = dataresponse;
                })
                .error(function (error) {
                    $scope.status = 'Unable to load customer data: ' + error.message;
                });
        }

    });
