Rottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  match '/movies/:id/related', to: 'movies#related', as: :related, via: [:get, :post]
end
