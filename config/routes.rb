Rails.application.routes.draw do
  root 'pages#index'
  # devise_for :users, controllers: { registrations: 'registrations' }
  namespace :api do
    namespace :v1 do
      resources :students do
        resources :student_companies
      end

      resources :cash_management_tables
      resources :companies
      resources :cash_in_histories
      resources :cash_out_histories
      get 'home', to: 'home#index'
      post 'auth_user', to: 'authentication#authenticate_user'

      devise_for :users, controllers: { registrations: 'registrations' , sessions: 'sessions'}

      post '/sign_in' , to:'users#login'
      get '/auto_login' => 'users#auto_login'
      get '/get_company_details' => 'student_companies#get_company_details'
    end
    namespace :v2 do
      # Things yet to come
    end
  end  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
