class AnonymousUser < User
	alias_attribute :name, :first_name
end