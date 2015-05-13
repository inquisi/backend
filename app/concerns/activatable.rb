module Activatable
	extend ActiveSupport::Concern

	included do
		validate :active_valid?
		after_initialize :set_active_default
	end

	def active_valid?
		if (read_attribute('active') != true && read_attribute('active') != false)
			errors.add(:active, "must be either true or false")
		end
	end

	def set_active_default
		write_attribute('active', false) if read_attribute('active').blank?	
	end
end