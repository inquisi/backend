module Activatable
	extend ActiveSupport::Concern

	included do
		validates :active, inclusion: { in: [true, false] }
		after_initialize :set_active_default
	end

	def set_active_default
		self.active = false if self.active.blank?	
	end
end