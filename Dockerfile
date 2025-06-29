FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Set working directory
WORKDIR /app

# Install bundler and copy Gemfiles
COPY Gemfile* ./
RUN gem install bundler && bundle install

# Copy the rest of the code
COPY . .

# Precompile assets (optional for dev)
# RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Start the server
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
