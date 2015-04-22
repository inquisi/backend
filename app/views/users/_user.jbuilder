json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.role user.role
json.trial user.trial

if user.role == "Instructor"
	json.organization user.organization
end