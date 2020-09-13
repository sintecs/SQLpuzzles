--------------------------------------------------------------------------------
--                                                                            --
-- This function will return which row of the puzzle where this block         --
-- resides.  This function assumes a square puzzle of rows.                   --
-- For a puzzle with 9 blocks, blocks numbered 1-3 in the first row, 4-6 in   --
-- the second row and 7-9 in the third row, left to right.                    --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetBlockRow
(
   @PuzzleSize                    INT
   ,@BlockID                      INT
   ,@BlockRow                     INT OUT
) AS
BEGIN

   SELECT
      @BlockRow = CEILING(@BlockID / SQRT(@PuzzleSize));

END

GO
