YpwReg::Application.routes.draw do
  get "hospitality/index"
  get "hospitality/show"
  get "hospitality/new"
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

	resources :locations
	resources :localities
	resources :hospitalities, only: :index
	resources :events do
		resources :registrations, only: [:index, :new, :create]
		resources :hospitalities, except: [:index]
	end

  devise_for :user, controllers: { registrations: "users/registrations" }
end
