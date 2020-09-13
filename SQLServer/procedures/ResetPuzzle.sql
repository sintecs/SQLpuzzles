--------------------------------------------------------------------------------
--                                                                            --
-- This function will reset a puzzle to an unsolved state.  It does this by   --
-- removing all "guesses" and "founds" from SquareDataPossible and            --
-- resetting SquareData back to the starting values entered in the table.     --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ResetPuzzle
(
   @PuzzleID                      INT
) AS
BEGIN

   -- Remove all "guesses" and "founds" from the table
   DELETE
      dbo.SquareData
   WHERE
      (
         InitialValue <> 1
         OR InitialValue IS NULL
      )
      AND PuzzleID = @PuzzleID;

   -- Remove all data for this puzzle from the possibles table
   DELETE
      dbo.SquareDataPossible
   WHERE
      PuzzleID = @PuzzleID;

END

GO
