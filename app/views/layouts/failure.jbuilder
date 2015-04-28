json.status @status || "failure"
json.message @message || ""
json.data yield.present? ? JSON.parse(yield) : {}