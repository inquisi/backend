require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # Define a new dummy controller to inherit from ApplicationController
  controller do
    def index
      if @user.present?
        raise 'great!'
      else
        raise 'not great!'
      end
    end
  end

  describe "authenticate_with_token_and_set_user" do
    describe "with the correct token" do
      it "should call through to a controller with an @user set" do
        user = create :student

        expect { get :index, token: user.token }.to raise_error('great!')
      end
    end
  end
end