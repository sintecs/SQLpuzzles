--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will remove values from a block when there is a known value --
-- (given or found) already in this block                                     --
--                                                                            --
-- Returns the number of values removed from cells for knowns                 --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE RemoveBlockKnowns
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   DELETE FROM
      dbo.SquareDataPossible
   WHERE
      SquareDataPossible.PuzzleID = @PuzzleID
      AND EXISTS
      (
         SELECT
            NULL
         FROM
            dbo.SquareData AS taken_vals
         WHERE
            taken_vals.PuzzleID = SquareDataPossible.PuzzleID
            AND taken_vals.BlockID = SquareDataPossible.BlockID
            AND taken_vals.SquareValue IS NOT NULL
            AND taken_vals.SquareValue = SquareDataPossible.PossibleValue
      );

   SET @x = @@ROWCOUNT

END

GO
