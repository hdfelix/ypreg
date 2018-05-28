# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'dashboard/index'

  delete 'events/:event_id/hospitalities/destroy',
         to: 'events/hospitalities#destroy',
         as: :hospitality_remove

  get 'events/:event_id/edit_locality_payments',
      to: 'events#edit_locality_payments',
      controller: 'events',
      as: :edit_locality_payments

  put 'event/:event_id/update_locality_payments',
      to: 'events#update_locality_payments',
      controller: 'events',
      as: :update_locality_payments

  resources :locations
  resources :localities
  resources :lodgings
  resources :events do
    resources :copies, only: [:new, :create,:show],
              controller: 'events/copies'
    resources :localities,
              only: [:index, :show, :new, :create],
              controller: 'events/localities'
    resources :hospitalities,
              only: [:index, :new, :create],
              controller: 'events/hospitalities' do
      collection do
        post 'add'
        put 'remove'
      end
    end
    resources :hospitality_locality_assignments,
              only: [:index],
              controller: 'events/hospitality_locality_assignments' do
      collection do
        put 'assign'
        post 'assign'
      end
    end
    resources :hospitality_registration_assignments,
              param: :locality_id,
              only: [:index, :show],
              controller: 'events/hospitality_registration_assignments' do
      collection do
        put 'assign'
        post 'assign'
      end
    end
    resources :hospitality_lodgings,
              only: [:index],
              controller: 'events/hospitality_lodgings'
    resources :registrations, controller: 'events/registrations'
  end

  # http://stackoverflow.com/a/22158715
  devise_for :users,
             path_names: { edit: 'edit' },
             except: [:destroy],
             controllers: { registrations: 'users/registrations',
                            passwords: 'users/passwords',
                            confirmations: 'users/confirmations' } do
  end

  devise_scope :user do
    get '/users', to: 'users/registrations#index', as: 'users'
    get '/user/:id', to: 'users/registrations#show', as: 'user'
  end
end
