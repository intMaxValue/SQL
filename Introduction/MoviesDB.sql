CREATE DATABASE [Movies]


CREATE TABLE [Directors] (
			 [Id] INT IDENTITY PRIMARY KEY,
			 [DirectorName] NVARCHAR(100) NOT NULL,
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO [Directors] (DirectorName, Notes)
	 VALUES
			('Director 1', NULL),
			('Director 2', NULL),
			('Director 3', NULL),
			('Director 4', NULL),
			('Director 5', NULL)
			
CREATE TABLE [Genres] (
			 [Id] INT IDENTITY PRIMARY KEY,
			 [GenreName] NVARCHAR(50) NOT NULL,
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO [Genres] (GenreName, Notes)
	 VALUES 
			('Action', 'bla-bla'),
			('Horror', 'bla-bla'),
			('Comedy', 'bla-bla'),
			('Erotic', 'bla-bla'),
			('Sci-Fi', 'bla-bla')

			
CREATE TABLE [Categories] (
			 [Id] INT IDENTITY PRIMARY KEY,
			 [CategoryName] NVARCHAR(100) NOT NULL,
			 [Notes] NVARCHAR(MAX)
)

INSERT INTO [Categories] (CategoryName, Notes)
	 VALUES 
			('Category 1', 'dryn-dryn'),
			('Category 2', 'dryn-dryn'),
			('Category 3', 'dryn-dryn'),
			('Category 4', 'dryn-dryn'),
			('Category 5', 'dryn-dryn')


CREATE TABLE [Movies] (
			 [Id] INT IDENTITY PRIMARY KEY,
			 [Title] NVARCHAR(200) NOT NULL,
			 [DirectorId] INT NOT NULL,
			 [CopyrightYear] DATETIME,
			 [Length] INT,
			 [GenreId] INT NOT NULL,
			 [CategoryId] INT NOT NULL,
			 [Rating] INT,
			 [Notes] NVARCHAR(MAX)

CONSTRAINT FK_Director FOREIGN KEY (DirectorId) 
REFERENCES Directors (Id),

CONSTRAINT FK_Genre FOREIGN KEY (GenreId)
REFERENCES Genres (Id),

CONSTRAINT FK_Category FOREIGN KEY (CategoryId)
REFERENCES Categories (Id)
)

INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
    ('Movie 1', 1, 2020, 120, 1, 1, 7, 'Notes about Movie 1'),
    ('Movie 2', 2, 2015, 105, 2, 2, 6, 'Notes about Movie 2'),
    ('Movie 3', 3, 2019, 135, 3, 3, 8, 'Notes about Movie 3'),
    ('Movie 4', 4, 2022, 110, 4, 4, 7, 'Notes about Movie 4'),
    ('Movie 5', 5, 2018, 95, 5, 5, 6, 'Notes about Movie 5');
