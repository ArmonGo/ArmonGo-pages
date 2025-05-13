FROM ruby:3.1-slim

# Install Python + image libs
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

# Only copy the Gemfile (lock is optional)
COPY Gemfile ./

# Install Jekyll & any listed plugins
RUN bundle install

# Now copy everything else (including your build.py)
COPY . .

# When container runs, build the site
CMD ["python3", "build.py"]
