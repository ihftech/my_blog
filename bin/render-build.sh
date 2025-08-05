#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
bundle install

# Precompile assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Wait for database to be ready
echo "Waiting for database to be ready..."
sleep 10

# Run migrations
bundle exec rails db:migrate