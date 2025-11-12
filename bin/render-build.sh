set -o errexit
bundle install
bin/rails tailwindcss:build # Ensure Tailwind CSS is built
bundle exec rails assets:precompile
bundle exec rails assets:clean
