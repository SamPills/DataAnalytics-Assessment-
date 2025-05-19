-- Account Inactivity Alert
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.fund = 1 THEN 'Investment'
        ELSE 'Savings'
    END AS type,
    MAX(s.date) AS last_transaction_date,
    DATE_PART('day', CURRENT_DATE - MAX(s.date)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.owner_id = s.owner_id
WHERE 
    p.confirmed_amount > 0
GROUP BY 
    p.id, p.owner_id, p.fund
HAVING 
    MAX(s.date) IS NULL 
    OR MAX(s.date) < CURRENT_DATE - INTERVAL '365 days';
