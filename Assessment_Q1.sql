-- High-Value Customers with Multiple Products
SELECT 
    cu.id AS owner_id,
    cu.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits
FROM 
    customuser cu
JOIN 
    savings_savingsaccount s ON cu.id = s.owner_id
JOIN 
    plans_plan p ON cu.id = p.owner_id
WHERE 
    s.confirmed_amount > 0 
    AND p.fund = 1 
    AND p.confirmed_amount > 0
GROUP BY 
    cu.id, cu.name
HAVING 
    COUNT(DISTINCT s.id) >= 1 
    AND COUNT(DISTINCT p.id) >= 1
ORDER BY 
    total_deposits DESC;
