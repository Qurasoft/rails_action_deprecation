Rails.application.routes.draw do
  resources :clean
  resources :deprecation
  resources :mixed
  resources :sunset
end
