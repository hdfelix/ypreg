YpwReg::Application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'dashboard/index'

  delete 'events/:event_id/hospitalities/destroy', to: 'events/hospitalities#destroy', as: :hospitality_remove

  resources :locations
  resources :localities
  resources :lodgings
  resources :events do
    resources :hospitalities, only: [:index, :new, :create], controller: 'events/hospitalities' do
      collection do
        post 'add'
        put 'remove'
      end
    end
    resources :hospitality_locality_assignments, only: [:index], controller: 'events/hospitality_locality_assignments', action: 'assign' do
      collection do
        put 'assign'
        post 'assign\*locality'
      end
    end
    resources :hospitality_registration_assignments, only: [:index, :show], controller: 'events/hospitality_registration_assignments' do
      collection do
        put 'assign'
        post 'assign'
      end
    end
    # resources :hospitality_assignments, only: [:index], controller: 'events/hospitality_assignments' do
    #   collection do
    #     get 'assign'
    #   end
    # end
    resources :registrations, except: [:index], controller: 'events/registrations'
    resources :hospitality_lodgings, only: [:index], controller: 'events/hospitality_lodgings'
  end
  devise_for :user, controllers: { registrations: 'users/registrations' }
end
