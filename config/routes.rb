Geoactions::Application.routes.draw do
  resources :transactions, only: [:index, :show]
  root controller: :transactions, action: :index
end
