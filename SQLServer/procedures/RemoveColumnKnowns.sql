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
      PuzzleID = @PuzzleID
      AND EXISTS
      (
         SELECT
            NULL
         FROM
            dbo.SquareData AS taken_vals
         WHERE
            PuzzleID = taken_vals.PuzzleID
            AND dbo.CheckBlockCol(@PuzzleSize, BlockID) = dbo.CheckBlockCol(@PuzzleSize, taken_vals.BlockID)
            AND ColumnID = taken_vals.ColumnID
            AND taken_vals.SquareValue IS NOT NULL
            AND taken_vals.SquareValue = PossibleValue
      );

   SET @x = @@ROWCOUNT;

END

GO