Radai::Application.routes.draw do

  # Shared domain routes
  get "taisykles" => "static#eula", as: "eula"
  get "privatumas" => "static#privacy", as: "privacy"
  get "atsiliepimai" => "feedback#leave", as: "feedback_leave"
  post "atsiliepimai" => "feedback#leave_submit", as: "feedback_leave_post"

  # Subdomains
  constraints subdomain: /statybos/ do
    get "paieska" => "search#index", as: "search"
    devise_for :users
    match "registracija-sekminga" => "specialist#create_complete"
    get "specialistas/naujas" => "specialist#new", as: "new_specialist"
    post "specialistas" => "specialist#create", as: "create_specialist"
    get "profilis" => "specialist#edit", as: "edit_specialist"
    put "profilis" => "specialist#update", as: "update_specialist"
    get "specialistas/:id/:title_slug" => "specialist#show", as: "specialist_slug"
    get "specialistas/:id" => "specialist#show", as: "specialist"
    put "ajax/address" => "specialist#ajax_address_search", as: "ajax_address_search"
    root to: "home#index"
  end

  constraints subdomain: "manage" do
    ActiveAdmin.routes(self)
    devise_for :admin_users, ActiveAdmin::Devise.config
  end

  constraints subdomain: false do
    root to: "index#list"
  end

  match '*path' => 'index#missing'

end
