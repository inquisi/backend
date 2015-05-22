json.name 			session.name
json.date			session.date
json.id				session.id
json.course_id 		session.course_id
json.active			session.active
json.allow_anonymous	session.allow_anonymous
if session.allow_anonymous
	json.token session.token
end