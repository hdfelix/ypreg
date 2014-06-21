YpwReg::Application.routes.draw do
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

	resources :locations
	resources :events do
		resources :registrations, only: [:index, :new, :create]
	end

  devise_for :user, controllers: { registrations: "users/registrations" }
end
