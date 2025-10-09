
USE premier_league;
-- This script creates the matches table in the premier_league database to store detailed match statistics 
-- including date, teams, results, goals, expected goals (xG), attendance, and other performance metrics.
DROP TABLE IF EXISTS matches;


CREATE TABLE matches (
  id INT AUTO_INCREMENT PRIMARY KEY,
  date DATE,
  time TIME,
  comp VARCHAR(50),
  round VARCHAR(50),
  day VARCHAR(20),
  venue VARCHAR(20),
  result VARCHAR(5),
  gf INT,
  ga INT,
  opponent VARCHAR(100),
  xg FLOAT,
  xga FLOAT,
  poss INT,
  attendance INT,
  captain VARCHAR(100),
  formation VARCHAR(50),
  referee VARCHAR(100),
  match_report VARCHAR(100),
  notes VARCHAR(100),
  sh INT,
  sot INT,
  dist FLOAT,
  fk INT,
  pk INT,
  pkatt INT,
  season INT,
  team VARCHAR(100)
);


-- The DESCRIBE or DESC statement in SQL is used to display the structure of a database table. 
-- It provides detailed information about each column within the specified table.
DESC matches;