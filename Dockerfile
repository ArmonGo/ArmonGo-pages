# Use Ruby 2.7 (compatible with Jekyll 2.x’s use of URI.escape)
FROM ruby:2.7-slim

# 1. Install Python + image-resize & CSS deps
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-libsass \
      python3-rcssmin \
      python3-pil \
      build-essential \
      libjpeg-dev \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# 2. Install Bundler (last 2.x supporting Ruby 2.7) and Jekyll 2.x
RUN gem install bundler -v 2.4.22 \
 && gem install jekyll -v "~>2.5"

WORKDIR /srv/jekyll

# 3. If you have a Gemfile with plugins, copy & bundle; otherwise skip
COPY Gemfile ./
RUN bundle install || echo "No Gemfile detected, skipping bundle install"

# 4. Copy the rest of your site (including build.py)
COPY . .

# 5. On container start: run the Python build script
#    which compiles your Sass, generates thumbnails, then invokes Jekyll
CMD ["python3", "build.py"]
