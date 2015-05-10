Rails.application.routes.draw do
  resources :candidates
  resources :ridings

  root 'summary#index'

  get 'summary' => 'summary#index'
  get 'summary/data', :defaults => { :format => 'json' }

  get 'riding_summary/data/:riding_id' => 'riding_summary#data', :defaults => { :format => 'json' }
  get 'riding_summary/:riding_id' => 'riding_summary#view'

end
