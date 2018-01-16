CREATE TABLE dbo.Puzzle
(
	PuzzleID						INT IDENTITY(1, 1) NOT NULL
	,PuzzleTypeID					INT NOT NULL
	,Solved							BIT NOT NULL
	,Description					NVARCHAR(500)
	,DifficultyLevelID				INT
);

ALTER TABLE
	dbo.Puzzle
ADD CONSTRAINT
	PK_Puzzle
PRIMARY KEY
(
	PuzzleID
);
