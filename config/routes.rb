Rails.application.routes.draw do
  get 'weather', to: 'weathers#index'
  post 'weather', to: 'weathers#show'
end
