# Use the rails image as a base
FROM rails:4.2.1

# cd into /tmp
WORKDIR /tmp

# Add the Gemfile and run `bundle install` to install dependencies
# This step is done separately so that it can take advantage of Docker's cache
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Install the ruby-debug-ide gem so that RubyMine can connect to this Docker container
RUN gem install ruby-debug-ide

WORKDIR /opt/backend/

# Make ports 3000 and 3001 available to the host machine
EXPOSE 3000
EXPOSE 3001
#CMD rdebug-ide --host 0.0.0.0 --port 3001 --dispatcher-port 3001 -- bin/rails server Puma -p 3000 -b 0.0.0.0
#CMD /bin/bash