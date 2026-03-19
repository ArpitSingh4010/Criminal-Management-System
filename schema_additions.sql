-- ============================================================
-- Crime Tracker – SQL Setup Instructions for MySQL Terminal
-- Run these commands one by one in your MySQL terminal
-- Database: management  (same as the existing Java project)
-- ============================================================

-- STEP 1: Select the existing database
USE management;

-- STEP 2: Create the complaints table
-- (stores complaints filed by registered users/victims)
CREATE TABLE IF NOT EXISTS complaints (
    complaint_id      INT AUTO_INCREMENT PRIMARY KEY,
    username          VARCHAR(50)  NOT NULL,
    crime_type        VARCHAR(45)  NOT NULL,
    description       TEXT,
    incident_date     DATE,
    incident_location VARCHAR(255),
    status            VARCHAR(20)  DEFAULT 'Pending',
    filed_at          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE
);

-- STEP 3: Create complaint audit log table
CREATE TABLE IF NOT EXISTS complaint_logs (
    log_id       INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT,
    old_status   VARCHAR(20),
    new_status   VARCHAR(20),
    changed_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id) ON DELETE CASCADE
);

-- STEP 4: Create trigger to auto-log status changes
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS trg_complaint_status_log
AFTER UPDATE ON complaints
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO complaint_logs (complaint_id, old_status, new_status, changed_at)
        VALUES (NEW.complaint_id, OLD.status, NEW.status, NOW());
    END IF;
END $$
DELIMITER ;

-- STEP 5: Verify the tables were created
SHOW TABLES;

-- STEP 6: (Optional) Insert a sample complaint to test
-- INSERT INTO complaints (username, crime_type, description, incident_date, incident_location)
-- VALUES ('testuser', 'Theft', 'My bike was stolen near the market.', '2026-03-15', 'MG Road, Bengaluru');

SELECT 'Setup complete! Tables created successfully.' AS result;
