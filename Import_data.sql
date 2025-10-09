-- Lets Load the CSV into the matches table. May need to start the client with: mysql --local-infile=1 
-- and might need to change privileges to set GLOBAL local_infile.

USE premier_league;

-- Enable LOCAL INFILE if permitted
SET GLOBAL local_infile = 1;

-- Adjust the file path for the machine
--   /Users/yourname/foldername/matches_final.csv
-- This script loads the Premier League match data CSV into the matches table.
-- It enables local file import, reads the CSV line by line, converts date/time formats, replaces empty values with NULL, 
-- and runs quick validation checks — showing warnings, total rows loaded, and a sample of imported data.


LOAD DATA LOCAL INFILE '/Users/yourname/yourfolder/matches_final.csv'
INTO TABLE matches
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'      
IGNORE 1 LINES
(@date, @time, @comp, @round, @day, @venue, @result, @gf, @ga, @opponent, @xg, @xga,
 @poss, @attendance, @captain, @formation, @referee, @match_report, @notes, @sh, @sot,
 @dist, @fk, @pk, @pkatt, @season, @team)
SET
  `date`       = STR_TO_DATE(@date, '%d/%m/%Y'),
  `time`       = STR_TO_DATE(@time, '%H:%i'),
  `comp`       = NULLIF(@comp,''),
  `round`      = NULLIF(@round,''),
  `day`        = NULLIF(@day,''),
  `venue`      = NULLIF(@venue,''),
  `result`     = NULLIF(@result,''),
  `gf`         = NULLIF(@gf,''),
  `ga`         = NULLIF(@ga,''),
  `opponent`   = NULLIF(@opponent,''),
  `xg`         = NULLIF(@xg,''),
  `xga`        = NULLIF(@xga,''),
  `poss`       = NULLIF(@poss,''),
  `attendance` = NULLIF(@attendance,''),
  `captain`    = NULLIF(@captain,''),
  `formation`  = NULLIF(@formation,''),
  `referee`    = NULLIF(@referee,''),
  `match_report` = NULLIF(@match_report,''),
  `notes`      = NULLIF(@notes,''),
  `sh`         = NULLIF(@sh,''),
  `sot`        = NULLIF(@sot,''),
  `dist`       = NULLIF(@dist,''),
  `fk`         = NULLIF(@fk,''),
  `pk`         = NULLIF(@pk,''),
  `pkatt`      = NULLIF(@pkatt,''),
  `season`     = NULLIF(@season,''),
  `team`       = NULLIF(@team,'');

-- Quick checks. SQL warnings are conditions encountered during the execution of SQL statements that do not prevent the successful completion of the statement
--  but indicate a potential issue or a deviation from expected behavior.
SHOW WARNINGS LIMIT 10;


-- The COUNT() function in SQL is an aggregate function used to count the number of rows or non-NULL values within a specified column or expression. 
SELECT COUNT(*) AS rows_loaded FROM matches;

-- The SELECT * statement in SQL is used to retrieve all columns from a specified table. 
-- The asterisk (*) acts as a wildcard, indicating that every column in the table should be included in the result set.
SELECT * FROM matches LIMIT 10;
