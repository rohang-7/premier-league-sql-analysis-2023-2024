
-- Purpose: Run foundational SQL commands to explore and understand the basic concepts and functions of SQL 
-- using Premier League dataset.

USE premier_league;

-- View Sample Data
SELECT * 
FROM matches
LIMIT 10;

-- Check number of total rows (sanity check)
SELECT COUNT(*) AS total_matches 
FROM matches;

-- Find unique teams and seasons
SELECT 
  COUNT(DISTINCT team) AS total_teams, 
  COUNT(DISTINCT season) AS total_seasons
FROM matches;


-- Basic Aggregate functions
-- Count how many matches each team has played
SELECT 
  team,
  COUNT(*) AS matches_played
FROM matches
GROUP BY team
ORDER BY matches_played DESC;

-- Calculate total and average goals scored by each team
SELECT 
  team,
  SUM(gf) AS total_goals_scored,
  ROUND(AVG(gf),2) AS avg_goals_per_match
FROM matches
GROUP BY team
ORDER BY total_goals_scored DESC;

-- Calculate goals conceded and goal difference
SELECT 
  team,
  SUM(ga) AS goals_conceded,
  SUM(gf - ga) AS goal_difference
FROM matches
GROUP BY team
ORDER BY goal_difference DESC;

-- Average expected goals (xG) and expected goals against (xGA)
SELECT 
  team,
  ROUND(AVG(xg),2) AS avg_xg,
  ROUND(AVG(xga),2) AS avg_xga
FROM matches
GROUP BY team
ORDER BY avg_xg DESC;


-- Using case statement with AGG functions (for Wins/Draws/Losses)
SELECT 
  team,
  SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS draws,
  SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END) AS losses,
  ROUND(100.0 * SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END)/COUNT(*), 2) AS win_percentage
FROM matches
GROUP BY team
ORDER BY wins DESC;


-- Numeric and stats functions
-- Find highest and lowest attendance
SELECT 
  MAX(attendance) AS highest_attendance,
  MIN(attendance) AS lowest_attendance
FROM matches;

-- Calculate average shot distance and average possession by team
SELECT 
  team,
  ROUND(AVG(dist), 2) AS avg_shot_distance,
  ROUND(AVG(poss), 2) AS avg_possession
FROM matches
GROUP BY team
ORDER BY avg_possession DESC;

-- Find teams with most penalties scored
SELECT 
  team,
  SUM(pk) AS penalties_scored,
  SUM(pkatt) AS penalties_attempted,
  ROUND(100 * SUM(pk)/NULLIF(SUM(pkatt),0), 2) AS penalty_conversion_rate
FROM matches
GROUP BY team
ORDER BY penalties_scored DESC;


-- String functions
-- Convert team names to uppercase
SELECT 
  UPPER(team) AS team_uppercase
FROM matches
GROUP BY team
LIMIT 10;

-- Get first three letters of each team's name
SELECT 
  team,
  LEFT(team, 3) AS short_code
FROM matches
GROUP BY team
LIMIT 10;

-- Find referees with names containing 'Mike'
SELECT DISTINCT referee
FROM matches
WHERE referee LIKE '%Mike%';


-- Date and time functions 
-- Extract year and month from date
SELECT 
  team,
  DATE_FORMAT(date, '%Y-%m') AS match_month,
  COUNT(*) AS matches_played
FROM matches
GROUP BY team, match_month
ORDER BY team, match_month;

-- Count matches played per weekday
SELECT 
  day,
  COUNT(*) AS matches_played
