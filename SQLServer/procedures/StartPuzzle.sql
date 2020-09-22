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

   -- Remove cells with zeros from the table as we'll be filling these in with answers
   DELETE 
      dbo.SquareData 
   WHERE 
      SquareValue = 0
      AND PuzzleID = @PuzzleID;

   WHILE (@x != 0 AND @LoopCounter <= 20)
   BEGIN
   
      SET @x = 0;
      SET @LoopCounter = @LoopCounter + 1;

      EXECUTE dbo.RemoveImpossibles
         @PuzzleID
         ,@PuzzleSize
         ,@InterimReturnValue;
      
      SET @x = @x + @InterimReturnValue;

      EXECUTE dbo.SolveSoloPossibles
         @PuzzleID
         ,@PuzzleSize
         ,@InterimReturnValue;

      SET @x = @x + @InterimReturnValue;
      
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
