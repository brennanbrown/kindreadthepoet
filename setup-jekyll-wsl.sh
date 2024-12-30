#!/bin/bash

# Function to print section headers
print_header() {
    echo
    echo "=== $1 ==="
    echo
}

# Function to check command success
check_success() {
    if [ $? -eq 0 ]; then
        echo "✓ $1 successful"
    else
        echo "✗ Error: $1 failed"
        exit 1
    fi
}


# Remove Ruby 2.5 if it exists
print_header "Removing old Ruby version if present"
sudo apt-get remove -y ruby2.5 ruby2.5-dev
check_success "Ruby 2.5 removal"

# Install Ruby 2.7 and dependencies
print_header "Installing Ruby 2.7 and dependencies"
sudo apt-get install -y ruby2.7 ruby2.7-dev build-essential dh-autoreconf
check_success "Ruby 2.7 installation"

# Update RubyGems
print_header "Updating RubyGems"
sudo gem update --system
check_success "RubyGems update"

# Install Jekyll and Bundler
print_header "Installing Jekyll and Bundler"
sudo gem install jekyll bundler
check_success "Jekyll and Bundler installation"

# Verify installations
print_header "Verifying installations"
ruby --version
gem --version
jekyll --version
bundler --version

# Create a test Jekyll site
print_header "Creating test Jekyll site"
jekyll new test-site
cd test-site
bundle install
check_success "Test site creation"

# Add WSL2 workaround for file watching
print_header "Adding WSL2 workaround for file watching"
echo '
# WSL2 workaround for file watching
if File.exists?("/proc/version") && File.read("/proc/version").include?("microsoft")
  options["force_polling"] = true
end' >> Gemfile
check_success "WSL2 workaround addition"

# Print success message and next steps
print_header "Installation Complete!"
echo "To serve your Jekyll site:"
echo "1. Navigate to your site directory"
echo "2. Run: bundle exec jekyll serve --force_polling"
echo
echo "Note: The --force_polling flag is required for file watching in WSL2"