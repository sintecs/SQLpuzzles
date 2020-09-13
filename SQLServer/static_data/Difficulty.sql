SET IDENTITY_INSERT Difficulty ON;

INSERT INTO dbo.Difficulty
(
  DifficultyID
 ,DifficultyName
)
VALUES
    (1, 'Easy')
   ,(2, 'Medium')
   ,(3, 'Hard')
   ,(4, 'Evil');

SET IDENTITY_INSERT Difficulty OFF;
