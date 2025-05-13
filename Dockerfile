FROM ruby:3.1-slim

# Install system deps + Node.js & npm
RUN apt-get update && \
    apt-get install -y build-essential nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Latest Bundler comes preinstalled here
RUN gem install jekyll -v "~>2.5"

# Install Gulp CLI
RUN npm install -g gulp-cli

WORKDIR /srv/jekyll
COPY . .

RUN npm install
RUN bundle install

CMD ["gulp", "build"]
