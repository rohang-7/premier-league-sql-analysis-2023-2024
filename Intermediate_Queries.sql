
-- Season summaries, points tables, home/away splits, monthly trends, head-to-head.

USE premier_league;

-- 1) League-style season table (points & goal difference)
SELECT
  team,
  season,
  COUNT(*) AS played,
  SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws,
  SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses,
  SUM(gf) AS goals_for,
  SUM(ga) AS goals_against,
  SUM(gf - ga) AS goal_diff,
  SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS points
FROM matches
GROUP BY team, season
ORDER BY season, points DESC, goal_diff DESC, goals_for DESC;

-- 2) Home vs Away performance (normalize venue)
SELECT
  team,
  CASE
    WHEN venue IN ('Home','H') THEN 'Home'
    WHEN venue IN ('Away','A') THEN 'Away'
    ELSE venue
  END AS venue_norm,
  COUNT(*) AS played,
  SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws,
  SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses,
  SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS points
FROM matches
GROUP BY team, venue_norm
ORDER BY team, venue_norm;

-- 3) Month-over-month goals & GD
SELECT
  team,
  DATE_FORMAT(`date`, '%Y-%m') AS ym,
  COUNT(*) AS played,
  SUM(gf) AS gf,
  SUM(ga) AS ga,
  SUM(gf - ga) AS gd
FROM matches
GROUP BY team, ym
ORDER BY team, ym;



-- 4) Head-to-head summary
SELECT
  team,
  opponent,
  COUNT(*) AS played,
  SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws,
  SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses,
  SUM(gf) AS gf,
  SUM(ga) AS ga,
  SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS points
FROM matches
GROUP BY team, opponent
ORDER BY team, points DESC, wins DESC, gf DESC;

-- 5) Attendance insights by venue
SELECT
  venue,
  COUNT(*) AS matches,
  SUM(attendance) AS total_attendance,
  ROUND(AVG(attendance),0) AS avg_attendance
FROM matches
WHERE attendance IS NOT NULL
GROUP BY venue
ORDER BY avg_attendance DESC, total_attendance DESC;
