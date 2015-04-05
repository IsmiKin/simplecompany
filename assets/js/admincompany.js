
    'use strict';

	var scApp = angular.module('admincMod',[]);

    scApp.controller('admincController' , function($scope,$rootScope,companyFactory,$http,$log) {

        $scope.status;
        $scope.companies;
        var modalDel =$("#dialogDelete");
        getData();

        function getData() {
            companyFactory.getCompanies()
                .success(function (dataresponse) {
                    $scope.companies = dataresponse;
                })
                .error(function (error) {
                    $scope.status = 'Unable to load customer data: ' + error.message;
                });
        };

        $scope.deleteCompany = function(idcompany){
            $log.debug("pika");
            $log.debug(idcompany);
            $scope.companyToDel = parseInt(idcompany);
            modalDel.modal("show");
        };

        $scope.confirmDelete = function(){
            companyFactory.deleteCompany($scope.companyToDel)
                .success(function (dataresponse) {
                    if(dataresponse.error==0){
                        modalDel.modal("hide");
                        getData();
                    }
                })
                .error(function (error) {
                    $scope.status = 'Unable to load customer data: ' + error.message;
                });
        };


    });
