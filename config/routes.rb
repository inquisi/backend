Backend::Application.routes.draw do
  #USERS
  post    'login'                   => 'users#login'
  post    'logout'                  => 'users#logout'
  post    'signup'                  => 'users#signup'

  get     'user'                    => 'users#show'             #Individual User

  get     'user/students'           => 'users#students'         #students belonging to instructor

  put     'users/:id'               => 'users#update'
  #delete account ?? Not needed now
  delete  'users'                   => 'users#delete'
  #to delete all 
      #NOT NEEDED??


  #COURSES
  post    'courses'                 => 'courses#create'
  post    'courses/enroll'          => 'courses#enroll'

  get     'courses'                 => 'courses#index'
  get     'courses/:id'             => 'courses#show'  
             #Indivudual course
  put     'courses/:id'             => 'courses#update'   
  #^^^^^ /update if needed, Not but for consisentncy   ^^^^
  delete  'courses/:id'             => 'courses#delete'
  #to delete all 
  delete  'courses'                 => 'courses#deleteAll'

  #SESSIONS
  post    'sessions'                => 'sessions#create'

  get     'sessions'                => 'sessions#index'
  get     'sessions/:id'            => 'sessions#show'         #Indivudual session

  put     'sessions/:id'            => 'sessions#update' 
  post    'sessions/:id/activate'   => 'sessions#activate' 

  delete  'sessions/:id'            => 'sessions#delete'
  #to delete all 
  delete  'sessions'                => 'sessions#deleteAll'

  #Questions
  post    'questions'               => 'questions#create'

  get     'questions'               => 'questions#index'
  get     'questions/:id'           => 'questions#show'       #Indivudual question

  put     'questions/:id'           => 'questions#update'       
  post    'questions/:id/activate'  => 'questions#activate'   

  delete  'questions/:id'           => 'questions#delete'
  #to delete all 
  delete  'questions'               => 'questions#deleteAll'

  #Answers
  post    'answers'                 => 'answers#create'

  get     'answers'                 => 'answers#index'
  get     'answers/:id'             => 'answers#show'      #Indivudual answer

  put     'answers/:id'             => 'answers#update'    

  delete  'answers/:id'             => 'answers#delete'
  #to delete all 
  delete  'answers'                 => 'answers#deleteAll'

  #Responses
  post  'responses'                 => 'responses#create'

  get   'responses'                 => 'responses#index'
  get   'responses/:id'             => 'responses#show'    #Indivudual response
  #nesscary, maybe want to store each response, 
  #that way could detect chnages over time in respones
  put   'responses/:id'             => 'responses#update' #iF WANT TO UPDATE RESPONSES

  delete  'responses/:id'           => 'responses#delete'
  #to delete all 
  delete  'responses'               => 'responses#deleteAll'


  #TODO
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
