FROM docker.io/library/ruby:3.1.2

RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client yarn

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler && bundle install

 # <-- this brings in your master.key too!
COPY . .  

EXPOSE 3000

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
