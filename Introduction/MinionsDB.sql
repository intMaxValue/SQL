CREATE DATABASE [Minions]
GO


USE Minions
GO


CREATE TABLE [Minions](
			 [Id] INT PRIMARY KEY,
			 [Name] NVARCHAR(50) NOT NULL,
			 [Age] INT
)
GO



CREATE TABLE [Towns](
			 [Id] INT PRIMARY KEY,
			 [Name] NVARCHAR(70) NOT NULL
)
GO



ALTER TABLE [Minions]
ADD [TownId] INT NOT NULL FOREIGN KEY REFERENCES [Towns]([Id])
GO



INSERT INTO [Towns] ([Id], [Name])
	 VALUES (1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Varna')



INSERT INTO [Minions] ([Id], [Name], [Age], [TownId])
	 VALUES 
			(1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Steward', NULL, 2)

GO


TRUNCATE TABLE [Minions]

DROP TABLE Minions
DROP TABLE Towns



CREATE TABLE [People](
		[Id] INT PRIMARY KEY IDENTITY,
		[Name] NVARCHAR(200) NOT NULL,
		[Picture] VARBINARY(MAX),
		--check if size of the picture is bigger than 2mb
		CHECK (DATALENGTH([Picture]) <= 2000000),
		--decimal - 3 digits total, 1 whole before and 2 digits after the floating point
		[Height] DECIMAL (3,2),
		[Weight] DECIMAL (5,2),
		[Gender] CHAR(1) NOT NULL,
		--check gender M or F
		CHECK ([Gender] = 'm' OR [Gender] = 'f'),
		[Birthdate] DATE NOT NULL,
		[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Name], [Height], [Weight], [Gender], [Birthdate])
	 VALUES
	 ('Pesho', 1.44, 56.6, 'm', '1991-05-23'),
	 ('Kolyo', 1.65, 76.6, 'm', '1996-02-13'),
	 ('Gosho', 1.94, 96.6, 'm', '1981-05-29'),
	 ('Irina', 1.74, 56.6, 'f', '1987-01-22'),
	 ('Sabri', 1.84, 86.6, 'm', '1978-09-03')


-- add default value
ALTER TABLE [People]
ADD CONSTRAINT Df_Biography
DEFAULT 'No Biography' FOR [Biography]




CREATE TABLE [Users](
			 [Id] BIGINT PRIMARY KEY IDENTITY,
			 [Username] VARCHAR(30) NOT NULL UNIQUE,
			 [Password] VARCHAR(26) NOT NULL,
			 [ProfilePicture] VARBINARY(MAX),
			 CHECK (DATALENGTH([ProfilePicture]) <= 900000),
			 [LastLoginTime] DATETIME2,
			 [IsDeleted] BIT
)

INSERT INTO [Users] ([Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted])
	 VALUES
			('Pesho', '321231', NULL, GETDATE(), 0),
			('Gosho', '321231', NULL, GETDATE(), 0),
			('Stamat', '321231', NULL, GETDATE(), 0),
			('Igor', '321231', NULL, GETDATE(), 0),
			('Sarnichka', '321231', NULL, GETDATE(), 0)



ALTER TABLE [Users]
DROP CONSTRAINT PK__Users__3214EC07E968F55A

ALTER TABLE [Users]
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)



ALTER TABLE [Users]
ADD CONSTRAINT CheckPasswordLength CHECK(LEN(Password) >= 5)


ALTER TABLE [Users]
ADD CONSTRAINT DF_AddLastLogin
DEFAULT GETDATE() FOR [LastLoginTime]


ALTER TABLE [Users]
DROP CONSTRAINT PK_Users

ALTER TABLE [Users]
ADD CONSTRAINT PK_USERS
PRIMARY KEY (Id)

ALTER TABLE [Users]
ADD CONSTRAINT CK_UserLength
CHECK (LEN(Username) >= 3)

ALTER TABLE [Users]
ADD CONSTRAINT CK_UserUnique UNIQUE (Username)


