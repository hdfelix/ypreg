YpwReg::Application.routes.draw do
  get "hospitality/index"
  get "hospitality/show"
  get "hospitality/new"
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

	resources :locations
	resources :localities
	resources :hospitalities
	resources :events do
		resources :registrations, only: [:index, :new, :create]
		#resources :hospitalities, except: [:index, :new, :create]
	end

  devise_for :user, controllers: { registrations: "users/registrations" }

	#if Rails.env.development?
	#	mount LetterOpenerWeb::Engine, at: '/letter_opener'
	#end
end
