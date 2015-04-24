Backend::Application.routes.draw do
  post  'login'         => 'users#login'
  post  'logout'        => 'users#logout'
  post  'signup'        => 'users#signup'
  get   'user'          => 'users#show'               #Individual User

  post  'courses'       => 'courses#create'
  get   'courses'       => 'courses#index'
  get   'courses/:id'   => 'courses#show'             #Indivudual course

  post  'sessions'      => 'sessions#create'
  get   'sessions'      => 'sessions#index'
  get   'sessions/:id'  => 'sessions#show'            #Indivudual session

  post  'questions'         => 'questions#create'
  get   'questions'         => 'questions#index'
  get   'questions/:id'     => 'questions#show'       #Indivudual question

  post  'mc_answers'        => 'mc_answers#create'
  get   'mc_answers'        => 'mc_answers#index'
  get   'mc_answers/:id'    => 'mc_answers#show'      #Indivudual mc_answer

  post  'mc_responses'      => 'mc_responses#create'
  get   'mc_responses'      => 'mc_responses#index'
  get   'mc_responses/:id'  => 'mc_responses#show'    #Indivudual mc_response

  post  'sa_answers'        => 'sa_answers#create'
  get   'sa_answers'        => 'sa_answers#index'
  get   'sa_answers/:id'    => 'sa_answers#show'      #Indivudual sa_answer

  post  'sa_responses'      => 'sa_responses#create'
  get   'sa_responses'      => 'sa_responses#index'
  get   'sa_responses/:id'  => 'sa_responses#show'    #Indivudual sa_response

  post  'la_responses'      => 'la_responses#create'
  get   'la_responses'      => 'la_responses#index'
  get   'la_responses/:id'  => 'la_responses#show'    #Indivudual la_response

  post  'num_answers'        => 'num_answers#create'
  get   'num_answers'        => 'num_answers#index'
  get   'num_answers/:id'    => 'num_answers#show'      #Indivudual num_answer

  post  'num_responses'      => 'num_responses#create'
  get   'num_responses'      => 'num_responses#index'
  get   'num_responses/:id'  => 'num_responses#show'    #Indivudual num_response


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
