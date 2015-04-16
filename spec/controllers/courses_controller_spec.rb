require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  render_views

  describe "create" do
    it "should take a name, and time and create a course record" do
      # attributes_for returns a hash of values as they're defined in factories.rb
      expect {
        post :create , attributes_for(:course)
      }.to change(Course, :count).by(1)
    end

  end


end
