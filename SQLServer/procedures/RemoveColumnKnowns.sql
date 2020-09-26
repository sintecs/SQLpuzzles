--------------------------------------------------------------------------------
--                                                                            --
-- This function will remove values when there is a known value (given or     --
-- found) already in this column in another block                             --
-- It returns the count of values removed                                     --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE RemoveColumnKnowns
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
            AND dbo.GetBlockCol(@PuzzleSize, SquareDataPossible.BlockID) = dbo.GetBlockCol(@PuzzleSize, taken_vals.BlockID)
            AND taken_vals.ColumnID = SquareDataPossible.ColumnID
            AND taken_vals.SquareValue IS NOT NULL
            AND taken_vals.SquareValue = SquareDataPossible.PossibleValue
      );

   SET @x = @@ROWCOUNT;

END

GO