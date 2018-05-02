Rails.application.routes.draw do
  



  root 'static_pages#home'


get 'provider/dashboard/panelist', to: 'provider/dashboard#panelist', as: 'provider_panelist'
get 'provider/dashboard/panelist/view_enrolee/:enrolee_id', to: 'provider/dashboard#view_provider_enrolee', as: 'view_provider_enrolee'


get 'enrolees/:enrolee_id/show_dependants_group', to: 'insurer/enrolees#show_dependants', as: 'show_dependants_group'

namespace :provider do 

  resources :claims do 
    member do 
        get 'addService'
        get 'preview'
        get 'submit'
    end
  end
end
  
  get 'provider/enrolees/panelist', to: 'provider#enrolees', as: 'provider_enrolees'
  get 'insurer/enrolees/quicksearch', to: 'insurer/enrolees#quicksearch', as: 'insurer_enrolees_quicksearch'
  get 'insurer/enrolees/data_upload', to: 'insurer/enrolees#data_upload', as: 'insurer_enrolees_data_upload'
  get 'insurer/dependants/data_upload', to: 'insurer/dependants#data_upload', as: 'insurer_dependants_data_upload'
  post 'insurer/enrolees/populatedb', to: 'insurer/enrolees#populatedb', as: 'insurer_enrolees_populatedb'
  post 'insurer/dependants/populatedb', to: 'insurer/dependants#populatedb', as: 'insurer_dependants_populatedb'

namespace :insurer do 
  resources :enrolees do 
    member do 
      get 'addDependant'
      get 'preview'
    end

  end
  resources :plans
  resources :companies
  resources :dependants
  resources :claims do
    member do  
      get 'addService'
      get 'submit'
      get 'preview'
      get 'vet'
      post 'submit_vetted'
      get 'invoice_generation'
    end
  end
end


  resources :services
  
  devise_for :providers, path: 'providers', controllers: {sessions: 'providers/sessions', registrations: 'providers/registrations'}
  devise_for :insurers, path: 'insurers', controllers: { sessions: 'insurers/sessions', registrations: 'insurers/registrations'}


  #static pages routes
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/contact'

  get 'claims/invoice/generate_pdf', to: 'insurer/claims#generate_invoice', as: 'generate_claim_invoice_pdf'



  # Avatar routes
get "avatar/:size/:background/:text" => Dragonfly.app.endpoint { |params, app|
  app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
}, as: :avatar



  #dashboard pages

  get 'insurer/dashboard/index', to: 'insurer/dashboard#index', as: 'insurer_dashboard'

  get 'provider/dashboard/index', to: 'provider/dashboard#index', as: 'provider_dashboard'
    
  get 'static_pages/dashboard', to: 'static_pages#dashboard', as: 'dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
