FROM ruby:3.1-slim

# Install Python + image-resize dependencies
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-dev \
      python3-libsass \
      python3-rcssmin \
      python3-pil \
      build-essential \
      libjpeg-dev \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Install Ruby gems (jekyll + any plugins)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of your site + build script
COPY . .

# Build: compiles SCSS, thumbnails, then runs Jekyll
CMD ["python3", "build.py"]
