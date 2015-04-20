class McResponse < ActiveRecord::Base
	belongs_to 		:mc_answer
	belongs_to 		:user
end
