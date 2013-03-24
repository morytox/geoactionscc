Geoactions::Application.routes.draw do
  resources :transactions, only: [:index]
  root controller: :transactions, action: :index
end
