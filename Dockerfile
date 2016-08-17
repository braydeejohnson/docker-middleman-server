FROM ruby:onbuild
MAINTAINER Braydee Johnson <braydee@braydeejohnson.com>

RUN apt-get update && apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME /usr/src/app/source
EXPOSE 80

CMD ["bundle", "exec", "middleman", "server", "--force-polling"]