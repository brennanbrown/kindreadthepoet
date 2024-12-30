#!/bin/bash

# Create directory structure
mkdir -p _data _includes _layouts _poems assets/{css,js,images} pages _posts

# Create data files
echo "Creating data files..."
cat > _data/navigation.yml << 'EOL'
- name: About
  link: /about/
  
- name: Poetry
  link: /poetry/
  
- name: Blog
  link: /blog/
  
- name: Contact
  link: /contact/
EOL

cat > _data/social.yml << 'EOL'
- platform: Twitter
  username: kindreadthepoet
  url: https://twitter.com/kindreadthepoet
  icon: twitter

- platform: Instagram
  username: kindreadthepoet
  url: https://instagram.com/kindreadthepoet
  icon: instagram

- platform: LinkedIn
  username: markMadelo
  url: https://linkedin.com/in/markMadelo
  icon: linkedin
EOL

cat > _data/poems.yml << 'EOL'
featured:
  - title: "First Featured Poem"
    excerpt: "Opening lines of the featured poem..."
    date: 2024-01-15
    venue: "Calgary Spoken Word Festival"
EOL

cat > _data/settings.yml << 'EOL'
homepage:
  featured_poems_count: 3
  recent_posts_count: 2
  
site:
  analytics_id: ""
  form_endpoint: ""
  newsletter_endpoint: ""
EOL

# Create include files
echo "Creating include files..."
mkdir -p _includes
for file in head header footer poem-card blog-card contact-form; do
    touch "_includes/$file.html"
done

# Create layouts
echo "Creating layouts..."
mkdir -p _layouts
for file in default post poem; do
    touch "_layouts/$file.html"
done

# Create assets directory and CSS file
echo "Creating assets..."
mkdir -p assets/{css,js,images}
touch assets/css/main.css

# Create main pages
echo "Creating pages..."
cat > index.html << 'EOL'
---
layout: default
title: Home
---
EOL

mkdir -p pages
for page in about poetry contact; do
    cat > "pages/${page}.md" << EOL
---
layout: default
title: ${page^}
permalink: /${page}/
---
EOL
done

# Create sample blog post and poem
echo "Creating sample content..."
cat > "_posts/$(date +%Y-%m-%d)-welcome.md" << 'EOL'
---
layout: post
title: "Welcome to My Poetry Journey"
date: 2024-12-30
categories: [writing, poetry]
---
This is my first blog post. More content coming soon.
EOL

cat > _poems/first-poem.md << 'EOL'
---
layout: poem
title: "First Light"
date: 2024-12-30
venue: "Calgary Spoken Word Festival"
featured: true
---
[Sample poem content]
EOL

# Create _config.yml if it doesn't exist
if [ ! -f "_config.yml" ]; then
    echo "Creating _config.yml..."
    cat > _config.yml << 'EOL'
title: Mark Madelo | Poet
email: contact@kindreadthepoet.com
description: >- 
  Mark (Marcus) Madelo is a Filipino-Canadian poet and spoken word artist
  based in Calgary, Alberta. VP of Outreach at MRU Write Club.
baseurl: ""
url: "https://kindreadthepoet.com"
twitter_username: kindreadthepoet

markdown: kramdown
plugins:
  - jekyll-feed
  - jekyll-seo-tag

collections:
  poems:
    output: true
    permalink: /poetry/:title/
EOL
fi

# Create .gitignore
echo "Creating .gitignore..."
cat > .gitignore << 'EOL'
_site
.sass-cache
.jekyll-cache
.jekyll-metadata
vendor
.DS_Store
*.swp
*~
EOL

# Create Gemfile if it doesn't exist
if [ ! -f "Gemfile" ]; then
    echo "Creating Gemfile..."
    cat > Gemfile << 'EOL'
source "https://rubygems.org"

gem "jekyll"
gem "jekyll-feed"
gem "jekyll-seo-tag"
EOL
fi

echo "Site structure created successfully!"
echo "Next steps:"
echo "1. bundle install"
echo "2. Copy the previously created HTML/CSS content into the respective files"
echo "3. bundle exec jekyll serve"