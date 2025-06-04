-- SQL Project 2 - Library Management System

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). 
--Display the member's_id, member's name, book title, issue date, and days overdue.

--issued_status == members = books == return_status => filter books to see >30days

select 
	ist.issued_member_id,
	mb.member_name,
	bk.book_title,
	ist.issued_date,
	--rts.return_date I don't care about NULLs
	CURRENT_DATE - ist.issued_date as over_dues_days
from issued_status as ist
INNER JOIN members as mb
ON ist.issued_member_id = mb.member_id
INNER JOIN books as bk
ON ist.issued_book_isbn = bk.isbn
LEFT JOIN return_status as rts --I WANT TO SEE ONLY WHAT'S RETURNED(what the table on left has and the right one doesn't)
ON ist.issued_id = rts.issued_id
WHERE 
	rts.return_date IS NULL -- to show what books are NOT RETURNED -> NULL
	AND (CURRENT_DATE - ist.issued_date) >= 30 -- note: you can't use the ALIAS
ORDER BY 2

/*
--Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned 
(based on entries in the return_status table).
*/
select * from issued_status;

--AUTOMAT APPROACH -> Store Procedures

CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(30), p_book_quality VARCHAR(75))
LANGUAGE plpgsql
AS $$

DECLARE
	v_isbn VARCHAR(50);
	v_book_name VARCHAR(75);

BEGIN 
	--LOGIC AND CODE HERE
	INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
	VALUES
		(p_return_id, p_issued_id, CURRENT_DATE ,p_book_quality);

	SELECT 
		issued_book_isbn,
		issued_book_name
		INTO
		v_isbn, --variable
		v_book_name	
	FROM issued_status
	WHERE issued_id = p_issued_id;
		
	UPDATE books
	SET status = 'yes'
	WHERE isbn = v_isbn;

	RAISE NOTICE 'Thank you for returning the book: %', v_book_name; --PRINT 
END;
$$

CALL add_return_records('RS138', 'IS138', 'Good');

--Test if is correct
select * from return_status
where issued_id = 'IS138'

/*
--Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, 
the number of books returned, and the total revenue generated from book rentals.
*/
SELECT * FROM branch;

SELECT * FROM issued_status;

SELECT * FROM employees;

SELECT * FROM books;

SELECT * FROM return_status;


CREATE TABLE branch_reports
AS 
SELECT
	br.branch_id,
	br.manager_id,
	count(ist.issued_id) as total_book_issued,
	count(rst.return_id) as total_returned_book,
	sum(bk.rental_price) as total_rental_price
FROM issued_status as ist
INNER JOIN employees as em
ON ist.issued_emp_id = em.emp_id
INNER JOIN branch as br
ON br.branch_id = em.branch_id
LEFT JOIN return_status as rst --I need everything that is in the first 2 inner and its not in return_status to see only returned books
ON rst.issued_id = ist.issued_id
INNER JOIN books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1,2;

/*
Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
containing members who have issued at least one book in the last 1 year(the data is too outdated).
*/
select * from issued_status


CREATE TABLE active_members
AS
select * from members 
WHERE member_id IN(select 
						issued_member_id
					from issued_status
					where issued_date >= CURRENT_DATE - INTERVAL '12 month');

/*
Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/
select * from books
SELECT *  from members
select * from branch
select * from issued_status
SELECT *  from employees

select 
	em.emp_name,
	br.*,
	count(ist.issued_id) as total_issued_books
from issued_status as ist
JOIN employees as em
ON em.emp_id = ist.issued_emp_id
JOIN branch as br
ON br.branch_id = em.branch_id
group by 1,2

/*
Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). If the book is available, 
it should be issued, and the status in the books table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/
select * from books;

select * from issued_status;

CREATE OR REPLACE PROCEDURE issue_boo(
										p_issued_id VARCHAR(10),
										p_issued_member_id VARCHAR(30), 
										p_issued_book_isbn VARCHAR(30), 
										p_issued_emp_id VARCHAR(10)
										)
LANGUAGE plpgsql
AS $$

DECLARE 
--VARIABLES
v_status VARCHAR(10);



BEGIN
--LOGIC
	--CHECK IF BOOK IS AVAILABLE
	SELECT 
		status
		INTO
		v_status
	FROM books
	WHERE isbn = p_issued_book_isbn;

	IF v_status = 'yes' THEN 
		INSERT INTO issued_status(issued_id, issued_member_id, issued_book_isbn, issued_emp_id)
		VALUES 
			(p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);
		UPDATE books
			SET status = 'no'
		WHERE isbn = issued_book_isbn;
		
		RAISE NOTICE 'Book added succesfully for %', p_issued_book_isbn;
		
	ELSE
		RAISE NOTICE 'Sorry to inform you but we do not have that book %', p_issued_book_isbn;
			
	END IF;

END;
$$

--insert into brackets the book that you want
CALL issue_book()