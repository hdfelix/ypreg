YpwReg::Application.routes.draw do
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

  devise_for :users
	resources :locations
	resources :events
	resources :registrations, only: [:index, :new, :create]
end
