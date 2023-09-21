CREATE TABLE [Categories] (
			 [Id] INT IDENTITY PRIMARY KEY,
			 [CategoryName] NVARCHAR(50) NOT NULL,
			 [DailyRate] DECIMAL(8,2) NOT NULL,
			 [WeeklyRate] DECIMAL(8,2) NOT NULL,
			 [MonthlyRate] DECIMAL(8,2) NOT NULL,
			 [WeekendRate] DECIMAL(8,2) NOT NULL,
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
	 VALUES 
			('Compact', 35.00, 200.00, 750.00, 40.00),
			('SUV', 55.00, 300.00, 1100.00, 60.00),
			('Luxury', 85.00, 500.00, 1900.00, 100.00)


CREATE TABLE [Cars](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [PlateNumber] NVARCHAR(20) NOT NULL,
			 [Manufacturer] NVARCHAR(50) NOT NULL,
			 [Model] NVARCHAR(50) NOT NULL,
			 [CarYear] INT NOT NULL,
			 [CategoryID] INT NOT NULL,
			 [Doors] INT NOT NULL,
			 [Picture] IMAGE,
			 [Condition] NVARCHAR(50),
			 [Available] BIT NOT NULL
)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Condition, Available)
VALUES
    ('ABC123', 'Toyota', 'Corolla', 2022, 1, 4, 'Excellent', 1),
    ('XYZ456', 'Ford', 'Explorer', 2021, 2, 4, 'Good', 1),
    ('DEF789', 'BMW', 'X5', 2020, 3, 4, 'Like New', 1)


CREATE TABLE [Employees](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [FirstName] NVARCHAR(50) NOT NULL,
			 [LastName] NVARCHAR(50) NOT NULL,
			 [Title] NVARCHAR(50),
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO Employees (FirstName, LastName, Title, Notes)
	 VALUES
			('John', 'Smith', 'Manager', 'Notes about bla-bla'),
			('Jane', 'Smith', 'Sales Associate', 'Notes bla-bla'),
			('Robert', 'Downey', 'Technician', 'Notes bla-bla')



CREATE TABLE [Customers](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [DriverLicenseNumber] NVARCHAR(50) NOT NULL,
			 [FullName] NVARCHAR(100) NOT NULL,
			 [Address] NVARCHAR(100),
			 [City] NVARCHAR(50),
			 [ZIPCode] NVARCHAR(25),
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO Customers(DriverLicenseNumber, FullName, Address, City, ZIPCode, Notes)
	 VALUES
			('DL12345', 'Alice Johnson', '123 Main St', 'New York', '10001', 'Notes about bla-bla'),
			('DL67890', 'Bob Smith', '456 Elm St', 'Los Angeles', '90001', 'Notes bla-bla'),
			('DL24680', 'Charlie Brown', '789 Oak St', 'Chicago', '60601', 'Notes about bla-bla')




CREATE TABLE [RentalOrders](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [EmployeeId] INT NOT NULL,
			 [CustomerId] INT NOT NULL,
			 [CarId] INT NOT NULL,
			 [TankLevel] DECIMAL(5,2),
			 [KilometrageStart] INT,
			 [KilometrageEnd] INT,
			 [TotalKilometrage] INT,
			 [StartDate] DATE NOT NULL,
			 [EndDate] DATE NOT NULL,
			 [TotalDays] INT,
			 [RateApplied] DECIMAL(10, 2),
			 [TaxRate] DECIMAL(10, 2),
			 [OrderStatus] NVARCHAR(100),
			 [Notes] NVARCHAR(MAX)

CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId)
REFERENCES [Employees](Id),

CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId)
REFERENCES Customers(Id),

CONSTRAINT FK_Cars FOREIGN KEY (CarId)
REFERENCES Cars(Id)
)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
    (1, 1, 1, 90.5, 10000, 10200, 200, '2023-09-01', '2023-09-05', 5, 200.00, 10.00, 'Completed', 'Notes'),
    (2, 2, 2, 75.0, 5000, 5200, 200, '2023-09-02', '2023-09-06', 4, 240.00, 11.00, 'Completed', 'Notes'),
    (3, 3, 3, 95.5, 8000, 8300, 300, '2023-09-03', '2023-09-07', 4, 340.00, 12.00, 'Completed', 'Notes blaa');

