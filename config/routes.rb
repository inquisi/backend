Backend::Application.routes.draw do
  post    'login'                   => 'users#login'
  post    'logout'                  => 'users#logout'
  post    'signup'                  => 'users#signup'
  get     'user'                    => 'users#show'               #Individual User
  #delete account ?? Not needed now
  delete  'user/:id'                => 'users#delete'

  post    'courses'                 => 'courses#create'
  get     'courses'                 => 'courses#index'
  get     'courses/:id'             => 'courses#show'             #Indivudual course
  put     'courses/:id'             => 'courses#update'       
  delete  'courses/:id'             => 'courses#delete'

  post    'sessions'                => 'sessions#create'
  get     'sessions'                => 'sessions#index'
  get     'sessions/:id'            => 'sessions#show'            #Indivudual session
  put     'sessions/:id/update'     => 'sessions#update' 
  put     'sessions/:id/activate'   => 'sessions#activate' 
  delete  'sessions/:id'            => 'sessions#delete'

  post    'questions'               => 'questions#create'
  get     'questions'               => 'questions#index'
  get     'questions/:id'           => 'questions#show'       #Indivudual question
  put     'questions/:id/update'    => 'questions#update'       
  put     'questions/:id/activate'  => 'questions#activate'   
  delete  'questions/:id'           => 'questions#delete'


  post    'answers'                 => 'answers#create'
  get     'answers'                 => 'answers#index'
  get     'answers/:id'             => 'answers#show'      #Indivudual answer
  put     'answers/:id'             => 'answers#update'       
  delete  'answers/:id'             => 'answers#delete'

  post  'responses'                 => 'responses#create'
  get   'responses'                 => 'responses#index'
  get   'responses/:id'             => 'responses#show'    #Indivudual response
  #nesscary, maybe want to store each response, 
  #that way could detect chnages over time in respones
  put   'responses/:id'             => 'responses#update' #iF WANT TO UPDATE RESPONSES





  root 'todo#todo'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

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
