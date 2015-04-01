
'use strict';

var scApp = angular.module('createMod',[]);

scApp.controller('createController' , function($scope,$rootScope,companyFactory,$http) {

    $scope.status;
    $scope.newcompany;

    $scope.addPerson = function(){
       $(".containerStuff").append(Handlebars.templates.person_input());
       $(".destroyPerson").click(function(){
           $(this).parent().remove();
       });
    };

    $scope.submitForm = function(){
        var $form = $(".newCompForm");
        var dataToSend = getFormData($form);
        companyFactory.insertCompany(JSON.stringify(dataToSend))
            .success(function (dataresponse) {
                if(dataresponse.error==0){
                    assignStuff(dataresponse.idcompany);
                }

            })
            .error(function (error) {
            });
    };

    function assignStuff(idcompany){
        $(".containerStuff").find("form").each(function(){
            var $form = $(this);
            var dataToSend = getFormData($form);
            dataToSend["company"] = idcompany;
            companyFactory.insertPerson(JSON.stringify(dataToSend))
                .success(function (dataresponse) {
                    if(dataresponse.error==0){

                    }

                })
                .error(function (error) {
                });
        });
    }


});
