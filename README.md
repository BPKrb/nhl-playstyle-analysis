# nhl-playstyle-analysis
Trying to quantify play style using hits/minute and xG. All data normalized per 60mins. Data courtesy of https://moneypuck.com 
# NHL Hit vs xG Analysis

This MATLAB project analyzes NHL team-level performance across seasons by visualizing the relationship between:

- **Normalized Hits For** (hits per 60mins at 5on5)
- **Normalized Expected Goals For** (xG per 60mins at 5on5)

It generates:
-One scatter plot per season, with each team's data point labeled
-A summary plot showing seasonal means with standard deviation error bars
-Quadrant labels: Exciting, Chasing, Boring, Chased (can be altered in the script if you like)

# How to Run
1. Open NHLhitTrend2.m in MATLAB.
2. Make sure 'HittingStats.xlsx' is in the same folder.
3. Run the script to generate the visualizations.
