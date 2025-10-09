-- create_database.sql
-- Lets create a clean workspace for this project.

DROP DATABASE IF EXISTS premier_league;
CREATE DATABASE premier_league
  -- Choose utf8mb4 for full Unicode support (accents, emojis if ever needed) 
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
  -- This statement configures a MySQL database column or table to store a wide range of Unicode characters, 
  -- including emojis, and defines sorting rules that ignore accents and letter cases.  

USE premier_league;
