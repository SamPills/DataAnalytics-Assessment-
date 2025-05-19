# Data Analytics SQL Assessment

This repository contains SQL-based solutions to four practical data analytics assessments. The focus is on analyzing customer behavior, transaction trends, and financial value metrics using PostgreSQL.

## Repository Structure
DataAnalytics-Assessment/ 
├── Assessment_Q1.sql 
├── Assessment_Q2.sql 
├── Assessment_Q3.sql 
├── Assessment_Q4.sql 
└── README.md
## Assessment Overview

### Q1: High-Value Customers with Multiple Products
- **Objective:** Identify customers with at least one funded savings plan and one funded investment plan.
- **Approach:** Join savings and investment tables, filter by funded status, group by customer, and order by total deposits.

### Q2: Transaction Frequency Analysis
- **Objective:** Calculate average transactions per customer per month and categorize activity levels.
- **Approach:** Use window functions and date calculations to compute transaction frequency, then classify into high, medium, or low.

### Q3: Account Inactivity Alert
- **Objective:** Find active accounts with no inflow in the last 365 days.
- **Approach:** Compare latest transaction dates to current date; filter accounts with no activity within the threshold.

### Q4: Customer Lifetime Value (CLV) Estimation
- **Objective:** Estimate customer lifetime value based on tenure and transaction volume.
- **Approach:** Calculate customer tenure in months and use a scaled formula to derive CLV.

## Notes
- Amounts are stored in Kobo and converted to Naira (by dividing by 100).
- Tenure and date differences are calculated in months.
- All queries are designed for PostgreSQL but can be adapted to other SQL dialects.
