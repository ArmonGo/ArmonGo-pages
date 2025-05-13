# Use a maintained Debian release so Node/npm still install out of the box
FROM ruby:2.7-slim

# Install system deps + Node.js & npm
RUN apt-get update && \
    apt-get install -y build-essential nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Install Bundler, then Jekyll v2.x
RUN gem install bundler \
 && gem install jekyll -v "~>2.5"

# Install Gulp CLI globally
RUN npm install -g gulp-cli

WORKDIR /srv/jekyll
COPY . .

# Install theme’s npm deps and Ruby gems
RUN npm install
RUN bundle install

# Default command: build your site
CMD ["gulp", "build"]
