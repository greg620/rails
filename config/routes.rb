Rails.application.routes.draw do
  get '/', to: 'home#index', as: :home

  get '/blog/:slug-:id', to: 'articles#show', as: :article

  match "/login", to: 'user#login', as: 'login_user', via: [:get, :post]
  get '/logout', to: 'user#logout', as: 'logout_user'
  get '/register', to: 'user#new', as: 'new_user'
  post '/register', to: 'user#create'

  get '/draft', to: 'articles#index', as: :articles
  get '/draft/new', to: 'articles#new', as: :new_article
  post '/draft/new', to: 'articles#create'

  get '/draft/:id/edit', to: 'articles#edit', as: :edit_article
  patch '/draft/:id/edit', to: 'articles#update'
  get '/draft/:id/delete', to: 'articles#delete', as: :delete_article
end
