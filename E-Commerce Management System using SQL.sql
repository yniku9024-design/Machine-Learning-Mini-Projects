
CREATE TABLE Customers(
Customer_id INT PRIMARY KEY ,
Customer_Name VARCHAR(150) NOT NULL,
Email VARCHAR(100) UNIQUE,
Phone VARCHAR(100),
City VARCHAR(100),
RegistrationDate DATE
);

CREATE TABLE Category(
Category_id INT PRIMARY KEY,
Category_name VARCHAR(150) NOT NULL
);

CREATE TABLE Product(
Product_id INT PRIMARY KEY,
Product_name VARCHAR(150) NOT NULL,
Price INT CHECK(Price > 0),
Stock INT CHECK(Stock > 0),
Category_id INT,
FOREIGN KEY (Category_id) references Customers(Customer_id)
);

CREATE TABLE OrderT(
Order_id INT PRIMARY KEY ,
Customer_id INT NOT NULL,
OrderDate DATE,
Status VARCHAR(150) default 'Pending',
FOREIGN KEY(Customer_id) references Customers(Customer_id)
);

CREATE TABLE OrderDetails(
OrderDetail_id INT PRIMARY KEY,
Order_id INT NOT NULL,
Product_id INT NOT NULL,
Quantity INT CHECK(QUANTITY > 0),
FOREIGN KEY(Order_id) references OrderT(Order_id),
FOREIGN KEY(Product_id) references Product(Product_id)
);

CREATE TABLE Payment(
Payment_id INT PRIMARY KEY,
Amount INT NOT NULL,
Payment_method VARCHAR(150),
Order_id INT NOT NULL,
FOREIGN KEY(Order_id) references OrderT(Order_id)
);

INSERT INTO Category(Category_id,Category_name)
VALUES (1,'Electronics'),
(2,'Clothing'),
(3,'Books'),
(4,'Furniture'),
(5,'Sports');


INSERT INTO Customers(Customer_id,Customer_Name,Email,City)
VALUES
(1,'Rahul Sharma','rahul@gmail.com','Delhi'),
(2,'Priya Singh','priya@gmail.com','Mumbai'),
(3,'Aman Gupta','aman@gmail.com','Chandigarh'),
(4,'Neha Verma','neha@gmail.com','Jaipur'),
(5,'Rohit Yadav','rohit@gmail.com','Lucknow');

INSERT INTO Payment(Payment_id, Order_id, Amount, Payment_method)
VALUES
(1, 101, 66000, 'UPI'),
(2, 102, 30000, 'Card'),
(3, 103, 2400, 'Cash'),
(4, 104, 4000, 'UPI'),
(5, 105, 4500, 'Card');
    
INSERT INTO OrderDetails(OrderDetail_id, Order_id, Product_id, Quantity)
VALUES
(1, 101, 1, 1),
(2, 101, 4, 2),
(3, 102, 2, 1),
(4, 103, 3, 3),
(5, 104, 6, 2),
(6, 105, 5, 1);
    
INSERT INTO OrderT(Order_id, Customer_id, OrderDate, Status)
VALUES
(101, 1, '2026-05-01', 'Delivered'),
(102, 2, '2026-05-02', 'Delivered'),
(103, 3, '2026-05-03', 'Pending'),
(104, 1, '2026-05-04', 'Delivered'),
(105, 4, '2026-05-05', 'Cancelled');
    
    
INSERT INTO Product(Product_id, Product_name, Price, Stock, Category_id)
VALUES
(1, 'Laptop', 65000, 20, 1),
(2, 'Smartphone', 30000, 50, 1),
(3, 'T-Shirt', 800, 100, 2),
(4, 'SQL Book', 500, 70, 3),
(5, 'Study Table', 4500, 15, 4),
(6, 'Cricket Bat', 2000, 25, 5);

-- Showing All Customers
Select * from Customers;

-- Shows Product_name and price
Select Product_name,Price from Product;

-- -- Showing product whose price is more than 5000
Select Product_name From Product Where Price > 5000;

-- customer from Delhi
Select * FROM Customers Where City = 'Delhi';

-- Product sorted by price in desc
Select * from Product Order By Price DESC;

-- Top 3 expensive product 
Select Product_name,Price from Product Order BY Price DESC limit 3; 

-- product whose stock < 20
Select Product_name,Price,Stock From Product Where Stock < 20;

-- All orders whose status is Delivered
Select * From OrderT Where Status = 'Delivered';

-- Count all customers 
Select count(Customer_id) as Total_Customers From customers;

-- Average Product Price
Select avg(Price) as Avg_Price From Product;

Select max(Price) as Max_Price From Product;

-- Total Revenue
Select * From Payment;
Select sum(Amount)  as Total_Revenue From Payment;

-- Order placed by each customers
Select * From OrderT;
Select Customer_id,count(Customer_id) From OrderT GROUP BY Customer_id;

Select Customer_id,count(Customer_id) From OrderT GROUP BY Customer_id
HAVING count(Customer_id) > 1;


-- Number of Products in each Category
Select * From Product;
Select Category_id,count(Category_id) From Product GROUP BY Category_id;

-- Display customer_name with Order_id
Select C.customer_name,O.Order_id From Customers as C INNER join
OrderT as O on C.Customer_id = O.Customer_id;

-- Display customer_name,Product_name,Quantity
Select C.customer_name,A.Order_id,P.Product_name,O.Quantity From ((customers as C 
INNER jOIN OrderT as A
ON A.Customer_id = C.Customer_id) as B
INNER Join OrderDetails as O 
ON B.Order_id = O.Order_id) as F
INNER Join Product as P 
ON F.Product_id = P.Product_id;


-- Total amount spent by each Customer
Select C.Customer_id,sum(P.Amount),O.Order_id From (Customers as C 
INNER JOIN OrderT as O  
ON C.Customer_id = O.Customer_id) as A
INNER JOIN Payment as P 
ON A.Order_id = P.Order_id 
GROUP BY A.Customer_id;

-- Find Product Whose Price is greater than Average Product Price
Select Product_id,Product_name as average_price From Product
Where Price > (Select avg(price) from Product);

-- Products that never ordered
Select Product_id,Product_name from Product 
where Product_id Not IN (Select Product_id from OrderDetails);

-- Best Selling Product_id
Select P.Product_id,Product_name,Price,Quantity,Price*Quantity as Total_cost 
from Product as P INNER JOIN OrderDetails as OD 
ON P.Product_id = OD.Product_id
Order BY Total_cost DESC Limit 1;


-- Highest Spending Customer
Select C.customer_name,ot.Order_id, Sum(Amount) as Amount from
(customers as C inner join OrderT as ot on C.Customer_id = ot.Customer_id) as A
inner join Payment as P on P.Order_id = A.Order_id
GROUP BY customer_name ORDER BY Amount DESC LIMIT 1;

























