YpwReg::Application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'dashboard/index'

  resources :events do
    get 'hospitalities/assign',
      to: 'events/hospitalities#assign',
      as: :hospitality_assign

    post 'hospitalities/assigns',
      to: 'events/hospitalities#assigns',
      as: :hospitality_assigns

    post 'hospitality_assignments/assign_lodging_to_locality',
      to: 'events/hospitality_assignments#assign_lodging_to_locality',
      as: :hospitality_assignment_for_locality

    post 'hospitality_assignments/unassign_lodging_from_locality',
      to: 'events/hospitality_assignments#unassign_lodging_from_locality',
      as: :hospitality_unassignment_for_locality
  end

  delete 'events/:event_id/hospitalities/destroy', to: 'events/hospitalities#destroy', as: :hospitality_remove

  resources :locations
  resources :localities
  resources :lodgings
  resources :hospitalities
  resources :events do
    resources :registrations, except: [:index], controller: 'events/registrations'
    resources :hospitality_assignments, only: [:index], controller: 'events/hospitality_assignments'
  end

  devise_for :user, controllers: { registrations: 'users/registrations' }
end
