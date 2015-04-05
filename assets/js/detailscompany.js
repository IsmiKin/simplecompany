
'use strict';

var scApp = angular.module('detailsMod',[]);

scApp.controller('detailsController' , function($scope,$rootScope,companyFactory,$http,$location,$log,$routeParams) {

    $scope.status;
    $scope.companySel;
    $scope.staffSel;
    $scope.idcompany = $routeParams.idcompany;

    getData();

    function getData() {
        companyFactory.getFullCompany($scope.idcompany)
            .success(function (dataresponse) {
                $scope.companySel = dataresponse.company;
                $scope.staffSel = dataresponse.staff;
            })
            .error(function (error) {
                $scope.status = 'Unable to load customer data: ' + error.message;
            });
    };


    $scope.submitForm = function(){
        var $form = $(".editCompForm");
        var dataToSend = getFormData($form);
        dataToSend.idcompany = $scope.idcompany;

        companyFactory.updateCompany($scope.companySel)
            .success(function (dataresponse) {
                if(dataresponse.error==0){

                }
                $location.path('company/admin/')

            })
            .error(function (error) {
            });
    };

});
