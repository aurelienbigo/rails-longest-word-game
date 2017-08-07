Rails.application.routes.draw do

  get 'score', to: 'pages#score'

  get 'game', to: 'pages#game'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
