FROM ruby:2.5.1

MAINTAINER Felipe Rodrigues <felipe_rodriguesx@hotmail.com>

ENV app_path /opt/test/
WORKDIR ${app_path}

COPY Gemfile* ${app_path}

RUN bundle install

COPY . ${app_path}

ENTRYPOINT ["bundle", "exec", "cucumber -p ${ENV}"]
