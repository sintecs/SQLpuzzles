------------------------------------------------------------------------------------------
-- SYSTEM GRANTS
------------------------------------------------------------------------------------------
GRANT CREATE FUNCTION TO dbucholtz;
GRANT CREATE PROCEDURE TO dbucholtz;

GRANT SELECT ON dbo.FillBlanks TO dbucholtz;
GRANT SELECT ON dbo.GenerateRows TO dbucholtz;

GRANT EXECUTE ON dbo.FillSquareDataPossible TO dbucholtz;
GRANT EXECUTE ON dbo.GetBlockCol TO dbucholtz;
GRANT EXECUTE ON dbo.GetBlockRow TO dbucholtz;
GRANT EXECUTE ON dbo.InitializePossibles TO dbucholtz;
GRANT EXECUTE ON dbo.RemoveBlockKnowns TO dbucholtz;
GRANT EXECUTE ON dbo.RemoveColumnKnowns TO dbucholtz;
GRANT EXECUTE ON dbo.RemoveImpossibles TO dbucholtz;
GRANT EXECUTE ON dbo.RemoveRowKnowns TO dbucholtz;
GRANT EXECUTE ON dbo.ResetPuzzle TO dbucholtz;
GRANT EXECUTE ON dbo.SolveBlockSoloPossibles TO dbucholtz;
GRANT EXECUTE ON dbo.SolveCellSoloPossibles TO dbucholtz;
GRANT EXECUTE ON dbo.SolveColumnSoloPossibles TO dbucholtz;
GRANT EXECUTE ON dbo.SolveRowSoloPossibles TO dbucholtz;
GRANT EXECUTE ON dbo.SolveSoloPossibles TO dbucholtz;
GRANT EXECUTE ON dbo.StartPuzzle TO dbucholtz;

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