WITH drugpurchaseprice AS (
    SELECT c.drug_name AS drug_name, c.pharmacy_id AS pharmacy, c.price/c.quantity AS contract_price
    FROM contracts c
    
),
pharmacyfillcost AS (
	SELECT pr.drug_name AS drug_name, pf.pharmacy_id AS pharmacy, pf.cost/pr.quantity AS fill_cost
    FROM pharmacy_fills pf
    INNER JOIN prescriptions pr
    ON pr.id = pf.prescription_id
)
SELECT 
    dpp.drug_name,
    dpp.pharmacy,
    (pfc.fill_cost - dpp.contract_price)/dpp.contract_price * 100 AS percentage_markup
FROM drugpurchaseprice dpp
LEFT JOIN pharmacyfillcost pfc
    ON dpp.drug_name = pfc.drug_name AND dpp.pharmacy = pfc.pharmacy;
