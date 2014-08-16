YpwReg::Application.routes.draw do
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

  get 'events/:event_id/hospitalities/assign', to: 'events/hospitalities#assign', as: :hospitality_assign
  post 'events/:event_id/hospitalities/assigns', to: 'events/hospitalities#assigns', as: :hospitality_assigns
  delete 'events/:event_id/hospitalities/destroy', to: 'events/hospitalities#destroy', as: :hospitality_remove

	resources :locations
	resources :localities
  resources :lodgings
	resources :hospitalities
	resources :events do
		resources :registrations, except: [:index], controller: 'events/registrations'  #, only:  [:index, :new, :create]
	end

  devise_for :user, controllers: { registrations: "users/registrations" }

	#if Rails.env.development?
	#	mount LetterOpenerWeb::Engine, at: '/letter_opener'
	#end
end
