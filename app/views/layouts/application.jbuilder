json.status @status || "success"
json.message @message || ""
json.data JSON.parse(yield)