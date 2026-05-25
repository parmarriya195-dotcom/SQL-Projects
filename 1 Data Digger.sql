CREATE DATABASE project1;
USE project1;

CREATE TABLE Customer(
CustomerID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(100),
Address VARCHAR(100)
);

INSERT INTO Customer(CustomerID, Name, Email, Address) 
VALUES
(1, 'Alice', 'alice@gmail.com', 'Delhi'),
(2, 'Bob', 'bob@gmail.com', 'Mumbai'),
(3, 'Charlie', 'charlie@gmail.com', 'Pune'),
(4, 'David', 'david@gmail.com', 'Ahmedabad'),
(5, 'Alice', 'alice2@gmail.com', 'Rajkot');

SELECT * FROM customer;

UPDATE Customer
SET Address = 'Rajkot'
WHERE CustomerID = 1;

DELETE FROM Customer WHERE CustomerID = 3;

SELECT * FROM Customer WHERE Name = 'Alice';

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Orders(OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES
(101, 1, '2025-03-01', 500),
(102, 2, '2025-03-05', 1200),
(103, 1, '2025-03-10', 800),
(104, 4, '2025-03-15', 1500),
(105, 5, '2025-03-20', 700);

SELECT * FROM Orders WHERE CustomerID = 1;

UPDATE Orders 
SET TotalAmount = 1000
WHERE OrderID = 105;

DELETE FROM Orders WHERE OrderID = 102;

SELECT * FROM Orders WHERE OrderDate > '2025-03-05';

SELECT MAX(TotalAmount) FROM Orders;
SELECT MIN(TotalAmount) FROM Orders;
SELECT AVG(TotalAmount) FROM Orders;
SELECT SUM(TotalAmount) FROM Orders;

CREATE TABLE Product(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2),
Stock INT
);

INSERT INTO Product(ProductID, ProductName, Price, Stock) 
VALUES
(1, 'Laptop', 55000, 10),
(2, 'Phone', 20000, 15),
(3, 'Tablet', 15000, 5),
(4, 'Headphones', 2000, 0),
(5, 'Keyboard', 800, 20);

SELECT * FROM Product
ORDER BY Price DESC;

UPDATE Product 
SET Price = 60000
WHERE ProductID = 1;

DELETE FROM Product WHERE Stock = 0;

SELECT * FROM Product WHERE Price BETWEEN 500 AND 2000;

SELECT MAX(Price) FROM Product;
SELECT MIN(Price) FROM Product;

CREATE TABLE OrderDetail(
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT, 
SubTotal DECIMAL(10,2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO OrderDetail(OrderDetailID, OrderID, ProductID, Quantity, SubTotal) 
VALUES
(1, 101, 1, 1, 55000),
(2, 103, 2, 2, 40000),
(3, 104, 3, 1, 15000),
(4, 105, 1, 1, 55000),
(5, 101, 5, 2, 1600);

SELECT * FROM OrderDetail WHERE OrderID = 105;

SELECT SUM(SubTotal) AS TotalRevenue FROM OrderDetail;

SELECT ProductID, SUM(Quantity) FROM OrderDetail
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC
LIMIT 3;

SELECT ProductID, COUNT(*) FROM OrderDetail
GROUP BY ProductID;
