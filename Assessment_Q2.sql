-- Transaction Frequency Analysis
WITH txn_per_customer AS (
    SELECT 
        owner_id, 
        COUNT(*) AS total_txns,
        (DATE_PART('year', MAX(date)) - DATE_PART('year', MIN(date))) * 12 +
        (DATE_PART('month', MAX(date)) - DATE_PART('month', MIN(date))) + 1 AS months_active
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id
),
txn_categories AS (
    SELECT 
        t.owner_id,
        ROUND(total_txns::numeric / NULLIF(months_active, 0), 2) AS avg_txn_per_month,
        CASE 
            WHEN total_txns::numeric / NULLIF(months_active, 0) >= 10 THEN 'High Frequency'
            WHEN total_txns::numeric / NULLIF(months_active, 0) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        txn_per_customer t
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM 
    txn_categories
GROUP BY 
    frequency_category;
