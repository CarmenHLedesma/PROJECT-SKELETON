
Rails.application.routes.draw do

  require "resque_web"

  mount ResqueWeb::Engine => "/resque_web"

  devise_for :users, :controllers => {:registrations => "administracion/registrations"}

  unauthenticated :user do
    root to: redirect('/users/sign_in')
  end

  authenticated :user do

    root to: "users#index", as: :inicio_root


    resources :users

    # /comentarios/35/ImputacionActividad
    get '/comentarios/:comentable_id/:comentable_type', to: 'comentarios#index', as: 'comentarios'
    resources :comentarios, only: [] do
      post '/:comentable_id/:comentable_type', to: 'comentarios#create', on: :collection #create
      get '/:comentable_id/:comentable_type', to: 'comentarios#edit', on: :member, as: :edit #edit
      put :update, on: :member, as: :update #update
      patch :update, on: :member #update
      delete :destroy, on: :member #delete
    end

    devise_scope :user do
      put "/users/:id/reactivate" => "administracion/registrations#reactivate", as: :reactivate_user_registration
    end

  end

end
