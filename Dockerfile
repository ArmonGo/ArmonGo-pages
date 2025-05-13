FROM ruby:3.1-slim

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

RUN gem install jekyll -v "~>2.5"

WORKDIR /srv/jekyll
COPY . .

RUN bundle install

CMD ["python3", "build.py"]
