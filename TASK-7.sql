create database view;
use view;

CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT
);

CREATE TABLE Orderss (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer (customer_id, name, city) VALUES
(1, 'Ankita Samal', 'Delhi'),
(2, 'Rahul Verma', 'Mumbai'),
(3, 'Priya Sharma', 'Delhi'),
(4, 'Amit Singh', 'Bangalore'),
(5, 'Neha Gupta', 'Kolkata');

INSERT INTO Orderss (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-08-01', 2500.00),
(102, 2, '2025-08-03', 1200.50),
(103, 1, '2025-08-05', 500.00),
(104, 3, '2025-08-06', 3200.75),
(105, 4, '2025-08-07', 1800.00),
(106, 5, '2025-08-10', 700.25);


CREATE VIEW CustomerOrderss AS
SELECT 
    c.name AS CustomerName,
    c.city AS City,
    o.order_id AS OrderID,
    o.order_date AS OrderDate,
    o.total_amount AS TotalAmount
FROM Customer c
JOIN Orderss o ON c.customer_id = o.customer_id;

SELECT * 
FROM CustomerOrderss
WHERE City = 'Delhi'
ORDER BY TotalAmount DESC;


CREATE OR REPLACE VIEW CustomerOrderss AS
SELECT 
    c.name AS CustomerName,
    c.city AS City,
    o.order_id AS OrderID,
    o.total_amount AS TotalAmount
FROM Customer c
JOIN Orderss o ON c.customer_id = o.customer_id
WHERE o.total_amount > 1000;

SELECT CustomerName, City, OrderID, TotalAmount
FROM CustomerOrderss
WHERE TotalAmount > 2000;


SELECT * 
FROM CustomerOrderss
WHERE City = 'kolkata'
ORDER BY TotalAmount DESC;

DELIMITER $$

CREATE PROCEDURE GetOrderssByCustomer(IN cust_id INT)
BEGIN
    SELECT OrderID, Amount, OrderDate
    FROM Orderss
    WHERE CustomerID = cust_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION GetTotalSpentByCustomer(cust_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(10,2);

    SELECT SUM(Amount) INTO total_spent
    FROM Orderss
    WHERE CustomerID = cust_id;

    RETURN IFNULL(total_spent, 0);
END $$

DELIMITER ;

