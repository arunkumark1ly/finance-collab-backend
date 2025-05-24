📘 finance-collab-backend – API-Only Rails Application

🧭 Overview
This is the backend API for the multi-user financial collaboration platform. It powers team-based expense tracking with features like real-time synchronization, audit logging, and external transaction integration—all secured with JWT authentication.

🚀 Features
🔐 JWT-based authentication
🧾 Team-based expense management
⚡ Real-time updates using ActionCable
📚 Audit logging for all expense activities
🔁 Simulated external transaction sync using Sidekiq
🛠️ Tech Stack
💎 Ruby on Rails (API-only mode)
🐘 PostgreSQL
📊 Sidekiq for background processing
🧠 Redis for job and ActionCable handling
🔌 ActionCable for real-time features
🔑 JWT for secure authentication
📦 Setup Instructions
# Clone the repository
git clone https://github.com/arunkumark1ly/finance-collab-backend
cd finance-collab-backend

# Install dependencies
bundle install

# Set up the database
rails db:setup

# Start Redis server (for Sidekiq and ActionCable)
redis-server

# Start Sidekiq in a separate terminal
bundle exec sidekiq

# Run the Rails API server
rails s
🔐 Authentication
Authentication is powered by JWT.
Include the token in your API requests using the Authorization header:

Authorization: Bearer <your_token_here>
📡 API Endpoints
🔑 Authentication

POST /signup – Register a new user
POST /signin – Login and receive a JWT token
👥 Teams & Expenses

POST /teams – Create a new team
GET /teams/:id/expenses – Fetch all expenses for a team
POST /expenses – Add a new expense
📚 Audit Trail

GET /expenses/:id/audit_trail – View the audit trail of a specific expense
🔁 External Sync

POST /external_sync/start – Trigger the mocked external sync job
