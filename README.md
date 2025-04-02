# 💰 Personal Finance Tracker - Flutter App

A personal finance tracking mobile app built with Flutter & SQLite. Track income, expenses, savings goals, and view insightful reports — all offline and user-specific.

---

## Features

### Authentication
- User **Register** (with name, email, password)
- **Login** / **Continue as Guest**
- **Local SQLite-based user sessions**
- Session-scoped data per user (only see your transactions/goals)

### Dashboard (Home)
- View all income & expenses
- Color-coded entries (green = income, red = expense)
- **Edit or delete** transactions (tap to edit, long-press to delete)
- Total **balance**, with income & expense summary

### Add Transaction
- Add income or expense with:
  - Title
  - Amount
  - Category
  - Type (Income/Expense)
  - Date (default = today)
- Validation for all inputs

### Reports
- Pie chart comparison of **Income vs Expense**
- **Custom date range selector**
- Filter transactions within a date range
- Shows selected period

### Savings Goals
- Add, edit, and delete savings goals
- Track progress with progress bars
- Set custom saved amounts toward goals
- Only current user’s goals shown

### Profile & Settings
- View name & email
- **Logout** functionality

---

## Tech Stack

- **Flutter** (Dart)
- **SQLite** (via `sqflite` package)
- **Local storage** for sessions and data
- **State management** using StatefulWidgets and `setState()`
- **Charts** via `fl_chart`

---

## Setup Instructions

### 1. Clone the repo

```bash
git clone https://github.com/bashapu/personal_finance_manager.git
cd personal_finance_manager
flutter pub get
flutter run
