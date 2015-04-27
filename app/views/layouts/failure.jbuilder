json.status @status || "failure"
json.message @message || ""
json.data JSON.parse(yield)