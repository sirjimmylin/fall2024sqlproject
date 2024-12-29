WITH alert_causing_prescriptions AS (
    SELECT DISTINCT
        p2.physician_id,
        p2.id AS prescription_id
    FROM 
        prescriptions p1
    JOIN 
        prescriptions p2 ON p1.patient_id = p2.patient_id
    JOIN
        adverse_interactions ai 
        ON (ai.drug_name = p1.drug_name AND ai.drug_name_2 = p2.drug_name)
        OR (ai.drug_name_2 = p1.drug_name AND ai.drug_name = p2.drug_name)
    WHERE 
        p1.date < p2.date
        AND p1.id <> p2.id
),
physician_alert_counts AS (
    SELECT 
        physician_id,
        COUNT(DISTINCT prescription_id) AS alert_count
    FROM 
        alert_causing_prescriptions
    GROUP BY 
        physician_id
)
SELECT 
    p.ssn,
    pac.alert_count
FROM 
    physicians p
JOIN 
    physician_alert_counts pac ON p.ssn = pac.physician_id
WHERE 
    pac.alert_count = (
        SELECT MAX(alert_count)
        FROM physician_alert_counts
    )
ORDER BY 
    p.ssn;

