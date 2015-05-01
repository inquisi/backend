require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
	describe "create" do
	    it "should sa response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:saR)
	      	}.to change(SaResponse, :count).by(1)
	    end
	    it "should num response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:numR)
	      	}.to change(NumResponse, :count).by(1)
	    end
	    it "should mc response record" do
	   		# attributes_for returns a hash of values as they're defined in factories.rb
	   		expect {
	   			post :create , attributes_for(:mcR)
	   		}.to change(McResponse, :count).by(1)
	    end
	    it "should la response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:laR)
	      	}.to change(LaResponse, :count).by(1)
	    end

 	end

end
