SELECT 
    physicians.ssn,
    COUNT(DISTINCT prescriptions.drug_name) AS prescribed_drugs_count
FROM
    physicians
        INNER JOIN
    prescriptions ON prescriptions.physician_id = physicians.ssn
        INNER JOIN
    drugs ON drugs.name = prescriptions.drug_name
        INNER JOIN
    contracts ON contracts.drug_name = drugs.name
        INNER JOIN
    companies ON companies.id = contracts.company_id
WHERE
    companies.name = 'DRUGXO'
GROUP BY physicians.ssn
ORDER BY prescribed_drugs_count DESC
LIMIT 1;