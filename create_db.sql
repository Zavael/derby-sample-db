--*******************************************************************************
--**  This file is made available under the terms of the Eclipse Public License v1.0
--**  which accompanies this distribution, and is available at
--**  http://www.eclipse.org/legal/epl-v10.html
--*******************************************************************************

DROP INDEX payment_pk;
DROP TABLE payment;

DROP INDEX employee_pk;
DROP TABLE employee;

DROP INDEX order_detail_pk;
DROP TABLE order_detail;

DROP INDEX product_pk;
DROP TABLE product;

DROP INDEX product_line_pk;
DROP TABLE product_line;

DROP INDEX order_pk;
DROP INDEX order_customer;
DROP TABLE purchase_order;

DROP INDEX customer_pk;
DROP TABLE customer;

DROP INDEX office_pk;
DROP TABLE office;


CREATE TABLE office(
  office_code VARCHAR(10) NOT NULL,
	city VARCHAR(50),
	phone VARCHAR(50),
	address_line1 VARCHAR(50),
	address_line2 VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	postal_code VARCHAR(15),
	territory VARCHAR(10)
);
CREATE UNIQUE INDEX office_pk ON office (office_code);
ALTER TABLE office ADD PRIMARY KEY (office_code);

CREATE TABLE customer(
	customer_number INTEGER NOT NULL,
	customer_name VARCHAR(50),
	contact_last_name VARCHAR(50),
	contact_first_name VARCHAR(50),
	phone VARCHAR(50),
	address_line1 VARCHAR(50),
	address_line2 VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	postal_code VARCHAR(15),
	country VARCHAR(50),
	sales_rep_employee_number INTEGER,
	credit_limit DOUBLE
);
CREATE UNIQUE INDEX customer_pk ON customer(customer_number);
ALTER TABLE customer ADD PRIMARY KEY ( customer_number );

CREATE TABLE purchase_order(
	order_number INTEGER NOT NULL,
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	status VARCHAR(15),
	comments LONG VARCHAR,
	customer_number INTEGER 
);
CREATE UNIQUE INDEX order_pk ON purchase_order(order_number);
CREATE INDEX order_customer ON purchase_order(customer_number);
ALTER TABLE purchase_order ADD PRIMARY KEY (order_number);
ALTER TABLE purchase_order ADD FOREIGN KEY (customer_number) REFERENCES customer(customer_number);

CREATE TABLE product_line(
	product_line VARCHAR(50) NOT NULL,
	text_description VARCHAR(4000),
	html_description CLOB,
	image BLOB
);
CREATE UNIQUE INDEX product_line_pk on product_line(product_line);
ALTER TABLE product_line ADD PRIMARY KEY (product_line);

CREATE TABLE product(
	product_code VARCHAR(15) NOT NULL,
	product_name VARCHAR(70),
	product_line VARCHAR(50),
	product_scale VARCHAR(10),
	product_vendor VARCHAR(50),
	product_description LONG VARCHAR,
	quantity_in_stock INTEGER,
	buy_price DOUBLE,
	MSRP DOUBLE
);
CREATE UNIQUE INDEX product_pk ON product(product_code);
ALTER TABLE product ADD PRIMARY KEY (product_code);
ALTER TABLE product ADD FOREIGN KEY (product_line) REFERENCES product_line(product_line);

CREATE TABLE order_detail(
	order_number INTEGER NOT NULL,
	product_code VARCHAR(15) NOT NULL,
	quantity_ordered INTEGER,
	price_each DOUBLE,
	order_line_number SMALLINT);
CREATE UNIQUE INDEX order_detail_pk ON order_detail(order_number, product_code);
ALTER TABLE order_detail ADD PRIMARY KEY (order_number, product_code);
ALTER TABLE order_detail ADD FOREIGN KEY (order_number) REFERENCES purchase_order(order_number);
ALTER TABLE order_detail ADD FOREIGN KEY (product_code) REFERENCES product(product_code);

CREATE TABLE employee(
	employee_number INTEGER NOT NULL,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	extension VARCHAR(10),
	email VARCHAR(100),
	office_code VARCHAR(10),
	reports_to INTEGER,
	job_title VARCHAR(50) 
);
CREATE UNIQUE INDEX employee_pk ON employee(employee_number);
ALTER TABLE employee ADD PRIMARY KEY (employee_number);
ALTER TABLE employee ADD FOREIGN KEY (office_code) REFERENCES office(office_code);

CREATE TABLE payment(
	customer_number INTEGER NOT NULL,
	check_number VARCHAR(50) NOT NULL,
	payment_date DATE,
	amount DOUBLE 
);
CREATE UNIQUE INDEX payment_pk ON payment(customer_number, check_number);
ALTER TABLE payment ADD PRIMARY KEY (customer_number, check_number);
ALTER TABLE payment ADD FOREIGN KEY (customer_number) REFERENCES customer(customer_number);




