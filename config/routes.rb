YpwReg::Application.routes.draw do
  get "registrations/index"
  get "registration/index"
  get "welcome/index"
  devise_for :users
  get "home/index"

	resources :locations
	resources :events
	resources :registrations, only: [:index]

  #get "login/index"
  # See how all your routes lay out with "rake routes".

	root 'welcome#index'

end
