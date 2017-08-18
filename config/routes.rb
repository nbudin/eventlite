Rails.application.routes.draw do
  devise_for :users

  resources :events do
    get 'admin' => 'admin#index'
    resources :cms_files, only: [:index, :create, :destroy]
    resources :cms_layouts
    resources :navigation_items do
      collection do
        patch :sort
      end
    end
    resources :ticket_types do
      member do
        get 'preview_email' => 'ticket_types#preview_email_form'
        post :preview_email
      end
    end
    resources :tickets
    resources :ticket_charges, only: [:create]

    nested do
      cadmus_pages
    end
  end

  get 'admin' => 'admin#index'
  cadmus_pages
  resources :cms_files, only: [:index, :create, :destroy]
  resources :cms_layouts
  resources :navigation_items do
    collection do
      patch :sort
    end
  end
  resource :site_settings

  root to: 'root#index'
end
