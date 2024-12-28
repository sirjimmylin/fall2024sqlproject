DELIMITER //

CREATE TRIGGER alert_addition
AFTER INSERT ON prescriptions
FOR EACH ROW
BEGIN
    DECLARE earlier_drug VARCHAR(128);
    DECLARE interaction_exists INT;

    -- Find an earlier prescribed drug that interacts with the new drug
    SELECT p.drug_name INTO earlier_drug
    FROM prescriptions p
    JOIN adverse_interactions ai ON (p.drug_name = ai.drug1 AND NEW.drug_name = ai.drug2)
                              OR (p.drug_name = ai.drug2 AND NEW.drug_name = ai.drug1)
    WHERE p.patient_id = NEW.patient_id
      AND p.date < NEW.date
    LIMIT 1;

    -- Check if an interaction exists
    SET interaction_exists = (earlier_drug IS NOT NULL);

    -- If an interaction exists, insert an alert
    IF interaction_exists THEN
        INSERT INTO alerts (patient_id, physician_id, alert_date, drug1, drug2)
        VALUES (
            NEW.patient_id,
            NEW.physician_id,
            NEW.date,
            earlier_drug,
            NEW.drug_name
        );
    END IF;
END//

DELIMITER ;


