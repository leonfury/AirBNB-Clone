    Rails.application.routes.draw do
  
    resources :passwords, controller: "clearance/passwords", only: [:create, :new]
    resource :session, controller: "clearance/sessions", only: [:create]

    resources :users, only: [:create] do
        resource :password,
        controller: "clearance/passwords",
        only: [:create, :edit, :update]
    end

    resources :users #creates routes
    resources :listings

    resources :listings, only: [:show] do
       resources :bookings, only: [:create]
    end

    resources :bookings, except: [:new, :create, :edit, :update, :delete]
    
    #####################################################
    root "listings#index"
    post "/verify_listing/:id" => "listings#verify", as: "verify_listing"

    get "/sign_in" => "clearance/sessions#new", as: "sign_in"
    delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
    get "/sign_up" => "clearance/users#new", as: "sign_up"

    # for google authorization
    get "/auth/:provider/callback" => "sessions#create_from_omniauth"

    #for braintree
    get '/bookings/:booking_id/payment' => 'braintree#new', as: "payment"
    post '/bookings/:booking_id/payment' => 'braintree#create', as: "payment_create"
    get '/bookings/:booking_id/payment/:result_id' => 'braintree#show', as: "payment_result"

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
