--*******************************************************************************
--**  This file is made available under the terms of the Eclipse Public License v1.0
--**  which accompanies this distribution, and is available at
--**  http://www.eclipse.org/legal/epl-v10.html
--*******************************************************************************

DROP INDEX payments_pk;
DROP TABLE Payments;

DROP INDEX employees_pk;
DROP TABLE Employees;

DROP INDEX orderDetails_pk;
DROP TABLE OrderDetails;

DROP INDEX products_pk;
DROP TABLE Products;

DROP INDEX productLines_pk;
DROP TABLE ProductLines;

DROP INDEX orders_pk;
DROP INDEX orders_cutomer;
DROP TABLE Orders;

DROP INDEX customers_pk;
DROP TABLE Customers;

DROP INDEX offices_pk;
DROP TABLE Offices;


CREATE TABLE Offices(
	officeCode VARCHAR(10) NOT NULL,
	city VARCHAR(50),
	phone VARCHAR(50),
	addressLine1 VARCHAR(50),
	addressLine2 VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	postalCode VARCHAR(15),
	territory VARCHAR(10)
);
CREATE UNIQUE INDEX offices_pk ON Offices ( officeCode );
ALTER TABLE Offices ADD PRIMARY KEY (officeCode);

CREATE TABLE Customers(
	customerNumber INTEGER NOT NULL,
	customerName VARCHAR(50),
	contactLastName VARCHAR(50),
	contactFirstName VARCHAR(50),
	phone VARCHAR(50),
	addressLine1 VARCHAR(50),
	addressLine2 VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	postalCode VARCHAR(15),
	country VARCHAR(50),
	salesRepEmployeeNumber INTEGER,
	creditLimit DOUBLE
);
CREATE UNIQUE INDEX customers_pk ON Customers( customerNumber );
ALTER TABLE Customers ADD PRIMARY KEY ( customerNumber );

CREATE TABLE Orders(
	orderNumber INTEGER NOT NULL,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	status VARCHAR(15),
	comments LONG VARCHAR,
	customerNumber INTEGER 
);
CREATE UNIQUE INDEX orders_pk ON Orders( orderNumber );
CREATE INDEX orders_cutomer ON Orders( customerNumber );
ALTER TABLE Orders ADD PRIMARY KEY ( orderNumber );
ALTER TABLE Orders ADD FOREIGN KEY (customerNumber) REFERENCES Customers(customerNumber);

CREATE TABLE ProductLines(
	productLine VARCHAR(50) NOT NULL,
	textDescription VARCHAR(4000),
	htmlDescription CLOB,
	image BLOB
);
CREATE UNIQUE INDEX productLines_pk on ProductLines( productLine );
ALTER TABLE ProductLines ADD PRIMARY KEY ( productLine );

CREATE TABLE Products(
	productCode VARCHAR(15) NOT NULL,
	productName VARCHAR(70),
	productLine VARCHAR(50),
	productScale VARCHAR(10),
	productVendor VARCHAR(50),
	productDescription LONG VARCHAR,
	quantityInStock INTEGER,
	buyPrice DOUBLE,
	MSRP DOUBLE
);
CREATE UNIQUE INDEX products_pk ON Products( productCode );
ALTER TABLE Products ADD PRIMARY KEY ( productCode );
ALTER TABLE Products ADD FOREIGN KEY (productLine) REFERENCES ProductLines(productLine);

CREATE TABLE OrderDetails(
	orderNumber INTEGER NOT NULL,
	productCode VARCHAR(15) NOT NULL,
	quantityOrdered INTEGER,
	priceEach DOUBLE,
	orderLineNumber SMALLINT);
CREATE UNIQUE INDEX orderDetails_pk ON OrderDetails( orderNumber, productCode );
ALTER TABLE OrderDetails ADD PRIMARY KEY ( orderNumber, productCode );
ALTER TABLE OrderDetails ADD FOREIGN KEY (orderNumber) REFERENCES Orders(orderNumber);
ALTER TABLE OrderDetails ADD FOREIGN KEY (productCode) REFERENCES Products(productCode);

CREATE TABLE Employees(
	employeeNumber INTEGER NOT NULL,
	lastName VARCHAR(50),
	firstName VARCHAR(50),
	extension VARCHAR(10),
	email VARCHAR(100),
	officeCode VARCHAR(10),
	reportsTo INTEGER,
	jobTitle VARCHAR(50) 
);
CREATE UNIQUE INDEX employees_pk ON Employees( employeeNumber );
ALTER TABLE Employees ADD PRIMARY KEY ( employeeNumber );
ALTER TABLE Employees ADD FOREIGN KEY (officeCode) REFERENCES Offices(officeCode);

CREATE TABLE Payments(
	customerNumber INTEGER NOT NULL,
	checkNumber VARCHAR(50) NOT NULL,
	paymentDate DATE,
	amount DOUBLE 
);
CREATE UNIQUE INDEX payments_pk ON Payments( customerNumber, checkNumber );
ALTER TABLE Payments ADD PRIMARY KEY ( customerNumber, checkNumber );
ALTER TABLE Payments ADD FOREIGN KEY (customerNumber) REFERENCES Customers(customerNumber);
