--------------------------------------------------------------------------------
--                                                                            --
-- This function will move possible values to solved values when there is     --
-- only one possible location for a value.                                    --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SolveSoloPossibles
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
)
AS
BEGIN


   DECLARE @ReturnVal             INT = 0;
   DECLARE @InterimReturnVal      INT = 0;

   EXECUTE dbo.SolveCellSoloPossibles @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;

   EXECUTE dbo.SolveBlockSoloPossibles @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;

   EXECUTE dbo.SolveColumnSoloPossibles @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;

   EXECUTE dbo.SolveRowSoloPossibles @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;
   
   SET @x = @ReturnVal;

END;
