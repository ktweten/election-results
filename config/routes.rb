Rails.application.routes.draw do
  resources :candidates
  resources :ridings

  root 'summary#index'

  get 'summary' => 'summary#index'

  get 'riding/data/:id' => 'ridings#data', :defaults => { :format => 'json' }
  get 'riding/:id' => 'ridings#show'

end
