FROM ruby:3.2

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		postgresql-client \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 data-catalogue \
    && useradd --uid 1000 --gid 1000 -m data-catalogue
USER data-catalogue
WORKDIR /home/data-catalogue

COPY --chown=data-catalogue:data-catalogue . .
RUN gem update bundler && bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]