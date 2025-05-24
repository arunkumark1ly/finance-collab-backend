# 📘 finance-collab-backend – API-Only Rails Application

## 🧭 Overview

This is the **backend API** for the [multi-user financial collaboration platform](https://github.com/arunkumark1ly/finance-collab-frontend). It supports team-based expense tracking, real-time updates, audit trails, and integration with external data sources (mocked) — all secured with **JWT authentication**.

---

## 🚀 Features

- 🔐 JWT-based authentication
- 👥 Team-based expense tracking
- ⚡ Real-time updates using ActionCable
- 🧾 Comprehensive audit logging
- 🔁 Simulated external sync with Sidekiq

---

## 🛠️ Tech Stack

- **Ruby on Rails** (API-only)
- **PostgreSQL**
- **Sidekiq** for background jobs
- **Redis** for queue management and ActionCable
- **ActionCable** for real-time updates
- **JWT** for authentication

---

## 📦 Setup Instructions

```bash
# Clone the repository
git clone https://github.com/arunkumark1ly/finance-collab-backend.git
cd finance-collab-backend

# Install dependencies
bundle install

# Set up the database
rails db:setup

# Start Redis server (required for Sidekiq and ActionCable)
redis-server

# In a new terminal, start Sidekiq
bundle exec sidekiq

# Start the Rails server
rails s


🔐 Authentication

This API uses JWT (JSON Web Token) for securing endpoints.
All protected routes require the following HTTP header:

Authorization: Bearer <your_token_here>
📡 API Endpoints

🔑 Authentication
Method	Endpoint	Description
POST	/signup	Register a new user
POST	/signin	Log in and receive JWT
👥 Teams & Expenses
Method	Endpoint	Description
POST	/teams	Create a new team
GET	/teams/:id/expenses	List all expenses for a team
POST	/expenses	Add a new expense
🧾 Audit Trail
Method	Endpoint	Description
GET	/expenses/:id/audit_trail	Retrieve audit logs for an expense
🔁 External Sync
Method	Endpoint	Description
POST	/external_sync/start	Trigger mock external sync job
