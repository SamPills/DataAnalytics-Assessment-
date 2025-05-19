-- Customer Lifetime Value (CLV) Estimation
WITH txn_data AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.owner_id
),
tenure_data AS (
    SELECT 
        cu.id AS customer_id,
        cu.name,
        DATE_PART('year', CURRENT_DATE) * 12 + DATE_PART('month', CURRENT_DATE) -
        (DATE_PART('year', cu.date_joined) * 12 + DATE_PART('month', cu.date_joined)) AS tenure_months
    FROM 
        customuser cu
)
SELECT 
    t.customer_id,
    t.name,
    td.tenure_months,
    tx.total_transactions,
    ROUND((tx.total_transactions::numeric / NULLIF(td.tenure_months, 0)) * 12 * 0.001, 2) AS estimated_clv
FROM 
    tenure_data td
JOIN 
    txn_data tx ON td.customer_id = tx.owner_id
JOIN 
    customuser t ON t.id = td.customer_id
ORDER BY 
    estimated_clv DESC;
