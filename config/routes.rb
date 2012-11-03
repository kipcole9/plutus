Plutus::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  # omniauth client stuff
  post '/auth/:provider/callback',  :to => 'authentications#create'
  post '/auth/failure',             :to => 'authentications#failure'

  # Provider stuff
  post '/auth/plutus/authorize'     => 'auth#authorize'
  post '/auth/plutus/access_token'  => 'auth#access_token'
  post '/auth/plutus/user'          => 'auth#user'
  post '/oauth/token'               => 'auth#access_token'

  # Account linking
  post 'authentications/:user_id/link'  => 'authentications#link',  :as => :link_accounts
  post 'authentications/:user_id/add'   => 'authentications#add',   :as => :add_account

  root :to => 'auth#welcome'
end
