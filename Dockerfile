# Jekyll 2.x is happiest on Ruby ≤2.5
FROM ruby:2.3

# Install system dependencies for Jekyll & Gulp
RUN apt-get update && \
    apt-get install -y build-essential nodejs npm

# Install Jekyll (v2.x) and Bundler
RUN gem install jekyll -v "~>2.5" bundler

# Install Gulp CLI globally
RUN npm install -g gulp-cli

WORKDIR /srv/jekyll
COPY . .

# Install npm deps (for Gulp/theme) and Ruby gems (for Jekyll)
RUN npm install
RUN bundle install

# Default command when container is run
CMD ["gulp", "build"]
