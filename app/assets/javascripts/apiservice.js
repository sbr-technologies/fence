
angular.module('projbuilderApp')
        .factory('apiService', ['$resource', function ($resource) {
                
                return $resource('/api/v1/products', {
                    id: '@id'
                }, {
                    getProjectStatusItems: {url: '/api/v1/project_groups/status_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    get: {method: 'GET', cache: false, isArray: false},
                    getProjects: {url: '/api/v1/project_groups', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getPgProducts: {url: '/api/v1/pg_products', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getProject: {url: '/api/v1/project_groups/:id/edit', method: 'GET', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getProjectCategories: {url: '/api/v1/project_groups/category_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getProductCategories: {url: '/api/v1/products/category_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    save: {method: 'POST', cache: false, isArray: false, headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}},
                    createProject: {url: '/api/v1/project_groups', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    updateProjectField: {url: '/api/v1/project_groups/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    updateProject: {url: '/api/v1/project_groups/:id', method: 'PUT', cache: false, isArray: false, 
                      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    delete: {method: 'DELETE', cache: false, isArray: false},
                    deleteProjects: {url: '/api/v1/project_groups/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },

                    /**
                     * Suppliers related api services
                    */
                    getSuppliers: {url: '/api/v1/suppliers', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateSupplierField: {url: '/api/v1/suppliers/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    deleteSuppliers: {url: '/api/v1/suppliers/destroy_multiple', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    }, 
                    /**
                     * Customers related api services
                     */
                    
                    getCustomers: {url: '/api/v1/customers', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateCustomerField: {url: '/api/v1/customers/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    deleteCustomers: {url: '/api/v1/customers/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },                    
                    /**
                     * Employee related api services
                     */
                    deleteEmployees: {url: '/api/v1/employees/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    
                    getEmployees: {url: '/api/v1/employees', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateEmployeeField: {url: '/api/v1/employees/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    validateEmployee: {url: '/api/v1/employees/validate', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    /**
                     * Products related api services
                     */
                    deleteProducts: {url: '/api/v1/products/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    
                    getProducts: {url: '/api/v1/products', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateProductField: {url: '/api/v1/products/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    validateProduct: {url: '/api/v1/products/validate', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    /**
                     * Manufacturers related api services
                     */
                    deleteManufacturers: {url: '/api/v1/manufacturers/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    
                    getManufacturerStatusItems: {url: '/api/v1/manufacturers/status_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getManufacturers: {url: '/api/v1/manufacturers', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateManufacturerField: {url: '/api/v1/manufacturers/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    validateManufacturerAccNo: {url: '/api/v1/manufacturers/validate', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    /**
                     * Contracts related api services
                    */
                    getProposalStatusItems: {url: '/api/v1/contract_proposals/status_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getContracts: {url: '/api/v1/contract_proposals', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    updateContractField: {url: '/api/v1/contract_proposals/:id/update_field', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    updateContract: {url: '/api/v1/contract_proposals/:id', method: 'PUT', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    deleteContracts: {url: '/api/v1/contract_proposals/destroy_multiple', method: 'POST', cache: false, isArray: false,
                    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    createCustomer: {url: '/api/v1/customers', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    getLookupItem: {url: '/api/v1/lookup_item_codes/:id', method: 'GET', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getCustomersName: {url: '/api/v1/customers/index_names_only', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getEndReasonItems: {url: '/api/v1/customers/end_reason_items', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    getProjectsName: {url: '/api/v1/project_groups/pg_products', method: 'GET', cache: false, isArray: true,
                        headers: {'Content-Type': 'application/json'}
                    },
                    createContract: {url: '/api/v1/contract_proposals', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
                    },
                    getContract: {url: '/api/v1/contract_proposals/:id/edit', method: 'GET', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    validateJobNumber: {url: '/api/v1/contract_proposals/validate_job_number', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    },
                    validateCustOrga: {url: '/api/v1/customers/validate_business', method: 'POST', cache: false, isArray: false,
                        headers: {'Content-Type': 'application/json'}
                    }
                });


            }]);