# 📚 Library Management System – SQL Project 2

## 🔍 Project Overview

**Level**: Intermediate  
**Technologies**: PostgreSQL, PL/pgSQL (Stored Procedures)

This project simulates a real-world Library Management System using PostgreSQL. It focuses on relational database design, SQL querying, and process automation using stored procedures.

---

## 🎯 Objectives

1. Design a normalized relational database for a library.
2. Generate useful reports for business insights.
3. Use stored procedures to automate return and issue operations.
4. Apply advanced SQL concepts: multi-table joins, CTAS, date functions, and subqueries.
5. Simulate a functional system with members, employees, branches, books, and transaction status tracking.

---

## 🗂️ Project Structure

### Main Tables:
- `branch` – Library branches
- `employees` – Employees assigned to a branch
- `members` – Library members
- `books` – Books with status (available or issued)
- `issued_status` – Book issue records
- `return_status` – Book return records

---

## 🛠️ Features Implemented

### ✅ CRUD & Querying
- Select queries for inspecting books, members, employees, etc.
- Complex joins to analyze transactions and statuses.

---

## 📌 Key Tasks

### 📅 Task 13: Identify Overdue Books  
Query to find members who have not returned books within 30 days. Output includes member name, book title, issue date, and days overdue.

### 🔁 Task 14: Update Book Status on Return  
Stored procedure `add_return_records`:
- Inserts a return entry into `return_status`
- Updates the book's status to `'yes'`
- Displays a thank-you message with the book title

### 📊 Task 15: Branch Performance Report  
Generates a report per branch with:
- Total books issued
- Total books returned
- Total rental revenue

### 📋 Task 16: CTAS – Active Members Table  
Creates `active_members` for users who borrowed at least one book in the last 12 months.

### 🧑‍💼 Task 17: Top 3 Employees by Book Issues  
Ranks employees by number of book issues processed, including their branch info.

### 🛑 Task 19: Issue Book with Availability Check  
Stored procedure `issue_book`:
- Takes the book ISBN and checks if it's available (`status = 'yes'`)
- If yes: inserts an issue record and updates status to `'no'`
- If not: prints an error message that the book is not available

---

## ⚙️ Advanced Automation – Stored Procedures

### 1. `add_return_records(...)`  
- Inserts a return entry  
- Updates book status to `'yes'`  
- Outputs a thank-you message

### 2. `issue_book(...)`  
- Checks if the book is available  
- If yes, records the issue and sets status to `'no'`  
- If not, displays an error notice

---

## 🚀 How to Use

1. Create a PostgreSQL database (e.g., `library_db`).
2. Run the schema and insert scripts (`LibraryProject_Project2.sql`, `insert_queries.sql`).
3. Execute the task queries and stored procedures using your preferred SQL client.
4. Analyze results and simulate real library operations.
