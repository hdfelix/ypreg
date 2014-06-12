YpwReg::Application.routes.draw do

  get "welcome/index"
  devise_for :users
  get "dashboard/index"

	resources :locations
	resources :events
	resources :registrations, only: [:index, :new, :create]

  #get "login/index"
  # See how all your routes lay out with "rake routes".

	root 'welcome#index'

end
