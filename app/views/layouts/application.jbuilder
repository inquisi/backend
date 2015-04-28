json.status @status || "success"
json.message @message || ""
json.data yield.present? ? JSON.parse(yield) : {}