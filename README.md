📘 finance-collab-backend – API-Only Rails Application
Overview

This is the backend API for the multi-user financial collaboration app, enabling team-based expense tracking with real-time sync, audit logs, and external transaction integration.

🚀 Features

JWT-based authentication
Team-based expense management
Real-time updates via ActionCable
Comprehensive audit logging
Simulated external transaction syncing via Sidekiq

🛠️ Tech Stack

Ruby on Rails (API-only)
PostgreSQL
Sidekiq
Redis
ActionCable
JWT for authentication

📦 Setup Instructions

# Clone the repo
git clone https://github.com/arunkumark1ly/finance-collab-backend
cd finance-collab-backend

# Install dependencies
bundle install

# Set up database
rails db:setup

# Run Redis and Sidekiq
redis-server
bundle exec sidekiq

# Start the Rails server
rails s


🔐 Authentication

JWT-based auth with login/signup. Use the Authorization header with a Bearer token for protected routes.