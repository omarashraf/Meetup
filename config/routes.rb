Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/index'

  get 'posts/edit'

  get 'posts/delete'

  get 'posts/show/:id' => 'posts#show', as: 'post_show'

  get 'events/index'

  get 'events/new'

  get 'events/edit'

  get 'events/delete'

  get 'events/show/:id' => 'events#show', as: 'event_show'

  get 'communities/index'

  get 'communities/show/:id' => 'communities#show', as: 'community_show'

  get 'communities/delete'

  get 'communities/edit'

  get 'communities/new'

  get 'profiles/index'

  get 'users/index'

  get 'users/new'

  get 'users/delete'

  get 'users/edit'

  get 'users/show/:id' => 'users#show', as: 'user_show'

  post 'communities/show/:id' => 'communities#show'

  post 'events/show/:id' => 'events#show'

  post 'posts/show/:id' => 'posts#show'

  post 'communities/:community_id/posts/:id' => 'posts#show'

  post 'events/:event_id/posts/:id' => 'posts#show'

  post 'users/show/:id' => 'users#show'

  resources :communities do
    resources :posts
  end
  
  get 'communities/:community_id/posts/:id' => 'posts#show', as: 'communities_post'

  resources :events do
    resources :posts
  end

  get 'events/:community_id/posts/:id' => 'posts#show', as: 'events_post'

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
