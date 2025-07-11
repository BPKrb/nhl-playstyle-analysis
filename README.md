# nhl-playstyle-analysis
Trying to quantify play style using hits/minute and xG. All data normalized per 60mins. Data courtesy of https://moneypuck.com 
# NHL Hit vs xG Analysis

Analyzing NHL team-level performance across seasons by visualizing the relationship between:

- **Normalized Hits For** (hits per 60mins at 5on5)
- **Normalized Expected Goals For** (xG per 60mins at 5on5)

It generates:
-One scatter plot per season, with each team's data point labeled
-A summary plot showing seasonal means (without standard deviation error bars, as they crowd the graph but you could add)
-Quadrant labels: Exciting, Chasing, Boring, Chased (can be altered in the script if you like)

# How to Run
1. Open NHLhitTrend2.m in MATLAB.
2. Make sure 'HittingStats.xlsx' is in the same folder.
3. Run the script to generate the visualizations.

Example from 2014-15
<img width="3456" height="2058" alt="1415" src="https://github.com/user-attachments/assets/f0ca756d-a9cc-4a88-afa7-a7bd60158de6" />
