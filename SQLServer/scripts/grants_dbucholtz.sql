------------------------------------------------------------------------------------------
-- SYSTEM GRANTS
------------------------------------------------------------------------------------------
GRANT CREATE FUNCTION TO dbucholtz;

------------------------------------------------------------------------------------------
-- SELECT
------------------------------------------------------------------------------------------
GRANT SELECT ON dbo.Difficulty TO dbucholtz;
GRANT SELECT ON dbo.Puzzle TO dbucholtz;
GRANT SELECT ON dbo.Size TO dbucholtz;
GRANT SELECT ON dbo.SquareData TO dbucholtz;
GRANT SELECT ON dbo.SquareDataPossible TO dbucholtz;

------------------------------------------------------------------------------------------
-- INSERT
------------------------------------------------------------------------------------------
GRANT INSERT ON dbo.Difficulty TO dbucholtz;
GRANT INSERT ON dbo.Puzzle TO dbucholtz;
GRANT INSERT ON dbo.Size TO dbucholtz;
GRANT INSERT ON dbo.SquareData TO dbucholtz;
GRANT INSERT ON dbo.SquareDataPossible TO dbucholtz;

------------------------------------------------------------------------------------------
-- UPDATE
------------------------------------------------------------------------------------------
GRANT UPDATE ON dbo.Difficulty TO dbucholtz;
GRANT UPDATE ON dbo.Puzzle TO dbucholtz;
GRANT UPDATE ON dbo.Size TO dbucholtz;
GRANT UPDATE ON dbo.SquareData TO dbucholtz;
GRANT UPDATE ON dbo.SquareDataPossible TO dbucholtz;

------------------------------------------------------------------------------------------
-- DELETE
------------------------------------------------------------------------------------------
GRANT DELETE ON dbo.Difficulty TO dbucholtz;
GRANT DELETE ON dbo.Puzzle TO dbucholtz;
GRANT DELETE ON dbo.Size TO dbucholtz;
GRANT DELETE ON dbo.SquareData TO dbucholtz;
GRANT DELETE ON dbo.SquareDataPossible TO dbucholtz;