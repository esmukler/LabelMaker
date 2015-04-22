Rails.application.routes.draw do

  root 'labels#new'

  resources :labels

end
