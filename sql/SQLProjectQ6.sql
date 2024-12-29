SELECT 
    p.drug_name,
    AVG(TIMESTAMPDIFF(HOUR,
        STR_TO_DATE(p.date, '%m/%d/%Y'),
        STR_TO_DATE(pf.date, '%m/%d/%Y'))) AS avg_hours_to_fill
FROM
    prescriptions p
        JOIN
    pharmacy_fills pf ON p.id = pf.prescription_id
GROUP BY p.drug_name;


