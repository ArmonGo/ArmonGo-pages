FROM ruby:2.7-slim

# 1. System deps for Python & image resizing
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

# 2. Install Bundler (pinned) and Jekyll 2.x
RUN gem install bundler -v 2.4.22 \
 && gem install jekyll -v "~>2.5"

WORKDIR /srv/jekyll

# 3. Install any plugins via Bundler
COPY Gemfile ./
RUN bundle install

# 4. Bring in your site + build script
COPY . .

# 5. Build on container start:
#    - compile SCSS & thumbnails (build.py)
#    - run `jekyll build`
CMD ["python3", "build.py"]
