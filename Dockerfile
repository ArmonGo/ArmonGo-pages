FROM ruby:3.1-slim

# Install system deps: Python, pip, image libs, build tools
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-pip \
      python3-dev \
      build-essential \
      libjpeg-dev \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Jekyll v2.x
RUN gem install jekyll -v "~>2.5"

# Install your Python build dependencies
RUN pip3 install libsass rcssmin Pillow

WORKDIR /srv/jekyll
COPY . .

# Install any Ruby gems (if you have a Gemfile)
RUN bundle install

# Default command runs your build script
CMD ["python3", "build.py"]
