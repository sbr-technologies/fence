/**
 * @ngdoc overview
 * @name projbuilderApp
 * @description
 * # projbuilderApp
 *
 * Main module of the application.
 */
var app = angular.module('projbuilderApp', [
    'ngAnimate',
    'ui.bootstrap',
    // 'ngCookies',
      'ngResource',
    'ngRoute',
   // 'ngSanitize',
   // 'ngTouch',
   // 'LocalStorageModule',
      'datatables',
      'ngScrollable',
      'google.places',
      'angularUtils.directives.dirPagination',
      'ngCkeditor'
  ]);
  
//angular.module('projbuilderApp')
  app.controller('MainCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
    $scope.title = 'Add Project';
//    var todosInStore = localStorageService.get('selection');
//    var itemsInStore = localStorageService.get('items')
    var vm = this;
    

    $scope.dateFormat = 'MM/dd/yyyy';
    $scope.dateToday = new Date();
    
    $scope.sort = function(keyname){
            $scope.sortKey = keyname;   //set the sortKey to the param passed
            $scope.reverse = !$scope.reverse; //if true make it false and vice versa
    };
    
    $scope.sortAlt = function(keyname){
            $scope.sortKeyAlt = keyname;   //set the sortKey to the param passed
            $scope.reverseAlt = !$scope.reverseAlt; //if true make it false and vice versa
    };
    
    $scope.editorOptions = {
        height: '250px'
    };
    
  }])
  .filter('highlight', function($sce) {
    return function(text, phrase) {
      if(!text || text === '')
        text = '--';
      text = text.toString();
      if (phrase) text = text.replace(new RegExp('('+phrase+')', 'gi'),
        '<span class="highlighted">$1</span>')

      return $sce.trustAsHtml(text);
    };
  });
  
  app.filter('isEmpty', function () {
        var bar;
        return function (obj) {
            for (bar in obj) {
                if (obj.hasOwnProperty(bar)) {
                    return false;
                }
            }
            return true;
        };
  });
  
  app.filter("sanitize", ['$sce', function ($sce) {
    return function (htmlCode) {
      return $sce.trustAsHtml(htmlCode);
    }
  }]);


