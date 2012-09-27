Radai::Application.routes.draw do

  devise_for :users

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match "specialistas/registracija" => "specialist#create_complete"
  resources :specialist, path: "specialistas"
  # Need to remap the following route due to this bug:
  # https://github.com/rails/rails/issues/1769
  post "specialistas" => "specialist#create", as: "create_specialist"
  get "profilis" => "specialist#edit", as: "edit_specialist"
  put "profilis" => "specialist#update", as: "update_specialist"

  put "ajax/address" => "specialist#ajax_address_search", as: "ajax_address_search"

  root to: "home#index"

end
