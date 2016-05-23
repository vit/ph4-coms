Rails.application.routes.draw do

  resources :submission_revisions
#  scope '/admin' do
    resources :contexts do
      resources :submissions, shallow: true
      resources :ce_submissions, only: [:index, :show, :update], shallow: true
      resources :r_submissions, only: [:index, :show, :update], shallow: true
      resources :adm, only: [:index] #, shallow: true
      resources :context_appointments, only: [:index, :create, :destroy], shallow: true
    end
    resources :conferences
    resources :journals
    resources :submission_files
#  end



#  root 'home#index'
  root 'contexts#index'

  devise_for :users
    get "/u/:id" => redirect(Rails.configuration.x.sites.my + "/u/%{id}"), as: 'u'
#  resources :u, :controller=>"users", only: [:show] do
#    collection do
#      get 'user_widget'
#    end
#  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
