Return & Risk Analysis – Client #148 (Paul Bistre)

📌 Project Overview

This project focuses on portfolio performance evaluation and risk assessment for Client #148, Paul Bistre, using SQL for data extraction and Tableau for visualization. The goal was to provide actionable insights into asset allocation, performance trends, and risk-adjusted returns, along with clear recommendations for portfolio rebalancing.

The deliverable combines both technical SQL outputs and business storytelling dashboards, culminating in a report that balances quantitative rigor with strategic recommendations.

🔎 Analysis Workflow
Part 1 – SQL Extraction & Calculations

Created a Client View in the invest schema containing only Client #148’s holdings, enriched with asset classifications, prices, and dates.

SQL Queries Executed:

Calculated returns for the past 12, 18, and 24 months for each security and the overall portfolio.

Computed volatility (sigma) and average daily returns per security.

Assessed the impact of introducing a new investment and its contribution to overall portfolio risk.

Derived risk-adjusted returns for each security to identify the best performers
.

Part 2 – Visualization & Business Report

Exported the SQL results into Tableau and built an interactive dashboard to illustrate:

Portfolio Holdings by major/minor asset classes.

Holdings Distribution by asset value ranges.

Risk vs. Risk-Adjusted Returns scatterplots.

Risk & Returns Tradeoff (average daily return vs sigma).

Returns by Time Horizon (12M, 18M, 24M) across asset classes
.

Developed a 1000–1500 word management report with findings, insights, and actionable recommendations.

📊 Key Findings

Overconcentration in Equities

Heavy exposure to large-cap stocks drives returns but increases portfolio volatility.

Lack of Diversification

Minimal allocations to fixed income and alternatives reduce portfolio stability.

Commodities and alternatives could provide hedging opportunities.

Risk-Return Tradeoff

Equities yield strong absolute returns but weaker risk-adjusted performance.

Fixed income offers lower but consistent returns, ideal for stabilization.

Time Horizon Performance

Equity returns fluctuate heavily in the short term but improve over longer horizons (18–24 months).

Fixed income and commodities show steady performance across all horizons
.

💡 Recommendations

Diversify Portfolio: Increase allocations to fixed income and alternative assets (e.g., gold, REITs) to stabilize returns and hedge equity risk.

Optimize High Performers: Retain equities with strong risk-adjusted returns, while reallocating from underperformers into bonds and alternatives.

Adopt a Time-Oriented Strategy:

Long-Term (18–24M): Growth-focused equities with proven performance.

Short-Term (12M): Capital-protecting fixed income and commodities.

Monitor Risk Metrics Continuously: Track sigma and average returns across timeframes using dashboards for proactive rebalancing
.

🗂️ Deliverables

Return_and_Risk_Analysis_Client148.pdf – Final report (SQL queries, results, visuals, and recommendations).

Tableau Dashboard – Interactive visualization of holdings, risk, and returns.

README.md – Project overview (this file).

🚀 Key Takeaways

A data-driven risk-return analysis revealed equity overexposure as the main vulnerability in Client #148’s portfolio.

Diversification into fixed income and alternatives is essential for achieving balance and stability.

Dashboards and ongoing monitoring enable dynamic portfolio management, ensuring alignment with both short-term protection and long-term growth objectives
