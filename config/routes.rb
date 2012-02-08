Jedict::Application.routes.draw do
  root :to => 'glossaries#index'
  resources :glossaries, :only=>:index
end
