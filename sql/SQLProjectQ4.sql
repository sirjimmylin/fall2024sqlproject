WITH avg_prices AS (
    SELECT 
        drug_name,
        AVG(price) AS avg_price
    FROM 
        contracts
    GROUP BY 
        drug_name
)
SELECT 
    c.drug_name,
    c.price AS pharmasee_price,
    ap.avg_price
FROM 
    contracts c
JOIN 
    companies co ON c.company_id = co.id
JOIN 
    avg_prices ap ON c.drug_name = ap.drug_name
WHERE 
    co.name = 'PHARMASEE';


