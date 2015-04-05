
'use strict';

var scApp = angular.module('createMod',[]);

scApp.controller('createController' , function($scope,$rootScope,companyFactory,$http,$location,$log) {

    $scope.status;
    $scope.newcompany;
    var reader = new FileReader();


    $scope.addPerson = function(){
       $(".containerStaff").append(Handlebars.templates.person_input());
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
                    assignStaff(dataresponse.idcompany);
                }
                $location.path('company/admin/')

            })
            .error(function (error) {
            });
    };

    function assignStaff(idcompany){
        $(".containerStaff").find("form").each(function(){
            var $form = $(this);
            var dataToSend = getFormData($form);
            var file_u = $form.find(".fileUploader").get(0).files[0];
            dataToSend["company"] = idcompany;

            if(file_u!=undefined){
                reader.onload = function(e) {
                    $log.debug(reader.result);
                    dataToSend["passport"] = reader.result.split('base64,')[1];
                    dataToSend["encoded"] = true;
                    ajaxAssignStaff(dataToSend);
                };

                reader.readAsDataURL(file_u);
            }else{
                ajaxAssignStaff(dataToSend);
            }

        });
    }

    function ajaxAssignStaff(dataToSend){
        companyFactory.insertPerson(JSON.stringify(dataToSend))
            .success(function (dataresponse) {
                if(dataresponse.error==0){

                }

            })
            .error(function (error) {
            });
    }


});
