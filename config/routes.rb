Rails.application.routes.draw do

  root 'labels#new'

  resources :labels, only: [:index, :show, :new, :create]

end
