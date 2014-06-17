YpwReg::Application.routes.draw do
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

  devise_for :users, controllers: { registrations: "users/registrations" }
	devise_scope :users do
		  get "sign_in", to: "users/sessions#new"
			get "sign_up", to: "users/registrations#new.user"
	end
	resources :locations
	resources :events

	resources :registrations, only: [:index, :new, :create]
end
