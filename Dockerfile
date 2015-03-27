# Use the rails image as a base
FROM rails:4.2.1

# Add the Gemfile and run `bundle install` to install dependencies
# This step is done separately so that it can take advantage of Docker's cache

# cd into /tmp
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Install the ruby-debug-ide gem so that RubyMine can connect to this Docker container
RUN gem install ruby-debug-ide

WORKDIR /opt/backend/

# Make ports 3000 and 3001 available to the host machine
EXPOSE 3000
EXPOSE 3001

# Set all file permissions so that they are writable and readable by everyone
RUN echo "umask 0000" >> ~/.bashrc
RUN echo "umask 0000" >> ~/.bash_profile

RUN sed -i '1i umask 0000\n' /root/.profile
RUN sed -i '1i umask 0000\n' /etc/profile
RUN umask 0000
RUN /bin/sh . /root/.profile

#CMD rdebug-ide --host 0.0.0.0 --port 3001 --dispatcher-port 3001 -- bin/rails server Puma -p 3000 -b 0.0.0.0
#CMD /bin/bash

