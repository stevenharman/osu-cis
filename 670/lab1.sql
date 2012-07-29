/*  Chris Matthew  */
/*  cis 670, Gurari, MWF@10:30  */
/*  Lab #1, assignment #3  */


/****Table Creation*****/

create table borrower (
	card_no numeric(7) primary key,
	name varchar(20),
	address varchar(30),
	phone varchar(20)
)
create table library_branch (
	branchid numeric(4) primary key,
	branchName varchar(15),
	address varchar(25)
)
create table publisher (
	name varchar(20) primary key,
	address varchar(30),
	phone varchar(20)
)
create table book (
	bookid numeric(4) primary key,
	title varchar(20),
	publisherName varchar(20) references publisher(name)
)
create table book_copies (
	bookid numeric(4) references book(bookid),
	branchid numeric(4) references library_branch(branchid),
	no_of_copies smallint,
	primary key (bookid,branchid)
)
create table book_loans (
	bookid numeric(4) references book(bookid),
	branchid numeric(4) references library_branch(branchid),
	card_no numeric(7) references borrower(card_no),
	dateout varchar(10),
	duedate varchar(10),
	primary key (bookid,branchid,card_no)
)
create table book_authors (
	bookid numeric(4) references book(bookid),
	authorName varchar(20),
	primary key (bookid,authorName)
)
go

/*******Insertion of Data******/
insert into borrower
	values (1234567,'Christopher Matthew','1212 This Rd.','888-999-0000')
insert into borrower
	values (1111111,'John Doe','54 18th St.','333-4444')
insert into borrower
	values (2222222,'Jane Doe','22 11th St.','444-2323')
insert into borrower
	values (3333333,'Dimetri Gozon','34 High St.','888-777-6666')
insert into library_branch
	values (1111,'Central','222 West 5th Ave.')
insert into library_branch
	values (2222,'Sharpstown','4444 Peterson Ave.')
insert into library_branch
	values (3333,'Metro','3781 E. First St.')
insert into library_branch
	values (4444,'Downtown','7 West 2nd Street')
insert into publisher
	values ('Addison-Wesley','3434 5th Ave.','1-800-222-3333')
insert into publisher
	values ('My Pub','some bogus addr','1-800-555-1212')
insert into book
	values (9999,'The Lost Tribe','My Pub')
insert into book
	values (8888,'IT','Addison-Wesley')
insert into book
	values (7777,'Pet Cemetary','My Pub')
insert into book
	values (6666,'Stand','My Pub')
insert into book
	values (5555,'Watership Down','Addison-Wesley')
insert into book
	values (7878,'Alas Babalyon','My Pub')
insert into book_copies
	values (9999,2222,34)
insert into book_copies
	values (9999,1111,5)
insert into book_copies
	values (9999,4444,16)
insert into book_copies
	values (8888,2222,3)
insert into book_copies
	values (8888,3333,4)
insert into book_copies
	values (7777,1111,78)
insert into book_copies
	values (7777,2222,33)
insert into book_copies
	values (6666,1111,22)
insert into book_copies
	values (5555,3333,99)
insert into book_copies
	values (7878,2222,3)
insert into book_copies
	values (6666,2222,7)
insert into book_copies
	values (5555,2222,67)
insert into book_copies
	values (7878,3333,22)
insert into book_loans
	values (9999,2222,1234567,'10-10-2001','today')
insert into book_loans
	values (8888,2222,1234567,'some date','today')
insert into book_loans
	values (7777,2222,1234567,'some date','today')
insert into book_loans
	values (6666,2222,1234567,'date','date')
insert into book_loans
	values (5555,2222,1234567,'DATE','yesterday')
insert into book_loans
	values (7878,2222,1234567,'date','today')
insert into book_loans
	values (7777,1111,1111111,'4-14-1999','notToday')
insert into book_loans
	values (6666,1111,2222222,'some d','someother d')
insert into book_loans
	values (5555,3333,1111111,'12-23-00','12-23-01')
insert into book_loans
	values (8888,3333,1111111,'date','today')
insert into book_authors
	values (9999,'Some Dude')
insert into book_authors
	values (8888,'Stephen King')
insert into book_authors
	values (7777,'Stephen King')
insert into book_authors
	values (6666,'Stephen King')
insert into book_authors
	values (5555,'Some other Dude')
insert into book_authors
	values (7878,'Guy Smiley')
go

/******Sybase queries*********/
/*A*/
select no_of_copies as CopiesOfLostTribe@Sharpstown
from library_branch join book_copies
on library_branch.branchid = book_copies.branchid
where branchName = 'Sharpstown' and bookid = (select bookid from book where title = 'The Lost Tribe')

/*B*/
select branchName as Branch_Name, no_of_copies as #CopiesOfTheLostTribe
from book_copies join library_branch
on book_copies.branchid = library_branch.branchid
where bookid = (select bookid from book where title = 'The Lost Tribe')

/*C*/
select name as BorrowerWithNoBooksOut
from borrower
where card_no not in (select card_no from book_loans)

/*D*/
select title as Title, name as Name, borrower.address as Address
from (((book_loans join library_branch on book_loans.branchid = 
library_branch.branchid) join book on book_loans.bookid = book.bookid) 
join borrower on book_loans.card_no = borrower.card_no)
where branchName = 'Sharpstown' and duedate = 'today'

/*E*/
select branchName as Branch_Name, count(*) as #of_Books_Loaned_Out
from book_loans join library_branch on book_loans.branchid = 
library_branch.branchid
group by branchName

/*F*/
select name as Name, address as Address, count(*) as #of_Books_Out
from book_loans join borrower on book_loans.card_no = borrower.card_no
group by name
having count(*) > 5

/*G*/
select title as Books_by_Stephen_King, no_of_copies as #of_Copies@Central
from ((book_copies join book on book_copies.bookid = book.bookid) join 
book_authors on book_copies.bookid = book_authors.bookid)
where authorName = 'Stephen King' and branchid = (select branchid from 
library_branch where branchName = 'Central')

go

/*Drop the tables*/
drop table book_authors
drop table book_loans
drop table book_copies
drop table book
drop table publisher
drop table library_branch
drop table borrower
go
