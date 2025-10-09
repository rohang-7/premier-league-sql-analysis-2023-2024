# Introduction — Basic SQL Queries (`04_basic_queries.sql`)

This section contains **foundational SQL commands** to explore and understand the Premier League dataset after importing it into MySQL.  
These queries help verify data integrity, perform quick summaries, and identify key insights such as total matches, team performance, and scoring patterns.

---

## Key SQL Keywords Explained

|-----------------------|-------------|--------------------------|
| **`SELECT`** | Used to choose specific columns to display from a table. | `SELECT team, result FROM matches;` |
| **`FROM`** | Specifies the table to pull data from. | `FROM matches` |
| **`WHERE`** | Filters rows based on conditions. | `WHERE result = 'W'` (returns only winning matches) |
| **`GROUP BY`** | Groups rows sharing a common value for aggregation. | `GROUP BY team` |
| **`ORDER BY`** | Sorts query results in ascending (`ASC`) or descending (`DESC`) order. | `ORDER BY wins DESC` |
| **`COUNT()`** | Returns how many rows or items are in a group. | `COUNT(*) AS total_matches` |
| **`SUM()`** | Adds up numeric values (e.g., goals, wins). | `SUM(CASE WHEN result='W' THEN 1 ELSE 0 END)` |
| **`AVG()`** | Calculates the average of numeric data. | `AVG(xg)` |
| **`CASE WHEN ... THEN ... END`** | A conditional expression to compute custom metrics. | Converts match results to points. |
| **`LIMIT`** | Restricts how many rows are shown in the result. | `LIMIT 10` |

---

## What These Queries Do

1. **Preview the dataset** — Display a few rows to confirm data loaded correctly.  
2. **Count total matches** — Sanity check for dataset size.  
3. **List unique teams and seasons** — Understand dataset diversity.  
4. **Summarize team results** — Wins, draws, losses using `CASE` and `GROUP BY`.  
5. **Compare expected vs actual goals (xG vs xGA)** — Quick analytical insight.  
6. **Sort and rank outputs** — To easily identify top-performing teams.

---

## Outcome

After running this script, you’ll have a clear understanding of:
- The structure and accuracy of your data  
- Basic analytical summaries per team and season  
- Early indicators of performance trends and potential data quality issues  

---

### 💡 Next Step

