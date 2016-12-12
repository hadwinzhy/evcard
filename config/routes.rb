Rails.application.routes.draw do

  devise_for :users, at: 'auth', skip: [:omniauth_callbacks], controllers: { sessions: 'auth/sessions' }

  #################### V1 (default) ##################

  api_version(:module => "V1", :header => {:name => "Accept", :value => "version=1"}, default: true) do
    resources :users
  end

  #################### V2 ##################

  api_version(:module => "V2", :header => {:name => "Accept", :value => "version=2"}) do
    # resources :users
  end

end
