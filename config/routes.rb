Rails.application.routes.draw do
  
  root to: "homepages#index"

  resources :works
  
#   resources :passengers do
#     resources :trips, only: [:create]
#   end
  
#   resources :trips, except: [:index, :new, :create]
#   patch '/trips/:id/complete_trip', to: 'trips#complete_trip', as: 'complete_trip'
# end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
