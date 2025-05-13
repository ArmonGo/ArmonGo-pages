# Dockerfile
FROM ruby:2.7-slim

# Install system deps + Node.js & npm
RUN apt-get update && \
    apt-get install -y build-essential nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Install Jekyll 2.x and Bundler
RUN gem install jekyll -v "~>2.5" bundler

# Install Gulp CLI
RUN npm install -g gulp-cli

WORKDIR /srv/jekyll
COPY . .

# Install theme deps
RUN npm install
RUN bundle install

CMD ["gulp", "build"]
