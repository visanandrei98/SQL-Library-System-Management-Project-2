SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

---Tasks

--Ex.1 Create a New Book Record --'978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')" -- 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

--Ex.2 Update an Existing Member's Address
SELECT * FROM members;
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101'

--Ex.3 Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
SELECT * FROM issued_status;
DELETE FROM issued_status
WHERE issued_id = 'IS121'

--Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
select * from issued_status
SELECT 
	issued_emp_id
	--count(issued_id) as total_book_issued
FROM issued_status
group by issued_emp_id
HAVING COUNT(issued_id) > 1

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
select * from books
select * from issued_status

CREATE TABLE book_cnts
AS
SELECT 
	b.isbn,
	b.book_title,
	count(ist.issued_id) as no_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn --ON pentru a verifica TRUE/FALSE daca e match intre coloana din book vs coloana din issued_status
group by b.isbn

--A ramas generat tabelul
select *
from book_cnts;

--Task 7. Retrieve All Books in a Specific Category and the number:
select 
	category,
	count(isbn) as total_number_books
from books
group by category


--Task 8: Find Total Rental Income by Category:
select * 
from books

select 
	category,
	sum(rental_price) as total_price
from books
group by category
order by total_price DESC

--Task 9.List Members Who Registered in the Last 180 Days:
select * from members
where reg_date >= CURRENT_DATE - INTERVAL '180 days'

INSERT INTO  members(member_id, member_name, member_address, reg_date)
VALUES 
	('C120','SAM','145 Main St', '2025-05-29'),
	('C121','Andrew','100 Main St', '2025-05-28')

--Task 10.List Employees with Their Branch Manager's Name and their branch details:
select * from employees
select * from branch


select 
	em1.*,
	em2.emp_name as manager,
	br1.manager_id
from branch as br1
INNER JOIN employees as em1
ON br1.branch_id = em1.branch_id
INNER JOIN 
employees as em2
ON em2.emp_id = br1.manager_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold (5 dollars):

CREATE TABLE Threshold 
AS --used for creating table with a certain "filter" applied
select * from books
where rental_price > 5

Select * from Threshold

--Task 12: Retrieve the List of Books Not Yet Returned
--TIPS.Check what's on issued_status table and its not in return_status table (LEFT JOIN)
select * from issued_status
select * from return_status

--Searching for NOT returned books
select ist.issued_book_name 
from issued_status as ist
LEFT JOIN
return_status as rst
ON
ist.issued_id = rst.issued_id
WHERE rst.issued_id IS Null

select * from return_status

