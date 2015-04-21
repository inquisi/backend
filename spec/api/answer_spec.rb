require 'rails_helper'
#For all Answers
RSpec.describe 'Answer API', type: :request do
  # For one answer call for all types
  describe "/create" do
    
  end

  
  	describe '/answers' do
    	it 'should show all answers for a given question_id ' do
    		pending "Implementation" 
      		fail

    	end
  	end

  
  describe '/answers/#id' do
    it 'should show the answer corresponding to #id, for a given question_id ' do
      pending "Implementation" 
      fail
      
    end
  end
 
  	#for dif calls for each type??? Is this wanted?
	# describe "/mc_answer" do
	# 	it 'should  ' do
 #      		pending "Implementation" 
 #      		fail
      
 #    	end
	# end

	# describe "/la_answer" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail
      
 #    	end
	# end

	# describe "/sa_answer" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail
      
 #    	end
	# end

	# describe "/num_answer" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail
      
 #    	end
	# end
end

