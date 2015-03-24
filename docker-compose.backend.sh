rm tmp/pids/server.pid
rdebug-ide --host 0.0.0.0 --port 3001 --dispatcher-port 3001 -- bin/rails server Puma -p 3000 -b 0.0.0.0