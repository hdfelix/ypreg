YpwReg::Application.routes.draw do

  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  resources :locations
  resources :localities
  resources :lodgings

  delete 'events/:event_id/lodgings/destroy',
         to: 'events/lodgings#destroy',
         as: :event_lodging_remove

  get 'events/:event_id/edit_locality_payments',
      to: 'events#edit_locality_payments',
      controller: 'events',
      as: :edit_locality_payments

  put 'event/:event_id/update_locality_payments',
      to: 'events#update_locality_payments',
      controller: 'events',
      as: :update_locality_payments

  resources :events do
    resources :registrations, controller: 'events/registrations'
    resources :copies, only: [:new, :create, :show],
              controller: 'events/copies'
    resources :localities, 
              only: [:show, :new, :create, :destroy],
              controller: 'events/localities' do
                collection do
                  get 'add'
                end
              end
    resources :lodgings,
              only: [:show, :create, :destroy],
              controller: 'events/lodgings' do
                collection do
                  get 'add'
                end
              end
  end

  # http://stackoverflow.com/a/22158715
  devise_for :users,
             #path_names: { edit: 'edit' },
             except: [:destroy],
             controllers: { registrations: 'users/registrations',
                            passwords: 'users/passwords',
                            confirmations: 'users/confirmations' } do
  end

  devise_scope :user do
    get '/users', to: 'users/registrations#index', as: 'users'
    get '/user/:id', to: 'users/registrations#show', as: 'user'
  end

  namespace :admin do
    resources :users, only: [:new, :create, :update, :destroy]
  end

end
