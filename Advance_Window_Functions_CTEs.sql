-- CTEs, ranking, rolling averages, last-5 form, and longest streaks.
-- Requires MySQL 8+ for window functions.

USE premier_league;

-- A) CTE: wins/draws/losses + points per team/season
WITH team_totals AS (
  SELECT
    team,
    season,
    SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS W,
    SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS D,
    SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS L,
    SUM(gf) AS gf,
    SUM(ga) AS ga
  FROM matches
  GROUP BY team, season
)
SELECT
  team, season, W, D, L,
  (W*3 + D) AS points,
  (gf - ga) AS goal_diff
FROM team_totals
ORDER BY season, points DESC, goal_diff DESC, gf DESC;

-- B) Ranked league table per season
WITH league AS (
  SELECT
    team, season,
    COUNT(*) AS played,
    SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses,
    SUM(gf) AS gf, SUM(ga) AS ga,
    SUM(gf-ga) AS gd,
    SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS points
  FROM matches
  GROUP BY team, season
)
SELECT
  season, team, played, wins, draws, losses, gf, ga, gd, points,
  RANK() OVER (PARTITION BY season ORDER BY points DESC, gd DESC, gf DESC) AS season_rank
FROM league
ORDER BY season, season_rank;

-- C) Rolling 5-match xG by team
SELECT
  team, `date`, xg,
  ROUND(AVG(xg) OVER (
    PARTITION BY team
    ORDER BY `date`, id
    ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
  ), 3) AS xg_rolling_5
FROM matches
ORDER BY team, `date`;

-- D) Last-5 form string and points
WITH last5 AS (
  SELECT
    team, `date`, result,
    ROW_NUMBER() OVER (PARTITION BY team ORDER BY `date` DESC, id DESC) AS rn
  FROM matches
)
SELECT
  team,
  GROUP_CONCAT(result ORDER BY rn SEPARATOR '-') AS last5_form,
  SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS last5_points
FROM last5
WHERE rn <= 5
GROUP BY team
ORDER BY team;

-- E) Longest W/D/L streak per team
WITH ordered AS (
  SELECT
    team, `date`, result,
    ROW_NUMBER() OVER (PARTITION BY team ORDER BY `date`, id) AS rn_all,
    ROW_NUMBER() OVER (PARTITION BY team, result ORDER BY `date`, id) AS rn_res
  FROM matches
),
blocks AS (
  SELECT team, result, (rn_all - rn_res) AS grp_key, COUNT(*) AS streak_len
  FROM ordered
  GROUP BY team, result, grp_key
)
SELECT team, result, MAX(streak_len) AS longest_streak
FROM blocks
GROUP BY team, result
ORDER BY team, result;

-- F) Per-group Top-N: top 3 opponents by points per team
WITH opp_pts AS (
  SELECT team, opponent,
         SUM(CASE result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) AS points
  FROM matches
  GROUP BY team, opponent
),
ranked AS (
  SELECT team, opponent, points,
         ROW_NUMBER() OVER (PARTITION BY team ORDER BY points DESC, opponent) AS rn
  FROM opp_pts
)
SELECT team, opponent, points
FROM ranked
WHERE rn <= 3
ORDER BY team, points DESC, opponent;
