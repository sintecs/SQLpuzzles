--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will remove possible values when there is a known value     --
-- (given or found) already in this row in another block                      --
--                                                                            --
-- Returns how many values were removed from all cells due to knowns          --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE RemoveRowKnowns
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   DELETE
   FROM 
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
            AND dbo.CheckBlockRow(@PuzzleSize, BlockID) = dbo.CheckBlockRow(@PuzzleSize, taken_vals.BlockID)
            AND RowID = taken_vals.RowID
            AND taken_vals.SquareValue IS NOT NULL
            AND taken_vals.SquareValue = PossibleValue
      );

   SET @x = @@ROWCOUNT

END

GO
