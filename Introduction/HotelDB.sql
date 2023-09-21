CREATE TABLE [Employees](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [FirstName] NVARCHAR(50) NOT NULL,
			 [LastName] NVARCHAR(50) NOT NULL,
			 [Title] NVARCHAR(50),
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes)
	 VALUES 
			('Gosho', 'Georgiev', 'Manager', 'bla-bla'),
			('Pesho', 'Georgiev', 'Receptionist', 'bla-bla'),
			('Irina', 'Georgieva', 'Housekeeper', 'bla-bla')


CREATE TABLE Customers(
			 [AccountNumber] INT PRIMARY KEY,
			 [FirstName] NVARCHAR(50) NOT NULL,
			 [LastName] NVARCHAR(50) NOT NULL,
			 [PhoneNumber] NVARCHAR(25),
			 [EmergencyName] NVARCHAR(100),
			 [EmergencyNumber] NVARCHAR(25),
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO Customers(AccountNumber, FirstName, LastName,PhoneNumber, EmergencyName, EmergencyNumber, Notes)
	 VALUES
			('001', 'Alice', 'Johnson', '555-123-4567', 'Bob Smith', '555-987-6543', 'Notes'),
			('002', 'Bob', 'Smith', '555-987-6543', 'Alice Johnson', '555-123-4567', 'Notes'),
			('003', 'Charlie', 'Brown', NULL, 'David Williams', '555-222-3333', 'Notes')


CREATE TABLE RoomStatus(
			 [RoomStatus] NVARCHAR(50) PRIMARY KEY,
			 [Notes] NVARCHAR(MAX),
)

INSERT INTO RoomStatus
	 VALUES
			('Vacant', 'The room is vacant and available for booking'),
			('Occupied', 'The room is currently occupied by a guest'),
			('Maintenance', 'The room is undergoing maintenance');



CREATE TABLE RoomTypes(
			 [RoomType] NVARCHAR(50) PRIMARY KEY,
			 [Notes] NVARCHAR(MAX),
)

INSERT INTO RoomTypes(RoomType, Notes)
	 VALUES
			('Standard', 'A standard room with basic amenities'),
			('Suite', 'A luxurious suite with additional space and amenities'),
			('Deluxe', 'A deluxe room with premium features');



CREATE TABLE BedTypes(
			 [BedType] NVARCHAR(50) PRIMARY KEY,
			 [Notes] NVARCHAR(MAX),
)

INSERT INTO BedTypes
	 VALUES
			('Single', 'A room with a single bed'),
			('Double', 'A room with a double bed'),
			('King', 'A room with a king-sized bed');


CREATE TABLE Rooms(
			 [RoomNumber] INT PRIMARY KEY,
			 [RoomType] NVARCHAR(50) NOT NULL,
			 [BedType] NVARCHAR(50) NOT NULL,
			 [Rate] DECIMAL(8,2) NOT NULL,
			 [RoomStatus] NVARCHAR(50) NOT NULL,
			 [Notes] NVARCHAR(MAX)

CONSTRAINT FK_RoomType FOREIGN KEY(RoomType)
REFERENCES RoomTypes(RoomType),

CONSTRAINT FK_BedType FOREIGN KEY(BedType)
REFERENCES BedTypes(BedType),

CONSTRAINT FK_RoomStatus FOREIGN KEY(RoomStatus)
REFERENCES RoomStatus(RoomStatus)
)

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
	 VALUES
			(101, 'Standard', 'Single', 100.00, 'Vacant', 'Notes about Room 101'),
			(202, 'Deluxe', 'King', 200.00, 'Occupied', 'Notes about Room 202'),
			(303, 'Suite', 'Double', 150.00, 'Vacant', 'Notes about Room 303')


CREATE TABLE Payments(
			 [Id] INT IDENTITY PRIMARY KEY,
			 [EmployeeId] INT NOT NULL,
			 [PaymentDate] DATE NOT NULL,
			 [AccountNumber] INT NOT NULL,
--????--
			 [FirstDateOccupied] DATE NOT NULL,
			 [LastDateOccupied] DATE NOT NULL,
			 [TotalDays] INT NOT NULL,
			 [AmountCharged] DECIMAL(8,2) NOT NULL,
			 [TaxRate] DECIMAL(8,2) NOT NULL,
			 [TaxAmount] DECIMAL(8,2) NOT NULL,
			 [PaymentTotal] DECIMAL(8,2) NOT NULL,
			 [Notes] NVARCHAR(MAX)

CONSTRAINT FK_EmployeeId FOREIGN KEY(EmployeeId)
REFERENCES Employees(Id), 

CONSTRAINT FK_AccountNumber FOREIGN KEY(AccountNumber)
REFERENCES Customers(AccountNumber)
)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
	 VALUES
			(1, '2023-09-01', '001', '2023-08-20', '2023-08-25', 5, 500.00, 10.00, 50.00, 550.00, 'Notes about Payment 1'),
			(2, '2023-09-02', '002', '2023-08-15', '2023-08-20', 5, 1000.00, 15.00, 150.00, 1150.00, 'Notes about Payment 2'),
			(3, '2023-09-03', '003', '2023-08-10', '2023-08-15', 5, 750.00, 12.00, 90.00, 840.00, 'Notes about Payment 3');



CREATE TABLE Occupancies(
			 [Id] INT IDENTITY PRIMARY KEY,
			 [EmployeeId] INT NOT NULL,
			 [DateOccupied] DATE NOT NULL,
			 [AccountNumber] INT NOT NULL,
			 [RoomNumber] INT NOT NULL,
			 [RateApplied] DECIMAL(8,2) NOT NULL,
			 [PhoneCharge] DECIMAL(8,2),
			 [Notes] NVARCHAR(MAX)

CONSTRAINT FK_EmployeeId2 FOREIGN KEY(EmployeeId)
REFERENCES Employees(Id),

CONSTRAINT FK_RoomNumber2 FOREIGN KEY(RoomNumber)
REFERENCES Rooms(RoomNumber)
)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
	 VALUES
			(1, '2023-08-20', '001', 101, 100.00, 20.00, 'Notes'),
			(2, '2023-08-15', '002', 202, 200.00, NULL, 'Notes'),
			(3, '2023-08-15', '003', 202, 200.00, NULL, 'Notes')




