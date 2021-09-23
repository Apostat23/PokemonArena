Rails.application.routes.draw do
  root 'start#index'
  get 'start/_menu'
  get 'start/_top'
  get 'start/_bottom'
  get 'start/pokemon'
  patch 'start/pokemon'
  devise_for :users
  resources :players
  resources :pokemons
  namespace :api do
    namespace :v1 do
      resources :pokemons
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
