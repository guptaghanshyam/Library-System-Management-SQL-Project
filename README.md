# Library Management System ( SQL Project )

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

### ✅ Task 13: Identify Members with Overdue Books

/*Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue. */

/*
issued_status == members == books == return_status
filter books which is return
overdue > 30 */

```sql

SELECT CURRENT_DATE

SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status as ist
JOIN 
members as m
    ON m.member_id = ist.issued_member_id
JOIN 
books as bk
ON bk.isbn = ist.issued_book_isbn
LEFT JOIN 
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE 
    rs.return_date IS NULL
    AND
    (CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1
```

---


###Task ✅ 14: Update Book Status on Return
/*Write a query to update the status of books in the books table to "Yes" when they are returned
(based on entries in the return_status table). */

```sql
SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-330-25864-8';

SELECT * FROM books
WHERE isbn = '978-0-451-52994-2';

UPDATE books
SET status = 'no'
WHERE isbn = '978-0-451-52994-2';

SELECT * FROM return_status
WHERE issued_id = 'IS130';

INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
VALUES
('RS125', 'IS130', CURRENT_DATE, 'Good');
SELECT * FROM return_status
WHERE issued_id = 'IS130';


CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10), p_book_quality VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
    v_isbn VARCHAR(50);
    v_book_name VARCHAR(80);
    
BEGIN
   
    INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
    VALUES
    (p_return_id, p_issued_id, CURRENT_DATE, p_book_quality);

    SELECT 
        issued_book_isbn,
        issued_book_name
        INTO
        v_isbn,
        v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    RAISE NOTICE 'Thank you for returning the book: %', v_book_name;
    
END;
$$
    
issued_id = 'IS135'
ISBN = WHERE isbn = '978-0-307-58837-1'

SELECT * FROM books
WHERE isbn = '978-0-307-58837-1';

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM return_status
WHERE issued_id = 'IS135';

-- calling function 
CALL add_return_records('RS138', 'IS135', 'Good');

-- calling function 
CALL add_return_records('RS148', 'IS140', 'Good');
---

---