FROM matches
GROUP BY day
ORDER BY FIELD(day, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Find earliest and latest match date in the dataset
SELECT 
  MIN(date) AS first_match_date,
  MAX(date) AS last_match_date
FROM matches;


-- Filters & conditions
-- Matches with high xG (greater than 3.0)
SELECT 
  team, opponent, date, xg
FROM matches
WHERE xg > 3.0
ORDER BY xg DESC
LIMIT 10;

-- Matches with less possession (< 40%)
SELECT 
  team, opponent, poss, result
FROM matches
WHERE poss < 40
ORDER BY poss ASC
LIMIT 10;

-- Matches with large goal difference (win/loss margin ≥ 4)
SELECT 
  team, opponent, gf, ga, (gf - ga) AS goal_margin, result
FROM matches
WHERE ABS(gf - ga) >= 4
ORDER BY goal_margin DESC
LIMIT 10;


-- Ranking & sorting 
-- Top 5 matches with highest attendance
SELECT 
  team, opponent, attendance, date, venue
FROM matches
ORDER BY attendance DESC
LIMIT 5;

-- Top 5 referees by total matches officiated
SELECT 
  referee,
  COUNT(*) AS matches_officiated
FROM matches
GROUP BY referee
ORDER BY matches_officiated DESC
LIMIT 5;


-- other basic queries
-- Team with the Most Wins (Overall)
-- Returns the team that won the most matches overall.
SELECT 
    team,
    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS total_wins
FROM matches
GROUP BY team
ORDER BY total_wins DESC
LIMIT 1;


-- Teams Ranked by Total Wins
-- Quick leaderboard of wins across all teams.
SELECT 
    team,
    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS total_wins
FROM matches
GROUP BY team
ORDER BY total_wins DESC;


-- Match with the Most Goals Scored (by a Single Team)
-- Finds the match where one team scored the highest number of goals.
SELECT 
    team as Home_Team,
    opponent as Away_Team,
    gf as Home_Team_Goals,
    ga as Away_Team_Goals,
    venue,
    date,
    gf AS goals_scored
FROM matches
ORDER BY gf DESC
LIMIT 1;



-- Match with the Most Goals Conceded (by a Single Team)
-- Finds the match where a team conceded the most goals.
SELECT 
    team,
    opponent,
    date,
    ga AS goals_conceded
FROM matches
ORDER BY ga DESC
LIMIT 1;



-- Match with the Highest Combined Score (Both Teams)
-- Shows the most entertaining high-scoring match.
SELECT 
    team,
    opponent,
    date,
    (gf + ga) AS total_goals
FROM matches
ORDER BY total_goals DESC
LIMIT 1;



-- Best Venue in Terms of Total Attendance
-- Finds the venue that drew the largest total crowd.
SELECT 
    SUM(attendance) AS total_attendance,
    COUNT(*) AS total_matches,
    ROUND(AVG(attendance), 0) AS avg_attendance
FROM matches
WHERE attendance IS NOT NULL
ORDER BY total_attendance DESC
LIMIT 1;



-- Average Attendance per Venue (Venue Popularity Ranking)
-- Lists all venues ranked by average crowd size.
SELECT 
    venue,
    COUNT(*) AS total_matches,
    ROUND(AVG(attendance), 0) AS avg_attendance,
    SUM(attendance) AS total_attendance
FROM matches
WHERE attendance IS NOT NULL
GROUP BY venue
ORDER BY avg_attendance DESC;



-- Most Common Opponent per Team (Top Rival)
-- Finds which teams faced each other most frequently.
SELECT 
    team,
    opponent,
    COUNT(*) AS matches_played
FROM matches
GROUP BY team, opponent
ORDER BY matches_played DESC
LIMIT 10;



-- Average Goals Scored per Match per Team
-- Measures attacking and defensive consistency.
SELECT 
    team,
    ROUND(AVG(gf), 2) AS avg_goals_scored,
    ROUND(AVG(ga), 2) AS avg_goals_conceded
FROM matches
GROUP BY team
ORDER BY avg_goals_scored DESC;



-- Venue with the Most Matches Played
-- Identifies the most frequently used stadium.
SELECT 
    venue,
    COUNT(*) AS total_matches
FROM matches
GROUP BY venue
ORDER BY total_matches DESC
LIMIT 1;


