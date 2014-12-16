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
        put 'remove'
        post 'add'
      end
    end
    resources :registrations, except: [:index], controller: 'events/registrations'
    resources :hospitality_assignments, only: [:index], controller: 'events/hospitality_assignments'
    resources :hospitality_lodgings, only: [:index], controller: 'events/hospitality_lodgings'
  end

  devise_for :user, controllers: { registrations: 'users/registrations' }
end
