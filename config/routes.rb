Rails.application.routes.draw do
  devise_for :users

  resources :events do
    get 'admin' => 'admin#index'
    resources :cms_files

    nested do
      cadmus_pages
    end
  end

  root to: 'events#index'
end
