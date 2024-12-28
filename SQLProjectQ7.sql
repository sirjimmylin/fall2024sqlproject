(SELECT p.id AS pharmacy_id, p.name AS pharmacy_name, pr.drug_name
 FROM pharmacies p
 CROSS JOIN prescriptions pr)
EXCEPT
(SELECT pf.pharmacy_id, p.name AS pharmacy_name, pr.drug_name
 FROM pharmacy_fills pf
 JOIN pharmacies p ON pf.pharmacy_id = p.id
 JOIN prescriptions pr ON pf.prescription_id = pr.id)
ORDER BY pharmacy_id, drug_name;

