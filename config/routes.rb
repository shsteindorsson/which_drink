Rails.application.routes.draw do
  get 'drinks/index'

  root 'drinks#index'
end
