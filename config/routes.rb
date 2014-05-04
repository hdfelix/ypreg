YpwReg::Application.routes.draw do
  
  devise_for :users
  get "home/index"

	resources :locations
	resources :events
	resources :registrations, only: [:index]

	get "welcome/index"

  #get "login/index"
  # See how all your routes lay out with "rake routes".

	root 'welcome#index'

end