app.controller('customerCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
  
    $scope.getCustomers = function(){
      apiService.getCustomers().$promise.then(function(_response) {
          $scope.customers = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedCustomers().length > 0)
              return true;
          };
      });
    };

    $scope.selectedCustomers = function () {
      return $filter('filter')($scope.customers, {checked: true});
    };
    
    $scope.enableMarginEditor = function(item) {
      item.marginEditorEnabled = true;
      item.editableMargin = item.margin_percent;
    };
    $scope.disableMarginEditor = function(item) {
      item.marginEditorEnabled = false;
    };

    $scope.enableStatusDd = function(item) {
      item.statusDdEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
    };
    $scope.disableStatusDd = function(item) {
      item.statusDdEnabled = false;
    };
    
    $scope.selectStatus = function(item) {
      $scope.selectedStatus = item;
    };
    
        /**
     * Start Date
     */
    $scope.enableEditorStartDate = function(item) {
      item.editorStartDateEnabled = true;
      item.editableStartDate = item.start_date;
    };
    $scope.disableEditorStartDate = function(item) {
      item.editorStartDateEnabled = false;
    };
    
    $scope.openStartDate = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenStartDate = true;
    };
    
    $scope.updateField = function(item, field, value) {
      var customer = {};
      if(field === 'start_date' && item[value]){
        item[value] = moment(item[value]).format('YYYY-MM-DD');
      }
      customer[field] = item[value];
      var sItem = apiService.updateCustomerField({id: item.id, customer: customer}, function success(response) {
        item[field] = sItem[field];
        item.status = sItem.status;
        $scope.disableMarginEditor(item);
        $scope.disableEditorStartDate(item);
        $scope.disableStatusDd(item);
      }, function err() {});
    };
    
    $scope.toggleSeleted = function() {
      $scope.allSelected = !$scope.allSelected;
      angular.forEach($scope.customers, function(manu){
        manu.checked = $scope.allSelected;
      });
    };
    
    $scope.selectedCustomers = function () {
      return $filter('filter')($scope.customers, {checked: true});
    };

    
    $scope.deleteCustomers = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteCustomers({selection: $scope.selectedCustomers()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
  }]);

  app.controller('employeeCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
  
    $scope.getEmployees = function(){
      apiService.getEmployees().$promise.then(function(_response) {
          $scope.employees = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedEmployees().length > 0)
              return true;
          };
      });
    };

    $scope.selectedEmployees = function () {
      return $filter('filter')($scope.employees, {checked: true});
    };
    
    $scope.enableNumberEditor = function(item) {
      item.numberEditorEnabled = true;
      item.editableNumber = item.employee_number;
    };
    $scope.disableNumberEditor = function(item) {
      item.numberEditorEnabled = false;
    };
    
    $scope.enableNameEditor = function(item) {
      item.nameEditorEnabled = true;
      item.editableName = item.product_name;
    };
    $scope.disableNameEditor = function(item) {
      item.nameEditorEnabled = false;
    };
    
    $scope.enableLastNameEditor = function(item) {
      item.lastNameEditorEnabled = true;
      item.editableLastName = item.last_name;
    };
    $scope.disableLastNameEditor = function(item) {
      item.lastNameEditorEnabled = false;
    };
    
    $scope.enableFirstNameEditor = function(item) {
      item.firstNameEditorEnabled = true;
      item.editableFirstName = item.first_name;
    };
    $scope.disableFirstNameEditor = function(item) {
      item.firstNameEditorEnabled = false;
    };
    
    $scope.enableMiNameEditor = function(item) {
      item.miNameEditorEnabled = true;
      item.editableMiName = item.middle_initial;
    };
    $scope.disableMiNameEditor = function(item) {
      item.miNameEditorEnabled = false;
    };

    
    
    $scope.updateField = function(item, field, value) {
      var employee = {};
      employee[field] = item[value];
      var sItem = apiService.updateEmployeeField({id: item.id, employee: employee}, function success(response) {
        item[field] = sItem[field];
        item.status = sItem.status;
        $scope.disableNumberEditor(item);
        $scope.disableFirstNameEditor(item);
        $scope.disableLastNameEditor(item);
        $scope.disableMiNameEditor(item);
      }, function err() {});
    };
    
    $scope.toggleSeleted = function() {
      $scope.allSelected = !$scope.allSelected;
      angular.forEach($scope.employees, function(manu){
        manu.checked = $scope.allSelected;
      });
    };
    
    $scope.selectedEmployees = function () {
      return $filter('filter')($scope.employees, {checked: true});
    };
    
    $scope.deleteEmployees = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteEmployees({selection: $scope.selectedEmployees()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
  }]); 

  app.controller('productCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
  
    $scope.getProducts = function(){
      apiService.getProducts().$promise.then(function(_response) {
          $scope.products = _response;
          $scope.isChecked = false;
          $scope.listLoaded = true;
          $scope.isChecked = function () {
            if ($scope.selectedProducts().length > 0)
              return true;
          };
      });
    };

    $scope.selectedProducts = function () {
      return $filter('filter')($scope.products, {checked: true});
    };
    
    $scope.enableSkuEditor = function(item) {
      item.skuEditorEnabled = true;
      item.editableSku = item.product_sku;
    };
    $scope.disableSkuEditor = function(item) {
      item.skuEditorEnabled = false;
    };
    
    $scope.enableNameEditor = function(item) {
      item.nameEditorEnabled = true;
      item.editableName = item.product_name;
    };
    $scope.disableNameEditor = function(item) {
      item.nameEditorEnabled = false;
    };

    $scope.enableCategoryDd = function(item) {
      item.categoryDdEnabled = true;
      item.editableCategory = item.category;
      item.editableCategoryId = item.category_item_code;
    };
    $scope.disableCategoryDd = function(item) {
      item.categoryDdEnabled = false;
    };

    $scope.enableUomDd = function(item) {
      item.uomDdEnabled = true;
      item.editableUom = item.unit_of_measure;
      item.editableUomId = item.uom_item_code;
    };
    $scope.disableUomDd = function(item) {
      item.uomDdEnabled = false;
    };

    $scope.enableStatusDd = function(item) {
      item.statusDdEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
    };
    $scope.disableStatusDd = function(item) {
      item.statusDdEnabled = false;
    };
    
//    $scope.selectStatus = function(item) {
//      $scope.selectedStatus = item;
//    };
//    
//    $scope.getStatusItems = function(){
//        apiService.getProductStatusItems().$promise.then(function (_response) {
//          $scope.statusItems = _response;
//          $scope.getUomItems();
//        });
//    };
//        
//    $scope.getUomItems = function(){
//        apiService.getProductUomItems().$promise.then(function (_response) {
//          $scope.uomItems = _response;
//          $scope.getCategoryItems();
//        });
//    };
//    
//    $scope.getCategoryItems = function(){
//        apiService.getProductCategories().$promise.then(function (_response) {
//          $scope.categoryItems = _response;
//        });
//    };
    
    $scope.updateField = function(item, field, value) {
      var product = {};
      product[field] = item[value];
      var sItem = apiService.updateProductField({id: item.id, product: product}, function success(response) {
        item[field] = sItem[field];
        item.status = sItem.status;
        item.category = sItem.category;
        item.unit_of_measure = sItem.unit_of_measure;
        $scope.disableSkuEditor(item);
        $scope.disableNameEditor(item);
        $scope.disableStatusDd(item);
        $scope.disableCategoryDd(item);
        $scope.disableUomDd(item);
      }, function err() {});
    };
    
    $scope.toggleSeleted = function() {
      $scope.allSelected = !$scope.allSelected;
      angular.forEach($scope.products, function(manu){
        manu.checked = $scope.allSelected;
      });
    };
    
    $scope.selectedProducts = function () {
      return $filter('filter')($scope.products, {checked: true});
    };
    
    $scope.deleteProducts = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteProducts({selection: $scope.selectedProducts()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
  }]); 

  app.controller('manufacturerCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
  
    $scope.getManufacturers = function(){
      $scope.getStatusItems();  
      apiService.getManufacturers().$promise.then(function(_response) {
          $scope.manufacturers = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedManufacturers().length > 0)
              return true;
          };
      });
    };

    $scope.selectedManufacturers = function () {
      return $filter('filter')($scope.manufacturers, {checked: true});
    };
    
    $scope.enableAccEditor = function(item) {
      item.accEditorEnabled = true;
      item.editableAcc = item.business_account_number;
    };
    $scope.disableAccEditor = function(item) {
      item.accEditorEnabled = false;
    };

    $scope.enableStatusDd = function(item) {
      item.statusDdEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
    };
    $scope.disableStatusDd = function(item) {
      item.statusDdEnabled = false;
    };
    
    $scope.selectStatus = function(item) {
      $scope.selectedStatus = item;
    };
    
    $scope.getStatusItems = function(){
        apiService.getManufacturerStatusItems().$promise.then(function (_response) {
          $scope.statusItems = _response;
        });
    };
    
    $scope.updateField = function(item, field, value) {
      var manufacturer = {};
      manufacturer[field] = item[value];
      var sItem = apiService.updateManufacturerField({id: item.id, manufacturer: manufacturer}, function success(response) {
        item[field] = sItem[field];
        item.status = sItem.status;
        $scope.disableAccEditor(item);
        $scope.disableStatusDd(item);
      }, function err() {});
    };
    
    $scope.toggleSeleted = function() {
      $scope.allSelected = !$scope.allSelected;
      angular.forEach($scope.manufacturers, function(manu){
        manu.checked = $scope.allSelected;
      });
    };
    
    $scope.selectedManufacturers = function () {
      return $filter('filter')($scope.manufacturers, {checked: true});
    };
    
    $scope.selectManufacturersIds = function() {
      var projs = $scope.selectedManufacturers();
      var ids = [];
      angular.forEach(projs, function(manu) {
        ids.push(manu.id);
      });
      return ids;
    };

    
    $scope.deleteManufacturers = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteManufacturers({selection: $scope.selectedManufacturers()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
  }]); 

  app.controller('supplierCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
      $scope.selection = [];
      $scope.supplierSelection = [];
      $scope.selectedSupplierIds = [];
    
      $scope.getSuppliers = function(){
      apiService.getSuppliers().$promise.then(function(_response) {
          $scope.suppliers = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedSuppliers().length > 0)
              return true;
          };
      });
    };

    $scope.selectedSuppliers = function () {
      return $filter('filter')($scope.suppliers, {checked: true});
    };
    
    $scope.enableNumberEditor = function(item) {
      item.numberEditorEnabled = true;
      item.editableNumber = item.business_account_number;
    };
    $scope.disableNumberEditor = function(item) {
      item.numberEditorEnabled = false;
    };

    $scope.enableStatusDd = function(item) {
      item.statusDdEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
    };
    $scope.disableStatusDd = function(item) {
      item.statusDdEnabled = false;
    };
    
    $scope.selectSupplierStatus = function(item) {
      $scope.selectedSupStat = item;
    };
    
    $scope.updateField = function(item, field, value) {
      var supplier = {};
      supplier[field] = item[value];
      var sItem = apiService.updateSupplierField({id: item.id, supplier: supplier}, function success(response) {
        item[field] = sItem[field];
        item.status = sItem.status;
        $scope.disableNumberEditor(item);
      }, function err() {});
    };
    
    $scope.toggleSeleted = function() {
      $scope.allSelected = !$scope.allSelected;
      angular.forEach($scope.suppliers, function(manu){
        manu.checked = $scope.allSelected;
      });
    };
    
    $scope.selectedSuppliers = function () {
      return $filter('filter')($scope.suppliers, {checked: true});
    };
    
    
    $scope.deleteSuppliers = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteSuppliers({selection: $scope.selectedSuppliers()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
  }]); 


  
  app.controller('projectCtrl', ['$scope', '$timeout', '$filter', '$http', 'apiService','$location', function($scope, $timeout, $filter, $http, apiService, $location) {
      $scope.selection = [];
      $scope.projectSelection = [];
      $scope.selectedProjectIds = [];
      $scope.productsLoaded = false;
      
      $scope.selectedProjCat = null;
      $scope.selectedProjStat = null;
      $scope.selectedFilterCat = null;
    
      $scope.getProjects = function(){
      apiService.getProjects().$promise.then(function(_response) {
          $scope.projects = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedProjects().length > 0)
              return true;
          };
      });
    };
    
    
    $scope.isItemSelected = function (item) {
      var idx;
      idx = $scope.selection.map(function (type) {
        return type.product_id;
      }).indexOf(item.product_id);
      if (idx > -1)
        return false;
      else
        return true;
    };
      
    $scope.getProjectCategories = function() {
      apiService.getProjectCategories().$promise.then(function(_response) {
        $scope.projectCats = _response;
        $scope.getProjectStatusItems();
        $scope.getProductCategories();
      });
    };
    
    $scope.getProjectStatusItems = function(){
        apiService.getProjectStatusItems().$promise.then(function (_response) {
          $scope.projectStatusItems = _response;
        });
    };
    
    $scope.getProductCategories = function() {
      apiService.getProductCategories().$promise.then(function(_response) {
        $scope.productCats = _response;
        $scope.getProducts();
      });
    };
    
    $scope.getProducts = function () {
        apiService.query().$promise.then(function (_response) {
            $scope.items = _response;
            $scope.productsLoaded = true;
        });
    };
    
    
    $scope.getPgProducts = function(pgId){
      apiService.getPgProducts({id: pgId}).$promise.then(function (_response) {
        $scope.selection = _response;
      });
    };
    
    $scope.getProject = function(id) {
      apiService.getProject({id:id}).$promise.then(function(_response) {
        $scope.project = _response;
        $scope.selectProjectCat({id:_response.category_item_code, description: _response.category});
        $scope.selectProjectStatus({id:_response.status_item_code, description: _response.status});
        $scope.getPgProducts(id);
        $scope.getProjectCategories();
      });
    };
    
    

    $scope.allSelected = false;
    $scope.toggleSeleted = function() {
        $scope.allSelected = !$scope.allSelected;
        angular.forEach($scope.projects, function(proj){
        proj.checked = $scope.allSelected;
        });
    };
    
    $scope.selectedProjects = function () {
      return $filter('filter')($scope.projects, {checked: true});
    };
    
    $scope.selectProjectIds = function() {
      var projs = $scope.selectedProjects();
      var ids = [];
      angular.forEach(projs, function(proj) {
        ids.push(proj.id);
      });
      return ids;
    };

    
    $scope.deleteProjects = function() {
//        console.log($scope.selectedProjects())
        apiService.deleteProjects({selection: $scope.selectedProjects()}, function success(_response) {	 
//        var url = $location.absUrl().replace("new", "");
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
    $scope.editorEnabled = false;
    $scope.enableEditor = function(item) {
      item.editorEnabled = true;
      item.editableTitle = item.project_group_name;
    };
    $scope.disableEditor = function(item) {
      item.editorEnabled = false;
    };
    
    $scope.statusDdEnabled = false;
    $scope.enableStatusDd = function(item) {
      item.statusDdEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
    };
    $scope.disableStatusDd = function(item) {
      item.statusDdEnabled = false;
    };
    
    $scope.catDdEnabled = false;
    $scope.enableCatDd = function(item) {
      item.catDdEnabled = true;
      item.editableCat = item.category;
      item.editableCatId = item.category_item_code;
    };
    $scope.disableCatDd = function(item) {
      item.catDdEnabled = false;
    };
    
    $scope.updateProjectField = function(item) {
      $scope.disableEditor(item);
      $scope.disableStatusDd(item);
      $scope.disableCatDd(item);
        var sItem = apiService.updateProjectField({id: item.id, project_group: {'project_group_name': item.editableTitle, 'category_item_code': item.editableCatId, 'status_item_code': item.editableStatusId}}, function success(response) {
        item.project_group_name = sItem.project_group_name;
        item.status = sItem.status;
        item.status_item_code = sItem.status_item_code;
        item.category = sItem.category;
        item.category_item_code = sItem.category_item_code;
      }, function err() {});
      if(item.editableTitle)
        item.name = item.editableTitle;
    };
    angular.forEach($scope.items, function(item) {
      if ($scope.selection.map(function(type) {
          return type.id;
        }).indexOf(item.id) != -1) {
        item.checked = true;
      } else {
        item.checked = false;
      }
    });
    // });
    $scope.isExist = function(item) {
      return $scope.selection.map(function(type) {
        return type.id;
      }).indexOf(item.id) !== -1;
    };
    
    $scope.createProject = function(project) {
      $scope.submitted = true;
      if(!$scope.frmManageProject.$valid){
        return false;
      }
      var item = apiService.createProject({project_group: {'project_group_name': project.project_group_name, 'category_item_code': $scope.selectedProjCat.id, 'project_group_description': project.project_group_description, 'project_group_long_description': project.project_group_long_description, 'status_item_code': $scope.selectedProjStat.id},selection: $scope.selection}, function success() {	 
      var url = $location.absUrl().replace("new", "");  
        window.onbeforeunload = null;
        window.location.href =url;
      }, function err() {});
    };

    $scope.updateProject = function(project) {
      $scope.submitted = true;
      if(!$scope.frmManageProject.$valid){
        return false;
      }
      var item = apiService.updateProject({id: project.id, project_group: {'project_group_name': project.project_group_name, 'category_item_code': $scope.selectedProjCat.id, 'project_group_description': project.project_group_description, 'project_group_long_description': project.project_group_long_description, 'status_item_code': $scope.selectedProjStat.id},selection: $scope.selection}, function success() {	 
      var url = item.redirect_url;
        window.onbeforeunload = null;
        window.location.href =url;
      }, function err() {});
    };
    
    $scope.selectProjectCat = function(item) {
      $scope.selectedProjCat = item;
    };
    
    $scope.selectProjectStatus = function(item) {
      $scope.selectedProjStat = item;
    };
    
    
    $scope.productFilterCat = function(item) {
      $scope.selectedFilterCat = item;
      
    };
    
    $scope.filterProdutByCat = function(item) {
      return $scope.selectedFilterCat === null || item.category_item_code === $scope.selectedFilterCat.id;
    };
    
    $scope.addSelection = function(item) {
      $scope.selection.push(item);
    };
    
    $scope.removeSelection = function(item) {
      var idx;
      idx = $scope.selection.map(function (type) {
        return type.product_id;
      }).indexOf(item.product_id);
      if (idx > -1) {
        $scope.selection.splice(idx, 1);
      }
    };
  }]);
  
  app.controller('contractCtrl', ['$scope', '$location', '$filter', 'apiService', '$uibModal', function($scope, $location, $filter, apiService, $uibModal){
    /**
    * Scripts bellow related to Contracts
    * 
    */
   
   $scope.customerSelected = false;
   
   $scope.getDefaultPaymentTerm = function(item){
       apiService.getLookupItem({id:item}).$promise.then(function(_response){
           $scope.contract.cp_payment_terms = _response.long_description;
       });
   };
   
   $scope.getDefaultProposalTerm = function(item){
        apiService.getLookupItem({id:item}).$promise.then(function(_response){
           $scope.contract.cp_proposal_terms = _response.long_description;
       });
   };
   
   
      
    $scope.getContracts = function(){
      apiService.getContracts().$promise.then(function(_response) {
          $scope.contracts = _response;
          $scope.listLoaded = true;
          $scope.isChecked = false;
          $scope.isChecked = function () {
            if ($scope.selectedContracts().length > 0)
              return true;
          };
      });
    };
   
    $scope.allSelected = false;
    $scope.toggleSeleted = function() {
        $scope.allSelected = !$scope.allSelected;
        angular.forEach($scope.contracts, function(cont){
          cont.checked = $scope.allSelected;
        });
    };
    
    $scope.selectedContracts = function () {
      return $filter('filter')($scope.contracts, {checked: true});
    };
    
    $scope.selectContractIds = function() {
      var conts = $scope.selectedContracts();
      var ids = [];
      angular.forEach(conts, function(cont) {
        ids.push(cont.id);
      });
      return ids;
    };
    
        
    $scope.deleteContracts = function() {
//        console.log($scope.selectedContracts())
        apiService.deleteContracts({selection: $scope.selectedContracts()}, function success(_response) {	 
	window.location.href =_response.url;
	  }, function err() {
              alert('Error');
          });
    };
    
    $scope.disableOtherEditor = function(item, col){
      if(item.editorJobNoEnabled === true && col !== 'jobNo')
        $scope.disableEditorJobNo(item)
      if(item.editorPropDateEnabled === true && col !== 'propDate')
        $scope.disableEditorPropDate(item);
      if(item.editorStartDateEnabled === true && col !== 'startDate')
        $scope.disableEditorStartDate(item);
      if(item.editorCompDateEnabled === true && col !== 'compDate')
        $scope.disableEditorCompDate(item);
      if(item.ddStatusEnabled === true && col !== 'status')
        $scope.disableDdStatus(item);
    };
   
    /**
     * Job Number field
     */
    $scope.editorJobNoEnabled = false;
    $scope.enableEditorJobNo = function(item) {
      item.editorJobNoEnabled = true;
      item.editableJobNo = item.job_number;
      $scope.disableOtherEditor(item, 'jobNo');
    };
    $scope.disableEditorJobNo = function(item) {
      $scope.frmContractProposals.txt_job_number.$setValidity('unique', true);
      item.editorJobNoEnabled = false;
      item.job_number = item.editableJobNo;
      
    };
    /**
     * Proposal Date
     */
    $scope.editorPropDateEnabled = false;
    $scope.enableEditorPropDate = function(item) {
      item.editorPropDateEnabled = true;
      item.editablePropDate = item.proposal_date;
      $scope.disableOtherEditor(item, 'propDate');
    };
    $scope.disableEditorPropDate = function(item) {
      item.editorPropDateEnabled = false;
      item.proposal_date = item.editablePropDate;
    };
    $scope.openPropDate = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenPropDate = true;
    };
    /**
     * Start Date
     */
    $scope.editorStartDateEnabled = false;
    $scope.enableEditorStartDate = function(item) {
      item.editorStartDateEnabled = true;
      item.editableStartDate = item.start_date;
      $scope.disableOtherEditor(item, 'startDate');
    };
    $scope.disableEditorStartDate = function(item) {
      item.editorStartDateEnabled = false;
      item.start_date = item.editableStartDate;
    };
    
    $scope.openStartDate = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenStartDate = true;
    };
    
   /**
    *   for print
    * @param {type} $event
    * @param {type} item
    * @param {type} attr
    * @returns {undefined}
    */
   $scope.selectedProjectFilter = {};
   $scope.selectedCustomerFilter = {};
    $scope.proposals_filter = {};
    $scope.openStartDateFilter = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenStartDateFilter = true;
    };
    
    $scope.openCompDateFilter = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenCompDateFilter = true;
    };
    
    $scope.initFilter = function(){
      apiService.getCustomersName().$promise.then(function (_response) {
        $scope.customers = _response;
        $scope.getProjects();
      });
    };
    
    $scope.selectProjectFilter = function (item) {
      $scope.selectedProjectFilter = item;
      $scope.contract.customer_id = item.id;
    };
    
    $scope.selectCustomerFilter = function (item) {
      $scope.selectedCustomerFilter = item;
      $scope.contract.customer_id = item.id;
    };
    
    $scope.clearCustomerFilter = function(filter){
      $scope.selectedCustomerFilter = {};
      $scope.filterContractProposals(filter);
    };
    
    $scope.clearProjectFilter = function(filter){
      $scope.selectedProjectFilter = {};
      $scope.filterContractProposals(filter);
    };
    
    $scope.filterContractProposals = function(filter){
      var startDate, completionDate;
      if(filter.start_date){
        startDate = moment(filter.start_date).format('YYYY-MM-DD');
      }
      if(filter.completion_date){
        completionDate = moment(filter.completion_date).format('YYYY-MM-DD');
      }
      apiService.getContracts({'start_date': startDate, 'completion_date': completionDate, 'customer_id': $scope.selectedCustomerFilter.id, 'project_group_id':$scope.selectedProjectFilter.id}, function success(_response) {
          $scope.contracts = _response;
      }, function err() {});
    };
    
    /* Filter end */
    
    /**
     * Completion Date
     */
    $scope.editorCompDateEnabled = false;
    $scope.enableEditorCompDate = function(item) {
      item.editorCompDateEnabled = true;
      item.editableCompDate = item.completion_date;
      $scope.disableOtherEditor(item, 'compDate');
    };
    $scope.disableEditorCompDate = function(item) {
      item.editorCompDateEnabled = false;
      item.completion_date = item.editableCompDate;
    };
    
    $scope.openCompDate = function ($event, item, attr) {
      $event.preventDefault();
      $event.stopPropagation();
      item.isOpenCompDate = true;
    };
    
    /**
     * 
     * Status
     */
    
    $scope.ddStatusEnabled = false;
    $scope.enableDdStatus = function (item) {
      item.ddStatusEnabled = true;
      item.editableStatus = item.status;
      item.editableStatusId = item.status_item_code;
      $scope.disableOtherEditor(item, 'status');
    };
    $scope.disableDdStatus = function (item) {
      item.ddStatusEnabled = false;
      item.status = item.editableStatus;
      item.status_item_code = item.editableStatusId;
    };
        
    $scope.updateContractField = function(item) {
      $scope.frmContractProposals.txt_job_number.$setValidity('unique', true);
      item.editorJobNoEnabled = false;
      item.editorPropDateEnabled = false;
      item.editorStartDateEnabled = false;
      item.editorCompDateEnabled = false;
      item.ddStatusEnabled = false;
      var sItem = apiService.updateContractField({id: item.id, contract: {'job_number': item.job_number, 'proposal_date': item.proposal_date, 'start_date': item.start_date, 'completion_date': item.completion_date, 'status_item_code': item.editableStatusId}}, function success(response) {
          item.job_number = response.job_number;
          item.status = response.status;
          item.status_item_code = response.status_item_code;
      }, function err() {});
      if(item.editableTitle)
        item.name = item.editableTitle;
    };
    
    /**
     * Add / Edit Contract Starts from here
     */
    
    $scope.openAddPropDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenAddPropDate = true;
    };
    
    $scope.openAddStartDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenAddStartDate = true;
    };
    
    $scope.openAddCompDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenAddCompDate = true;
    };
    
    $scope.openSignDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenSignDate = true;
    };
    
    $scope.openCustStartDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenCustStartDate = true;
    };
    
    $scope.openCustEndDate = function ($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.isOpenCustEndDate = true;
    };
    
    /**
     * Handle Customer Form
     */
    /**
     * Google maps Autocomplete
     */
    $scope.customerPlaces = null;
    $scope.customer = [];
    
    $scope.$on('g-places-autocomplete:select', function (event, param) {
//    console.log(event);
//    console.log(param);
        var data = {};
        var comp = param.address_components;
        angular.forEach(comp, function(object){
          var name = object.types[0];
          angular.forEach(object.types, function(name){
            data[name] = object.long_name
          });
        });
        console.log(data);
        var addr = '';
        if(data['route']){
          addr = data['route'];
        }
        if(data['street_number']){
          addr = data['street_number'] + ', ' + addr;
        }
        if(data['premise']){
          addr = data['premise'];
        }
        if(data['sublocality_level_2']){
          addr = addr + ', ' + data['sublocality_level_2'];
        }
        
        $scope.customer.line_2 = data['sublocality_level_1'];
        $scope.customer.line_1 = addr;
        $scope.customer.city = data['locality'];
        $scope.customer.state = data['administrative_area_level_1'];
        $scope.customer.zip = data['postal_code'];
  });
  
    $scope.contract = [];
    $scope.selectedCustomer = null;
    $scope.selectedStatus = null;
    $scope.selectedProjects = {};
    $scope.selectedProjectsTemp = {};
    $scope.selectedProject = null;
    $scope.items = [];
    $scope.productsLoaded = false;
    
    
    $scope.getProposalStatusItems = function(){
        apiService.getProposalStatusItems().$promise.then(function (_response) {
          $scope.proposalStatusItems = _response;
        });
    };
    
    $scope.getCustomers = function(){
      apiService.getCustomers().$promise.then(function (_response) {
        $scope.customers = _response;
        $scope.getProjects();
        $scope.getProposalStatusItems();
      });
    };
    
    $scope.getProjects = function(){
      apiService.getProjectsName().$promise.then(function (_response) {
        $scope.projects = _response;
        if ($scope.productsLoaded === false) {
          $scope.getAvailableProducts();
          $scope.getProductCategories();
        }
      });
    };
    
    $scope.selectProject = function(item){
      if($scope.isApplied(item)){
        return false;
      }
      item.project_group_id = item.id;
      $scope.selectedProjectsTemp[item.id] = item;
    };
    
    $scope.applyProjects = function(){
      angular.forEach($scope.selectedProjectsTemp, function(tmp){
        angular.forEach(tmp.pg_products, function (prod, key) {
          tmp.pg_products[key].retail_price = $scope.getRetailPrice(prod);
        });
        $scope.selectedProjects[tmp.id] = tmp;
      });
      $scope.selectedProjectsTemp = [];
    };
    
    $scope.isApplied = function(item){
      if(typeof $scope.selectedProjects[item.id] !== 'undefined' || typeof $scope.selectedProjectsTemp[item.id] !== 'undefined'){
        return true;
      }else{
        return false;
      }
    };
    
    $scope.cleanProject = function(){
      $scope.project = [];
      $scope.selection = [];
    };
    $scope.projectCats = [];
    $scope.getProjectCategories = function () {
      if($scope.projectCats.length === 0){
        apiService.getProjectCategories().$promise.then(function (_response) {
          $scope.projectCats = _response;
        });
      }
    };
    
    $scope.getProjectDetails = function(item){
        $scope.selectedProject = item.project_group_id;
        $scope.selectedProjects[$scope.selectedProject] = item;
    };
    
    $scope.getAvailableProducts = function() {
        apiService.query().$promise.then(function(_response) {
            $scope.items = _response;
            $scope.productsLoaded = true;
        });
    };
    
    $scope.isItemSelected = function(item){
      if(typeof $scope.selectedProjects[$scope.selectedProject] === 'undefined'){
        return false;
      }
      var idx;
        idx = $scope.selectedProjects[$scope.selectedProject].pg_products.map(function (type) {
          return type.product_id;
        }).indexOf(item.product_id);
        if(idx > -1)
          return false;
        else
          return true;
    };
    
    
    $scope.addSelection = function(item) {
//      if($scope.selectedCustomer && parseInt($scope.selectedCustomer.margin_percent) > 0){
//        item.retail_price = item.cost_price * ((100 + parseInt($scope.selectedCustomer.margin_percent))/100);
//      }else{
//        item.retail_price = item.product_retail_price;
//      }
      item.retail_price = $scope.getRetailPrice(item);
      $scope.selectedProjects[$scope.selectedProject].pg_products.push(item);
    };
    
    $scope.removeSelection = function(item) {
      var idx;
      item.retail_price = item.product_retail_price;
      idx = $scope.selectedProjects[$scope.selectedProject].pg_products.map(function (type) {
        return type.id;
      }).indexOf(item.id);
      if (idx > -1) {
        $scope.selectedProjects[$scope.selectedProject].pg_products.splice(idx, 1);
//        $scope.items.push(item);
      }
    };
    
    $scope.resetProjects = function(){
      $scope.selectedProjectsTemp = [];
    };
    
    $scope.removeProject = function(item){
      delete $scope.selectedProjects[item.project_group_id];
      if($scope.selectedProject === item.project_group_id){
        $scope.selectedProject = null;
      }
    };
    
    $scope.selectCustomer = function (item) {
      $scope.selectedCustomer = item;
      if(item.id){
        $scope.contract.customer_id = item.id;
        $scope.newCustomer = null;
      }
      $scope.customerSelected = true;
    };
    
    $scope.confirmDelete = function(item){
      $scope.projectToDelete = item;
    };
    
    $scope.selectStatus = function(item) {
      $scope.selectedStatus = item;
    };
    $scope.endReasons = [];
    $scope.getEndReasons = function(){
      if($scope.endReasons.length === 0){
        apiService.getEndReasonItems().$promise.then(function(_response){
          $scope.endReasons = _response;
        });
      }
    };
    $scope.showDetails = true;
    $scope.customer.margin_percent = 0;
    $scope.newCustomer = null;
    $scope.prepareCustomer = function(customer){
      $scope.customerSubmitted = true;
      if(!$scope.frm_new_ustomer.$valid){
        $scope.showDetails = true;
        return false;
      }
      $scope.customer_name = customer.business_name;
      if(!$scope.customer_name){
        var middle_initial;
        if(typeof customer.middle_initial == 'undefined'){
          middle_initial = '';
        }else{
          middle_initial = customer.middle_initial;
        }
        $scope.customer_name =  customer.last_name+ ' '+ customer.first_name+ ' '+ middle_initial;
      }
      
      $scope.newCustomer = {'business_name': customer.business_name, 'first_name': customer.first_name, 'last_name': customer.last_name, 'middle_initial': middle_initial, 'business_account_nmbr': customer.business_account_nmbr, 'end_reason_item_code':customer.end_reason_item_code, 'end_reason_notes': customer.end_reason_notes, 'margin_percent': customer.margin_percent, 'start_date': moment(customer.start_date).format('YYYY-MM-DD'), 'end_date': moment(customer.end_date).format('YYYY-MM-DD'), 'status_item_code': customer.status_item_code, 
          addresses_attributes: [{'line_1': customer.line_1, 'line_2': customer.line_2, 'city': customer.city, 'state': customer.state, 'zip': customer.zip, 'is_primary': true}], 
          phones_attributes: [{'phone_number': customer.phone_number, 'is_primary': true}],
          contact_persons_attributes: [{'first_name': customer.first_name, 'last_name': customer.last_name, 'middle_initial': customer.middle_initial, 'email_address1': customer.email, 'phone_number1': customer.phone_number}]
      };
      $scope.selectedCustomer = {"id":0, "name":$scope.customer_name, "margin_percent":customer.margin_percent};
      $scope.contract.customer_id = 0;
      $scope.customerSelected = true;
      $scope.open($scope.selectedCustomer);
    };
    
    $scope.getProductCategories = function() {
      apiService.getProductCategories().$promise.then(function(_response) {
        $scope.productCats = _response;
      });
    };
    $scope.selectedFilterCat = null;
    $scope.selectedProjFilterCat = null;
    
    $scope.productFilterCat = function(item) {
      $scope.selectedFilterCat = item;
    };
    
    $scope.projectFilterCat = function(item) {
      $scope.selectedProjFilterCat = item;
    };
    
    $scope.filterProdutByCat = function(item) {
      return $scope.selectedFilterCat === null || item.category_item_code === $scope.selectedFilterCat.id;
    };
    
    $scope.filterProjectByCat = function(item) {
      return $scope.selectedProjFilterCat === null || item.category_item_code === $scope.selectedProjFilterCat.id;
    };
    
    $scope.getRetailPrice = function(product){
      if($scope.selectedCustomer && parseFloat($scope.selectedCustomer.margin_percent) > 0){
        return parseFloat(product.cost_price * ((100 + parseFloat($scope.selectedCustomer.margin_percent))/100)).toFixed(2);
      }else{
        return product.product_retail_price;
      }
    };
    
    /**
     * 
     * @param {type} contract modal
     * @returns {Boolean}
     */
    

  $scope.open = function (item) {
    if(isEmpty($scope.selectedProjects)){
      $scope.selectCustomer(item);
      return false;
    }
    $scope.selectCustomer(item);
    var modalInstance = $uibModal.open({
      animation: $scope.animationsEnabled,
      templateUrl: 'myModalContent.html',
      controller: 'ModalInstanceCtrl',
      size: 'md',
      resolve: {
        item: function () {
          return item;
        }
      }
    });

    modalInstance.result.then(function (selectedItem) {
      var retailPrice;
      angular.forEach($scope.selectedProjects, function (proj, pjKey) {
        angular.forEach(proj.pg_products, function (prod, pdKey) {
          retailPrice =  $scope.getRetailPrice(prod);
          console.log(retailPrice);
          $scope.selectedProjects[pjKey].pg_products[pdKey].retail_price = retailPrice;
        });
//          selectedProjects.push(tmp);
      });
    }, function () {
//      $log.info('Modal dismissed at: ' + new Date());
    });
  };
    
    $scope.createContract = function(contract){
      var customer_id = null;
      
      $scope.contractSubmitted = true;
      
      if(!$scope.frm_contract.$valid){
        return false;
      }
      
      if($scope.selectedCustomer){
        customer_id = $scope.selectedCustomer.id;
      }
      var project_groups_attributes = [];
      angular.forEach($scope.selectedProjects, function(tmp){
        project_groups_attributes.push(tmp);
      });

      var item = apiService.createContract({
        contract: {'job_number': contract.job_number, 'job_description': contract.job_description, 'job_long_description': contract.job_long_description,
          'proposal_date': moment(contract.proposal_date).format('YYYY-MM-DD'), 'customer_id': customer_id, 
          'approx_start_date': contract.approx_start_date, 'approx_completion_date': contract.approx_completion_date,
          'job_status_notes': contract.job_status_notes, 'start_date': moment(contract.start_date).format('YYYY-MM-DD'), 'completion_date': moment(contract.completion_date).format('YYYY-MM-DD'),
          'cp_proposal_terms_item_code': contract.cp_proposal_terms_item_code, 'cp_proposal_terms': contract.cp_proposal_terms, 
          'cp_payment_terms_item_code': contract.cp_payment_terms_item_code, 'cp_payment_terms': contract.cp_payment_terms, 
          'advance_payment': contract.advance_payment,
          'signed_by_lastname': contract.signed_by_lastname, 'signed_by_firstname': contract.signed_by_firstname, 'signed_by_mi': contract.signed_by_mi, 'signed_date': moment(contract.signed_date).format('YYYY-MM-DD'), 'prepared_by': contract.prepared_by,
          'status_item_code': $scope.selectedStatus.id}, 
        project_groups_attributes: project_groups_attributes, customer_attrubutes: $scope.newCustomer}, function success(response) {
        if( response.success === true && typeof response.redirect_url !== 'undefined'){
          var url = response.redirect_url;
          window.onbeforeunload = null;
          window.location.href =url;
        }else{
          alert('Error occurred. please try again!');
        }
      }, function err() {
        alert('Error occurred. please try again!');
      });
    };
    
    $scope.updateContract = function(contract){
      var customer_id = null;
      
      $scope.contractSubmitted = true;
      
      if(!$scope.frm_contract.$valid){
        return false;
      }
      if($scope.selectedCustomer){
        customer_id = $scope.selectedCustomer.id;
      }
      var project_groups_attributes = [];
      angular.forEach($scope.selectedProjects, function(tmp){
        project_groups_attributes.push(tmp);
      });
      
      var item = apiService.updateContract({'id': contract.id,
        contract: {'job_number': contract.job_number, 'job_description': contract.job_description, 'job_long_description': contract.job_long_description,
          'proposal_date': moment(contract.proposal_date).format('YYYY-MM-DD'), 'customer_id': customer_id, 
          'approx_start_date': contract.approx_start_date, 'approx_completion_date': contract.approx_completion_date,
          'job_status_notes': contract.job_status_notes, 'start_date': moment(contract.start_date).format('YYYY-MM-DD'), 'completion_date': moment(contract.completion_date).format('YYYY-MM-DD'),
          'cp_proposal_terms_item_code': contract.cp_proposal_terms_item_code, 'cp_proposal_terms': contract.cp_proposal_terms, 
          'cp_payment_terms_item_code': contract.cp_payment_terms_item_code, 'cp_payment_terms': contract.cp_payment_terms, 
          'advance_payment': contract.advance_payment,
          'signed_by_lastname': contract.signed_by_lastname, 'signed_by_firstname': contract.signed_by_firstname, 'signed_by_mi': contract.signed_by_mi, 'signed_date': moment(contract.signed_date).format('YYYY-MM-DD'),
          'status_item_code': $scope.selectedStatus.id},
        project_groups_attributes: project_groups_attributes, customer_attrubutes: $scope.newCustomer}, function success(response) {
        if( response.success === true && typeof response.redirect_url !== 'undefined'){
          var url = response.redirect_url;
          window.onbeforeunload = null;
          window.location.href =url;
        }else{
          alert('Error occurred. please try again!');
        }
      }, function err() {
        alert('Error occurred. please try again!');
      });
    };
    
    $scope.getContract = function(id) {
      apiService.getContract({id:id}).$promise.then(function(_response) {
        var proposal_date = _response.contract.proposal_date;
        var start_date = _response.contract.start_date;
        var completion_date = _response.contract.completion_date;
        var signed_date = _response.contract.signed_date;
        var dateArray;
        if(proposal_date){
          dateArray = proposal_date.split('-');
          _response.contract.proposal_date = new Date(dateArray[0], dateArray[1]-1, dateArray[2]);
        }
        if(signed_date){
          dateArray = signed_date.split('-');
          _response.contract.signed_date = new Date(dateArray[0], dateArray[1]-1, dateArray[2]);
        }
        if(start_date){
          dateArray = start_date.split('-');
          _response.contract.start_date = new Date(dateArray[0], dateArray[1]-1, dateArray[2]);
        }
        if(completion_date){
          dateArray = completion_date.split('-');
          _response.contract.completion_date = new Date(dateArray[0], dateArray[1]-1, dateArray[2]);
        }
        $scope.contract = _response.contract;
        $scope.selectStatus({id: _response.contract.status_item_code, description: _response.contract.status});
        $scope.selectCustomer({'id':_response.contract.customer_id, 'name': _response.contract.customer, "margin_percent":_response.contract.margin_percent});
        $scope.existingProjectIds = [];
        angular.forEach(_response.cp_project_groups, function(project){
          $scope.selectedProjects[project.project_group_id] = project;
          $scope.existingProjectIds.push(project.project_group_id);
        });
        $scope.getCustomers();
      });
    };
    
  }]);


