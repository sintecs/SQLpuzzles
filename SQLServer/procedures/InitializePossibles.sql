--------------------------------------------------------------------------------
--                                                                            --
-- This function will fill the solving table with the possible values that    --
-- can be placed into the open/unsolved squares.                              --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE InitializePossibles
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
) AS
BEGIN

   -- Initialize table by removing any old data for this puzzle
   DELETE
      dbo.SquareDataPossible 
   WHERE 
      PuzzleID = @PuzzleID;
   
   EXECUTE dbo.FillSquareDataPossible
      @PuzzleID
      ,@PuzzleSize;

END

GO
