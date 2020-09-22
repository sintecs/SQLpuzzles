--------------------------------------------------------------------------------
--                                                                            --
-- This function will remove impossibilities from the puzzle.                 --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE RemoveImpossibles
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
)
AS
BEGIN

   DECLARE @ReturnVal             INT = 0;
   DECLARE @InterimReturnVal      INT = 0;

   EXECUTE dbo.RemoveBlockKnowns @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;

   EXECUTE dbo.RemoveRowKnowns @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;

   EXECUTE dbo.RemoveColumnKnowns @PuzzleID, @PuzzleSize, @InterimReturnVal;

   SET @ReturnVal = @ReturnVal + @InterimReturnVal;
   
   SET @x = @ReturnVal;

END;