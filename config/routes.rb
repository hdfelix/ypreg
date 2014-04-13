YpwReg::Application.routes.draw do
  get "welcome/index"
  devise_for :users
  get "home/index"

	resources :locations
	resources :events

  #get "login/index"
  # See how all your routes lay out with "rake routes".

	root 'welcome#index'

end
