-- Data Definition Language (DDL)

-- Create Table
-- Syntax:
-- Create TABLE table_name (col_name_1 DATATYPE, col_name_2 DATATYPE, etc)
-- table_name ->  all lower case and singular

-- create a table for our blog user
CREATE TABLE IF NOT EXISTS blog_user (
	-- column name DataType <Constraints>
	user_id SERIAL PRIMARY KEY, -- PRIOMARY KEY makes sure COLUMN IS BOTH UNIQUE AND NOT NULL 
	username VARCHAR(25) NOT NULL UNIQUE,
	pw_hash varchar NOT NULL,
	first_name varchar(50), -- * WITHOUT specifying, can be nullor NOT unique
	last_name varchar(50),
	email varchar(50) NOT null
);

SELECT * 
FROM blog_user;


-- to make any changes to a table after its creation, use the alter command

-- rename a column
-- Syntax:
-- ALTER TABLE table_name RENAME COLUMN current_column_name TO new_column_name
ALTER TABLE blog_user 
RENAME COLUMN email TO email_address;

-- add a column:
-- Syntax:
-- ALTER TABLE table_naem ADD COLUMN new_column_name DATATYPE
ALTER TABLE blog_user 
ADD COLUMN IF NOT EXISTS middle_name varchar;

SELECT * 
FROM blog_user;

-- change a columns DATATYPE
-- Syntax:
-- ALTER TABLE table_name ALTER COLUMN col_name TYPE new_datatype;
ALTER TABLE blog_user 
ALTER COLUMN email_address TYPE varchar(30);

SELECT * 
FROM blog_user;

-- create Post Table with a FK to Blog User Table;
CREATE TABLE IF NOT EXISTS post (
	post_id serial PRIMARY KEY, 
	title varchar(50) NOT NULL,
	body varchar NOT NULL, 
	date_created timestamp DEFAULT current_timestamp,
	-- Step 1: Create the column alone
	user_id integer NOT NULL,
	-- Step 2: Add Foreign Key to the new column
	-- Syntax:
	-- FOREIGN KEY(col_in_domestic_table) REFERENCES foreign_table_name(col_in_foreign_table)
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id)
);

SELECT * 
FROM post;

-- create the post category table
CREATE TABLE IF NOT EXISTS post_category (
	post_id integer NOT NULL,
	FOREIGN KEY(post_id) REFERENCES post(post_id),
	category_id integer NOT NULL
	-- FOREIGN KEY(category_id) REFERENCES category(category_id) -- cannot reference a table that does not exist
);

SELECT * 
FROM post_category;

-- Create the category table
CREATE TABLE IF NOT EXISTS category (
	category_id SERIAL PRIMARY KEY,
	category_name varchar(25) NOT NULL,
	description varchar NOT NULL
)

-- Now that the category table is created, we can add the FK from post_category
-- ALter Table table_name
-- ADD FOREIGN KEY(col_in_domestic_table) REFERENCES foreign_table_name(col_in_foreign_table)
ALTER TABLE post_category 
ADD FOREIGN KEY(category_id) REFERENCES category(category_id);

-- create comment table
CREATE TABLE IF NOT EXISTS post_comment(
	comment_id SERIAL PRIMARY KEY, 
	body varchar NOT NULL,
	date_created timestamp DEFAULT current_timestamp,
	user_id integer NOT NULL,
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id),
	post_id integer NOT NULL, 
	FOREIGN KEY(post_id) REFERENCES post(post_id)
);


-- create table to be deleted
CREATE TABLE delete_me (
	test_id serial PRIMARY KEY, 
	col_1 integer, 
	col_2 boolean
);

SELECT * 
FROM delete_me;

-- Remove a column from a table
 -- Syntax:
-- ALTER TABLE table_name DROP COLUMN col_name;
ALTER TABLE delete_me 
DROP COLUMN col_1;

SELECT * 
FROM delete_me;

-- Remove a table completely
-- Syntax:
-- DROP TABLE **OPTIONAL**//IF EXISTS//**OPTIONAL** table_name
DROP TABLE IF EXISTS delete_me;