app.controller('ModalInstanceCtrl', function ($scope, $uibModalInstance, item) {

  $scope.customer = item;

  $scope.yes = function () {
    $uibModalInstance.close($scope.customer);
  };

  $scope.no = function () {
    $uibModalInstance.dismiss('cancel');
  };
});
  
  app.filter('totalQty', function(){
  return function(array){
    var total = 0;
    angular.forEach(array, function(value, index){
       if(!isNaN(value.quantity))
        total = total + parseInt(value.quantity);
    })
    return total;
  }
})
  
  app.filter('totalRtlPrice', function(){
  return function(array){
    var total = 0;
    angular.forEach(array, function(value, index){
       if(!isNaN(value.retail_price))
        total = total + parseFloat(value.retail_price);
    })
    return total.toFixed(2);
  }
})
  
  app.filter('totalLaborHrs', function(){
  return function(array){
    var total = 0;
    angular.forEach(array, function(value, index){
       if(!isNaN(value.labor_hours))
        total = total + parseInt(value.labor_hours);
    })
    return total
  }
})

app.filter('totalAmount', function(){
  return function(item){
    var total = (item.retail_price*item.quantity +(item.labor_cost*item.labor_hours)) || 0;
    item.totalAmount = total;
    return total.toFixed(2);
  };
});
  
  app.filter('totalProjectAmount', function(){
  return function(array){
    var total = 0;
    angular.forEach(array, function(value, index){
        total = total + value.totalAmount;
    });
    return total.toFixed(2);
  };
});

app.filter('cut', function () {
        return function (value, wordwise, max, tail) {
            if (!value) return '';

            max = parseInt(max, 10);
            if (!max) return value;
            if (value.length <= max) return value;

            value = value.substr(0, max);
            if (wordwise) {
                var lastspace = value.lastIndexOf(' ');
                if (lastspace != -1) {
                  //Also remove . and , so its gives a cleaner result.
                  if (value.charAt(lastspace-1) == '.' || value.charAt(lastspace-1) == ',') {
                    lastspace = lastspace - 1;
                  }
                  value = value.substr(0, lastspace);
                }
            }

            return value + (tail || ' …');
        };
    });
  
//app.filter('toMoney', function(){
//  return function(val){
//    if(!isNaN(val))
//      val = parseFloat(val)/100;
//    return val.toFixed(2);
//  }
//});



app.constant('convertMoney', 100);

function isEmpty(obj) { 
   for (var x in obj) { return false; }
   return true;
}