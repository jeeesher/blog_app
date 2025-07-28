# Blog App

A simple blog application built with **Ruby on Rails** that supports user authentication, post management, comments, and an admin panel for managing content.

**Live Demo:** [https://blog-app-dup1.onrender.com](https://blog-app-dup1.onrender.com)

## ✨ Features

- **User Authentication** – Users can register, log in, and log out.
- **Roles & Permissions** – Supports normal users and an admin role.
- **Blog Posts** – Users can create, edit, and delete their own posts.
- **Comments** – Users can comment on blog posts.
- **Admin Panel** – Admins can manage all posts and comments.
- **Deployed on Render** with PostgreSQL as the production database.

---

## 🛠 Tech Stack

- **Ruby** 3.x  
- **Rails** 8.x  
- **PostgreSQL** (Production)  
- **SQLite** (Development & Test)  
- **Bootstrap 5** for styling  
- **Render** for deployment  

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/blog_app.git
cd blog_app

### 2. Install Dependencies

```bash
bundle install

### 3. Setup the Database

```bash
rails db:create db:migrate db:seed
rails db:migrate

### 4. Start the Server

```bash
bin/rails server
