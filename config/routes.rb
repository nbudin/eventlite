Rails.application.routes.draw do
  devise_for :users

  resources :events do
    get 'admin' => 'admin#index'
    resources :cms_files, only: [:index, :create, :destroy]
    resources :navigation_items do
      collection do
        patch :sort
      end
    end

    nested do
      cadmus_pages
    end
  end

  root to: 'events#index'
end
