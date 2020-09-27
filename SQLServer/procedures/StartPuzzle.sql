--------------------------------------------------------------------------------
--                                                                            --
-- This function will start the actual process of solving a puzzle.  The data --
-- for the puzzle must already have been inserted into t_square_data before   --
-- calling this function.                                                     --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE StartPuzzle
(
   @PuzzleID                      INT
) AS

DECLARE @PuzzleSize               INT;
DECLARE @x                        INT = 999;
DECLARE @y                        INT = 0;
DECLARE @LoopCounter              INT = 0;
DECLARE @InterimReturnValue       INT;

BEGIN

   -- Reset the puzzle to an unsolved state.  Basically cleanup from any leftovers
   -- from a previous attempt
   EXECUTE dbo.ResetPuzzle
      @PuzzleID;

   SELECT
      @PuzzleSize = s.NumberOfBlocks
   FROM
      dbo.Puzzle AS p
         INNER JOIN
            dbo.Size AS s ON
               p.SizeID = s.SizeID
   WHERE
      p.PuzzleID = @PuzzleID;

   -- Initialize the puzzle by inserting all the possible values into the solving table
   EXECUTE dbo.InitializePossibles 
      @PuzzleID
      ,@PuzzleSize;

   -- Remove cells with non-given values from the table as we will be filling these in with answers
   DELETE 
      dbo.SquareData 
   WHERE 
      InitialValue != 1
      AND PuzzleID = @PuzzleID;

   WHILE (@x != 0 AND @LoopCounter <= 5)
   BEGIN

      SET @y = 0;

      EXECUTE dbo.RemoveImpossibles
         @PuzzleID
         ,@PuzzleSize
         ,@InterimReturnValue OUT;
      
      SET @y = @InterimReturnValue;

      EXECUTE dbo.SolveSoloPossibles
         @PuzzleID
         ,@PuzzleSize
         ,@InterimReturnValue OUT;
      
      SET @y = @y + @InterimReturnValue;
      
      --See if all the cells have been solved
      SET @x = 
      (
         SELECT
            POWER(@PuzzleSize, 2) - COUNT(*)
         FROM
            dbo.SquareData AS sd
         WHERE
            sd.PuzzleID = @PuzzleID
      );
      
      --If we solved any cells, go through again to see if that found us more solutions
      SET @LoopCounter =
      (
         SELECT
            CASE
               WHEN @y > 0
               THEN @LoopCounter - 1
               ELSE @LoopCounter + 1
            END
      );
      
   END; --WHILE LOOP


   /*
   UPDATE
      dbo.Puzzle 
   SET
      solved = 1
   WHERE
      PuzzleID = @PuzzleID;
   */

END;
