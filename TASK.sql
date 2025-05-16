SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;


-- Project TASK

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price,status,author,publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

--Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '37 los Street'
WHERE member_id='C101'
SELECT * FROM members;

--Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status;

DELETE FROM issued_status
WHERE issued_id = 'IS121'

--Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

--Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT
	issued_emp_id,
	COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*)>1;

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE TABLE book_cnts
AS
SELECT 
	b.isbn,
	b.book_title,
	COUNT(ist.issued_id)  AS no_issued
FROM books as b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP by 1,2;

SELECT * FROM
book_cnts;

--Task 7. Retrieve All Books in a Specific Category

SELECT * FROM books
WHERE category ='Classic';

--Task 8: Find Total Rental Income by Category
select	
	b.category,
	sum(b.rental_price),
	COUNT(*)
FROM books as b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP by 1

--Task 9: List Members Who Registered in the Last 180 Days

SELECT * FROM members
WHERE reg_date	>=current_date	- INTERVAL '180 days';

/*INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C120', 'Ghanshyam Gupta', '758 wall street', '2025-02-28'),
('C121', 'Rajesh Gupta', '758 wall street', '2025-01-08')
*/

--Task 10: List Employees with Their Branch Manager's Name and their branch details

SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;


--Task 12: Retrieve the List of Books Not Yet Returned

SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

