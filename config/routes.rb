Rails.application.routes.draw do
  # get 'home/index'
  root 'home#index'
  get '/next_generation/:id', to: 'home#next_generation', defaults: { format: 'json'}
  get '/update_world/:id', to: 'home#update_world', defaults: { format: 'json'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
