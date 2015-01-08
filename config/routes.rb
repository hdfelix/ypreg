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
    resources :hospitality_locality_assignments, only: [:index], controller: 'events/hospitality_locality_assignments' do
      collection do
        put 'assign'
        post 'assign'
        # post 'assign\*locality', action: 'assign'
      end
    end
    resources :hospitality_registration_assignments, only: [:index, :show], controller: 'events/hospitality_registration_assignments' do
      collection do
        put 'assign'
        post 'assign'
      end
    end
    resources :registrations, except: [:index], controller: 'events/registrations'
    resources :hospitality_lodgings, only: [:index], controller: 'events/hospitality_lodgings'
  end
  devise_for :user, except: [:destroy], controllers: { registrations: 'users/registrations' } do
  end
  devise_scope :user do
    get '/users', to: 'users/registrations#index', as: 'users'
  end
end
