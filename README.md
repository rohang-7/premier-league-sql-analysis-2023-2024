# ⚽ Premier League SQL Analysis (2023–2024)

### 🧠 **Project Overview**
This project performs **comprehensive SQL analysis** of Premier League match data using **MySQL 8+**.  
It explores real match metrics such as goals, expected goals (xG), possession, and attendance, while applying SQL concepts ranging from **data loading and cleaning** to **CTEs, window functions, and BI-ready views**.

---

## 🧩 **Project Structure**

```
sql/
├── 01_create_database.sql
├── 02_create_table.sql
├── 03_import_data.sql
├── 04_basic_queries.sql
├── 05_intermediate_queries.sql
├── 06_advanced_window_functions_ctes.sql
├── 07_dashboard_views.sql
├── 08_data_quality_checks.sql
└── 09_indexes_and_optimizations.sql
```

---

## 🚀 **Getting Started**

### **1️⃣ Prerequisites**
- MySQL 8.0 or higher installed.
- MySQL Workbench or command-line client.
- The CSV file (`matches_final.csv`) stored locally.

### **2️⃣ Run in MySQL (Command-Line)**

```bash
# Start MySQL with local file imports enabled
mysql --local-infile=1 -u root -p

# Inside MySQL shell
SOURCE sql/01_create_database.sql;
SOURCE sql/02_create_table.sql;
SOURCE sql/03_import_data.sql;
SOURCE sql/04_basic_queries.sql;
```

### **3️⃣ Run in MySQL Workbench**
1. Open MySQL Workbench.
2. Connect to your server.
3. Go to **File → Open SQL Script...** and select any of the `.sql` files.
4. Run each script sequentially (Ctrl + Shift + Enter).

---

## 📘 **04_basic_queries.sql**
This script contains foundational SQL commands to verify and explore the dataset.

### 🔑 Key Concepts:
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- Conditional logic with `CASE WHEN`
- String, numeric, and date/time functions  

### 📊 Sample Insights:
- Total matches and unique teams/seasons  
- Wins, draws, and losses by team  
- Average possession and expected goals (xG)  
- Top-5 referees and venues by attendance  

---

## 📗 **05_intermediate_queries.sql**
Focuses on **applied analytics** — generating season-level summaries, home/away splits, and head-to-head performance tables.

### 🧩 Key Highlights:
- League tables with points and goal difference  
- Home vs away performance comparison  
- Month-over-month scoring trends  
- Attendance analysis and venue popularity  

---

## 📘 **06_advanced_window_functions_ctes.sql**
Introduces **CTEs (Common Table Expressions)** and **window functions** to perform dynamic analysis and ranking.

### 💡 Concepts Covered:
- Ranking teams by points using `RANK() OVER`  
- Rolling averages (e.g., 5-match xG trends)  
- Last-5 match form summary  
- Longest winning/drawing/losing streaks per team  
- Top-3 opponents by total points  

---

## 📊 **07_dashboard_views.sql**
Creates reusable **MySQL views** for visualization tools like **Tableau, Power BI, or Looker Studio**.

### Includes:
- `v_matches_enriched` – Cleaned and feature-rich match table  
- `v_team_season_table` – Ranked league table with averages  
- `v_team_last5_form` – Recent form tracker  
- `v_monthly_trends` – Monthly performance patterns  
- `v_head_to_head` – Historical matchup data  

---

## 🔍 **08_data_quality_checks.sql**
Ensures data integrity before further analysis.  
It checks for:
- Null values per column  
- Invalid ranges (e.g., possession >100%)  
- Duplicate records (team, opponent, date)  
- Outlier attendance figures  

---

## ⚙️ **09_indexes_and_optimizations.sql**
Improves query performance with indexing and optimization.

### Adds:
- Indexes on key fields like `team`, `season`, and `date`  
- Composite indexes for frequent queries (`team, season`)  
- `ANALYZE TABLE` and `OPTIMIZE TABLE` commands for maintenance  

---

## 🧠 **Learning Outcomes**
By completing this project, you will:
- Understand real-world SQL workflow — from data ingestion to analysis  
- Apply both **analytical** and **engineering** SQL techniques  
- Build reusable queries and BI-ready database views  
- Demonstrate proficiency with **MySQL 8** window functions and CTEs  

---

## 🏆 **Dataset Details**
The dataset (`matches_final.csv`) contains columns such as:
- `date`, `time`, `team`, `opponent`, `season`, `result`, `gf`, `ga`, `xg`, `xga`, `poss`, `attendance`, `referee`, `venue`, etc.  
It represents match-level Premier League data over multiple seasons.

---

## 📈 **Example Analytical Questions**
- Which team had the highest win rate this season?  
- Which stadium had the highest average attendance?  
- Who are the top-performing teams in away matches?  
- What’s the longest winning streak across all seasons?  
- How do actual goals (GF) compare to expected goals (xG)?  

---

## 💡 **Future Extensions**
- Integrate Power BI / Tableau dashboards.  
- Add predictive models (e.g., next-match win probability).  
- Automate data ingestion with Python or Airflow pipelines.  
- Expand to include **Champions League** or **La Liga** datasets for comparison.

---

## 👨‍💻 **Author**
**Rohang Shah**  
🎓 *Master of Data Science, Deakin University*  
💼 *Aspiring Data Analyst | Sports & Business Analytics Enthusiast*  
📍 *Melbourne, Australia*  
🔗 [LinkedIn](https://www.linkedin.com/in/rohang-shah) | [GitHub](https://github.com/rohang-7)
