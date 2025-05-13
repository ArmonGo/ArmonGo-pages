# Dockerfile
FROM ruby:2.3    # Jekyll 2.x is happiest on Ruby ≲2.5

# system deps for Jekyll & Gulp
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm

# Install Jekyll (latest 2.x) and Bundler
RUN gem install jekyll -v "~>2.5" bundler

# Install Gulp globally
RUN npm install -g gulp-cli

WORKDIR /srv/jekyll
COPY . .

# Install theme's npm deps & gems
RUN npm install
RUN bundle install

# Default command: build site into /srv/jekyll/_site
CMD ["gulp", "build"]
