Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :players
  resources :teams
  resources :games
  resources :runs
  resources :images
  resources :videos

  get '/players/:id/player_card' => 'players#player_card'
  get '/players/:id/videos' => 'players#videos'
  get '/players/:id/images' => 'players#images'
  get '/players/:id/highlights' => 'players#highlights'
end
