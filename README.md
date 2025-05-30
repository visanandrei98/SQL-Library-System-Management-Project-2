# Library Management System – Project 2

## 📚 Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Technologies**: SQL (PostgreSQL)

This project simulates the management of a real-world library using SQL. It focuses on data modeling, CRUD operations, CTAS, and analytical queries. The goal is to showcase SQL proficiency in database design, manipulation, and reporting.

---

## 🎯 Objectives

1. Design a normalized relational database for a library.
2. Populate tables with realistic data using SQL scripts and CSV files.
3. Perform standard CRUD operations.
4. Use CTAS (Create Table As Select) for creating summary tables.
5. Develop complex queries for meaningful data analysis.

---

## 🗂️ Project Structure

### 1. Database Schema

Relevant files:
- `LibraryProject_Project2.sql` – main script for schema creation.
- `insert_queries.sql` – INSERT statements for data population.
- `ERDB_Project2.pgerd` – ER diagram model.

Tables created:
- `branch`
- `employees`
- `members`
- `books`
- `issued_status`
- `return_status`

Each table is connected via foreign key relationships – e.g., `employees.branch_id → branch.branch_id`, `issued_status.issued_book_isbn → books.isbn`.

---

### 2. Data Files

Data is stored in CSV format:
- `branch.csv`
- `employees.csv`
- `members.csv`
- `books.csv`
- `issued_status.csv`
- `return_status.csv`

These can be imported directly into PostgreSQL for realistic simulation.

---

### 3. CRUD Operations

- ✅ Insert new books and members
- 🔄 Update addresses or employee salaries
- ❌ Delete records from `issued_status`
- 🔍 Select data from all entities for inspection

---

### 4. CTAS (Create Table As Select)

- Create dynamic summary tables for reporting:
    - `book_issued_cnt`: number of times each book was issued
    - `active_members`: members active in the last 2 months
    - `expensive_books`: books with rental price above a threshold

---

### 5. Reporting & Analysis

Includes:
- Unreturned books using `LEFT JOIN`
- Overdue books (more than 30 days)
- Branch-wise performance reports
- Top 3 employees by issued books
- Total rental revenue per branch

---

## 🧠 Advanced Features

- **Stored Procedures** (`PL/pgSQL`):
    - `issue_book`: checks availability, updates status
    - `add_return_records`: records return and updates book status

---

## 🏁 How to Run

1. Create the database `library_db`.
2. Run `LibraryProject_Project2.sql` to build the schema.
3. Run `insert_queries.sql` to populate the tables.
4. Use `Exercises.sql` for querying and analysis.

---

## 📌 Project Status

✔️ 100% Complete  
📂 Suitable for portfolios (Data Analyst / SQL Developer)  
🧪 Tested with PostgreSQL
