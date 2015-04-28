require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # Define a new dummy controller to inherit from ApplicationController
  controller do
    def index
      if @user.present?
        raise 'great!'
      end
    end
  end

  describe "authenticate_and_set_user" do
    describe "with the correct token" do
      it "should set @user" do
        user = create :student

        expect { get :index, token: user.token }.to raise_error('great!')
      end
    end

    describe "with an incorrect token" do
      it "should respond with 401 unauthorized" do
        get :index
        
        expect(response).to render_template('standard_responses/unauthorized', layout: 'failure')
      end
    end
  end
end