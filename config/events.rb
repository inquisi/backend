WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.

  subscribe :client_disconnected, to: SessionsSocketController, with_method: :student_leave
  subscribe :client_disconnected, to: QuestionsSocketController, with_method: :session_end

  # namespace :websocket_rails do 
    # subscribe :subscribe, to: QuestionsSocketController, with_method: :client_subscribed
    # subscribe :subscribe_private, to: QuestionsRailsController, with_method: :client_subscribed_to_private
  # end

  namespace :student do
    subscribe :join_session, to: SessionsSocketController, with_method: :student_join
    subscribe :leave_session, to: SessionsSocketController, with_method: :student_leave
  end

  namespace :session do
    subscribe :connected_students, to: SessionsSocketController, with_method: :connected_students
  end

  namespace :questions do
    subscribe :activate, to: QuestionsSocketController, with_method: :activate
    subscribe :deactivate, to: QuestionsSocketController, with_method: :deactivate
    subscribe :deactivate_all, to: QuestionsSocketController, with_method: :session_end
  end
end
