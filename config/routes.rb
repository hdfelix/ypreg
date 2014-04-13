YpwReg::Application.routes.draw do
  get "home/index"

	resources :locations
	resources :events

  #get "login/index"
  # See how all your routes lay out with "rake routes".

	root 'home#index'

end
