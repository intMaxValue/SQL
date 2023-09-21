
CREATE TABLE ItemTypes (
    ItemTypeID INT PRIMARY KEY,
    [Name] NVARCHAR(50)
);


CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    [Name] NVARCHAR(50),
    ItemTypeID INT
);


CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    [Name] NVARCHAR(50)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    [Name] NVARCHAR(50),
    Birthday DATE,
    CityID INT
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT
);


CREATE TABLE OrderItems (
    OrderID INT,
    ItemID INT,
    PRIMARY KEY (OrderID, ItemID)
);


ALTER TABLE Items
ADD FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID);

ALTER TABLE Customers
ADD FOREIGN KEY (CityID) REFERENCES Cities(CityID);

ALTER TABLE Orders
ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE OrderItems
ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

ALTER TABLE OrderItems
ADD FOREIGN KEY (ItemID) REFERENCES Items(ItemID);
