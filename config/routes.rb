YpwReg::Application.routes.draw do
  get "hospitality/index"
  get "hospitality/show"
  get "hospitality/new"
	root 'welcome#index'

  get "welcome/index"
  get "dashboard/index"

  get 'events/:event_id/hospitalities/assign', to: 'events/hospitalities#assign', as: :hospitality_assign
  post 'events/:event_id/hospitalities/assigns', to: 'events/hospitalities#assigns', as: :hospitality_assigns

	resources :locations
	resources :localities
	resources :hospitalities
	resources :events do
		resources :registrations, except: [:index], controller: 'events/registrations'  #, only:  [:index, :new, :create]
	end

  devise_for :user, controllers: { registrations: "users/registrations" }

	#if Rails.env.development?
	#	mount LetterOpenerWeb::Engine, at: '/letter_opener'
	#end
end
