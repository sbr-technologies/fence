var app = angular.module('projbuilderApp');

app.directive('ngUniqueJobNo', ['apiService', function (apiService) {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        elem.on('change', function (evt) {
          scope.$apply(function () {
              apiService.validateJobNumber({id:scope.contract.id, 'job_number':scope.contract.job_number}).$promise.then(function(_response){
                ctrl.$setValidity('unique', _response.success, scope.frm_contract);
              });
          });
        });
      }
    }
  }]);

  app.directive('ngUniqueProductSku', ['apiService', function (apiService) {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        elem.on('change', function (evt) {
          scope.$apply(function () {
              apiService.validateProduct({id:scope.product.id, 'field': 'product_sku', 'value': scope.product.editableSku}).$promise.then(function(_response){
                ctrl.$setValidity('unique', _response.success, scope.frm_product);
              });
          });
        });
      }
    }
  }]);

  app.directive('ngUniqueProductName', ['apiService', function (apiService) {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        elem.on('change', function (evt) {
          scope.$apply(function () {
              apiService.validateProduct({id:scope.product.id, 'field': 'product_name', 'value': scope.product.editableName}).$promise.then(function(_response){
                ctrl.$setValidity('unique', _response.success, scope.frm_product);
              });
          });
        });
      }
    }
  }]);

  app.directive('ngUniqueManAccNo', ['apiService', function (apiService) {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        elem.on('change', function (evt) {
          scope.$apply(function () {
              apiService.validateManufacturerAccNo({id:scope.item.id, 'field': 'business_account_number', 'value': scope.item.editableAcc}).$promise.then(function(_response){
                ctrl.$setValidity('unique', _response.success, scope.frm_manufacturer);
              });
          });
        });
      }
    }
  }]);

  app.directive('ngUniqueCustOrg', ['apiService', function (apiService) {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        elem.on('change', function (evt) {
          scope.$apply(function () {
              apiService.validateCustOrga({id:scope.customer.id, 'business_name':scope.customer.business_name}).$promise.then(function(_response){
                ctrl.$setValidity('unique', _response.success, scope.frm_contract);
              });
          });
        });
      }
    }
  }]);

app.directive('focusNext', function () {
    'use strict';
    return {
        restrict: 'A',
        link: function (scope, elem, attrs, ctrl) {
          elem.on('click', function (evt) {
            elem.parents('td').find('select').focus();
          });
        }
    };
});