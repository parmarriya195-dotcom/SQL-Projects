CREATE DATABASE Project2;
USE Project2;

CREATE TABLE Customers(
CustomerID  INT PRIMARY KEY,
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100),
Email VARCHAR(100) UNIQUE NOT NULL,
RegistrationDate date
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, RegistrationDate)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
(3, 'Amit', 'Shah', 'amit.shah@email.com', '2023-01-10'),
(4, 'Priya', 'Patel', 'priya.patel@email.com', '2022-07-22'),
(5, 'Rahul', 'Verma', 'rahul.verma@email.com', '2023-05-18'),
(6, 'Neha', 'Joshi', 'neha.joshi@email.com', '2022-09-30');

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-07-10', 320.00),
(104, 3, '2023-07-12', 90.00),
(105, 4, '2023-07-15', 500.00),
(106, 5, '2023-07-18', 1200.00),
(107, 6, '2023-07-20', 700.00),
(108, 2, '2023-07-22', 450.00);

CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR (100) NOT NULL,
LastName VARCHAR (100),
Department VARCHAR (50),
HireDate DATE,
Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary)
VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000),
(3, 'Raj', 'Mehta', 'IT', '2019-06-10', 75000),
(4, 'Anjali', 'Desai', 'Finance', '2022-02-01', 60000),
(5, 'Karan', 'Malhotra', 'Sales', '2018-11-25', 80000);

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Employees;

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (
    SELECT AVG(TotalAmount) FROM Orders
);

SELECT *
FROM Employees
WHERE Salary > (
	SELECT AVG(Salary) FROM Employees
);

SELECT OrderID, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth
FROM Orders;

SELECT OrderID, DATEDIFF(CURRENT_DATE(), OrderDate) AS DateDifference
FROM Orders;

SELECT OrderID, DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
FROM Orders;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

SELECT FirstName,
REPLACE(FirstName, 'a', '@') AS UpdatedName
FROM Customers;

SELECT UPPER(FirstName) AS FirstName_Upper,
       LOWER(LastName) AS LastName_Lower
FROM Customers;

SELECT TRIM(Email) AS CleanEmail
FROM Customers;

SELECT 
    OrderID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders;
  
SELECT OrderID, TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS Rank_Position
FROM Orders;

SELECT OrderID, TotalAmount,
CASE
    WHEN TotalAmount > 1000 THEN '10%'
    WHEN TotalAmount BETWEEN 501 AND 1000 THEN '5%'
    ELSE '0%'
END AS Discount
FROM Orders;

SELECT FirstName, Salary,
CASE
    WHEN Salary <= 50000 THEN 'Low'
    WHEN Salary <= 70000 THEN 'Medium'
    ELSE 'High'
END AS SalaryCategory
FROM Employees;