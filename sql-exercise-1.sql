-- SQL Exercise

-- ------------------------------------------------------------------
-- 1. Database and Table Creation
-- ------------------------------------------------------------------

CREATE DATABASE commercial;
USE commercial;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255)
);

CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255),
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ------------------------------------------------------------------
-- 2. Insert Data
-- ------------------------------------------------------------------

INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES
('Alice Johnson', 'Alice J.', '123 Maple St.', 'Springfield', '12345', 'USA'),
('Bob Smith', 'Bob S.', '456 Oak Ave.', 'Shelbyville', '67890', 'USA'),
('Charlie Brown', 'Charlie B.', '789 Pine Rd.', 'Ogdenville', '13579', 'USA'),
('Diana Prince', 'Diana P.', '101 Hero Lane', 'Themyscira', '99999', 'Greece'),
('Ethan Hunt', 'E. Hunt', '32 Spy Blvd.', 'Mission City', '55555', 'USA'),
('Frodo Baggins', 'Frodo B.', '22 Bagshot Row', 'Hobbiton', '33333', 'Middle-Earth'),
('Gordon Freeman', 'G. Freeman', '17 Black Mesa Dr.', 'Xen City', '11111', 'Earth'),
('Harley Quinn', 'Harley Q.', '88 Joker St.', 'Gotham', '44444', 'USA'),
('Isabella Swan', 'Bella S.', '50 Vampire Rd.', 'Forks', '77777', 'USA'),
('Zenith Corp', 'Jack S.', '99 Pirate Bay', 'Tortuga', '66666', 'Caribbean');

INSERT INTO Categories (CategoryName)
VALUES
('Electronics'),
('Books'),
('Clothing'),
('Home Appliances');

INSERT INTO Suppliers (SupplierName, ContactName, Address, City, PostalCode, Country)
VALUES
('TechCorp', 'John Doe', '12 Silicon Way', 'Tech City', '10101', 'USA'),
('GadgetSupply', 'Jane Smith', '34 Innovation Blvd', 'Gadget Town', '20202', 'USA'),
('BookWorld', 'Emily Davis', '56 Book St.', 'Novel City', '30303', 'USA'),
('FashionLine', 'Michael Brown', '78 Style Ave.', 'Fashion City', '40404', 'USA'),
('HomePlus', 'Sarah Wilson', '90 Comfort Rd.', 'Home Town', '50505', 'USA');

INSERT INTO Products (ProductName, SupplierID, CategoryID, Price)
VALUES
('Smartphone', 1, 1, 699.99),
('Laptop', 2, 1, 999.99),
('Novel', 3, 2, 19.99),
('T-shirt', 4, 3, 9.99),
('Microwave', 5, 4, 129.99);

INSERT INTO Orders (CustomerID, OrderDate)
VALUES
(1, '2024-01-01'),
(2, '2024-01-15'),
(3, '2024-01-20');

INSERT INTO OrderDetails (OrderID, ProductID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5);

-- ------------------------------------------------------------------
-- 3. Select Queries
-- ------------------------------------------------------------------

SELECT * FROM Products;

SELECT * FROM Products WHERE ProductName='Smartphone';

SELECT * FROM Products WHERE ProductName LIKE '%phone';

SELECT * FROM Products WHERE ProductName LIKE 'Smart%';

SELECT * FROM Products WHERE ProductName LIKE 'Smart_____';

SELECT * FROM Products WHERE ProductName IN ('Smartphone', 'Laptop');

-- ------------------------------------------------------------------
-- 4. JOIN Queries
-- ------------------------------------------------------------------

SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- ------------------------------------------------------------------
-- 5. Nested Query
-- ------------------------------------------------------------------

SELECT ProductName AS Product 
FROM Products 
WHERE ProductID = (SELECT MIN(ProductID) FROM Products);

-- ------------------------------------------------------------------
-- 6. Update and Delete
-- ------------------------------------------------------------------

UPDATE Products SET ProductName='Book' WHERE ProductName='Novel';

DELETE FROM Customers WHERE CustomerName='Zenith Corp';	

-- ------------------------------------------------------------------
-- 7. Sorting and Grouping
-- ------------------------------------------------------------------

SELECT MIN(ProductID) AS MinProductID, MAX(ProductID) AS MaxProductID FROM Products;

SELECT * FROM Products ORDER BY Price DESC;

-- SQL Exercise 2

-- ------------------------------------------------------------------
-- 7. Table Update
-- ------------------------------------------------------------------

ALTER TABLE Suppliers
ADD COLUMN ParentSupplierID INT; 

ALTER TABLE Suppliers
ADD CONSTRAINT FK_ParentSupplier
    FOREIGN KEY (ParentSupplierID) REFERENCES Suppliers(SupplierID) ON DELETE SET NULL;
    
UPDATE Suppliers
SET ParentSupplierID = NULL
WHERE SupplierName = 'TechCorp';

UPDATE Suppliers
SET ParentSupplierID = 1
WHERE SupplierName IN ('GadgetSupply', 'BookWorld');

UPDATE Suppliers
SET ParentSupplierID = 2
WHERE SupplierName IN ('FashionLine', 'HomePlus');

-- ------------------------------------------------------------------
-- 4. JOIN Queries - Self Join
-- ------------------------------------------------------------------

SELECT S1.SupplierName AS SubCorp, S2.SupplierName AS ParentCorp FROM Suppliers S1  INNER JOIN Suppliers S2 ON S1.ParentSupplierId = S2.SupplierID;