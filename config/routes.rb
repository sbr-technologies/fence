Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations', confirmations: 'confirmations'}

  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
    get 'unique_business_name' => 'registrations#unique_business_name'
    get 'unique_admin_email' => 'registrations#unique_admin_email'
  end
namespace :api, defaults: {format: 'json'}  do
    namespace :v1 do
      resources :pg_products
      resources :suppliers do
        collection do
          post :destroy_multiple
          post :validate
        end
        put :update_field
      end
      resources :employees do
        collection do
          post :destroy_multiple
          post :validate
        end
        put :update_field
      end
      resources :manufacturers do
        collection do
          post :destroy_multiple
          get :status_items
          post :validate
        end
        put :update_field
      end
      resources :project_groups do
        collection do
          post :destroy_multiple
          get :category_items
          get :pg_products
          get :status_items
        end
        put :update_field
      end
      resources :products do
        collection do
          post :destroy_multiple
          get :category_items
          get :status_items
          get :uom_items
          post :validate
        end
        put :update_field
      end
      resources :contract_proposals do
        collection do
          post :destroy_multiple, :validate_job_number
          get :status_items
        end
        put :update_field
      end
      resources :customers do
        collection do
          get :index_names_only
          get :end_reason_items
          post :validate_business
          post :destroy_multiple
        end
        put :update_field
      end
      resources :lookup_item_codes
end
end

  resources :business, only: [:edit, :update] do
    member do
      get :default_proposal_terms
      match :lookup_values, via: [:get, :patch]
    end
    resources :pdf do
      collection do
        get 'header' => 'pdf#header', as: :header
        get 'name' => 'pdf#name', as: :name
        get 'project_footer' => 'pdf#footer', as: :project_footer
      end
    end
    resources :lookup_items do
      collection do
        get :unique_name
      end
    end
    resources :products
    resources :suppliers do
      collection do
        get :print_multiple
      end
	end
    resources :employees
    resources :customers
    resources :manufacturers
    resources :contract_proposals do
      collection do
        get :print_multiple
      end
    end
    resources :project_groups do
      collection do
        get :print_multiple
      end
    end
    
    namespace :reporting do
        resources :contract_proposals, only: [:index, :show] do
          collection do
            get :print_list
            get :print_details
          end
        end
    end
  end

  root 'products#dashboard'
end
