# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![Library_project](https://github.com/najirh/Library-System-Management---P2/blob/main/library.jpg)

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### Database Setup
![ERD]("C:\Users\KISHAN\OneDrive\Desktop\SQL project\Library Management\Library_ERD.png")


### ✅ Task 1: Create a New Book Record

```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books;
```

---

### ✅ Task 2: Update an Existing Member's Address

```sql
UPDATE members
SET member_address = '37 los Street'
WHERE member_id = 'C101';

SELECT * FROM members;
```

---

### ✅ Task 3: Delete a Record from the Issued Status Table

```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';

SELECT * FROM issued_status;
```

---

### ✅ Task 4: Retrieve All Books Issued by a Specific Employee

```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';
```

---

### ✅ Task 5: List Members Who Have Issued More Than One Book

```sql
SELECT issued_emp_id, COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1;
```

---

### ✅ Task 6: Create Summary Table – Book Issue Counts

```sql
CREATE TABLE book_cnts AS
SELECT 
    b.isbn,
    b.book_title,
    COUNT(ist.issued_id) AS no_issued
FROM books AS b
JOIN issued_status AS ist ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;

SELECT * FROM book_cnts;
```

---

### ✅ Task 7: Retrieve All Books in a Specific Category

```sql
SELECT * FROM books
WHERE category = 'Classic';
```

---

### ✅ Task 8: Find Total Rental Income by Category

```sql
SELECT
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM books AS b
JOIN issued_status AS ist ON ist.issued_book_isbn = b.isbn
GROUP BY 1;
```

---

### ✅ Task 9: List Members Who Registered in the Last 180 Days

```sql
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
```

---

### ✅ Task 10: List Employees with Their Branch Manager and Branch Details

```sql
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name AS manager
FROM employees AS e1
JOIN branch AS b ON e1.branch_id = b.branch_id
JOIN employees AS e2 ON e2.emp_id = b.manager_id;
```

---

### ✅ Task 11: Create a Table for Expensive Books

```sql
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;
```

---

### ✅ Task 12: Retrieve the List of Books Not Yet Returned

```sql
SELECT * FROM issued_status AS ist
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;
```

---
