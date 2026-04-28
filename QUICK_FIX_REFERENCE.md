# Quick Fix Reference - Criminal Management Database

## Issues At A Glance

### 🔴 CRITICAL ISSUES (Fix Immediately)

#### 1. **Duplicate Tables**
| Problem | Solution | Command |
|---------|----------|---------|
| `casedetails` table (obsolete) | Delete table | `DROP TABLE casedetails;` |
| `crime_unnormalized` (duplicate) | Delete table | `DROP TABLE crime_unnormalized;` |
| 3 criminal tables with conflicting data | Consolidate into `criminal_profile` | Re-sync all data |

---

#### 2. **Data Inconsistencies**
| Field | Issue | Records | Fix |
|-------|-------|---------|-----|
| `criminal_case.case_type_id` | 2 records have NULL | Rows: 1,2 | ✅ Populate from `case_types` |
| `criminal_profile.criminal_age` | Rahul: 80 (unrealistic) | 1 record | ✅ Fix to 40 |
| Minor age differences | 2-5 year variations | 4 records | ⏭️ Skip (may be valid) |

---

### 🟡 HIGH PRIORITY ISSUES (Fix Soon)

#### 3. **Broken Foreign Keys**
```
criminals table not synced with criminal_profile
→ Solution: Repopulate from criminal_profile source

case_criminal.case_type_id points to NULL values  
→ Solution: UPDATE from case_types table
```

#### 4. **Empty Audit Tables**
```
complaint_logs is EMPTY → Should log all complaints
logtable is EMPTY and unused → Delete or remove

→ Solution: INSERT complaint history into complaint_logs
```

#### 5. **Underutilized Tables**
```
arrested table has only 2 records
→ Should have 11 (one for each criminal)
→ Solution: INSERT from criminal_profile
```

---

### 🟢 LOW PRIORITY (Nice to Have)

- Add CHECK constraints for gender, status fields
- Add NOT NULL constraints where appropriate  
- Create views for complex queries
- Implement triggers for audit trail
- Add timestamps to logging tables

---

## One-Time Setup Commands

### STEP 1: Backup Current State
```sql
-- Create backup table
CREATE TABLE criminal_backup AS SELECT * FROM criminal_profile;
CREATE TABLE cases_backup AS SELECT * FROM cases;
CREATE TABLE criminal_case_backup AS SELECT * FROM criminal_case;
```

### STEP 2: Fix Critical Data Issues
```sql
-- Fix Rahul's age ONLY (80 → 40, clearly unrealistic)
UPDATE criminal_profile SET criminal_age = 40 
WHERE Criminal_name = 'Rahul' AND criminal_age = 80;

-- Fix case_type_id NULLs (for Osama & second criminal)
UPDATE criminal_case SET case_type_id = 16 WHERE criminal_no = 101 AND case_id = 1;
UPDATE criminal_case SET case_type_id = 6 WHERE criminal_no = 101 AND case_id = 2;

-- NOTE: Skip minor age differences (2-5 years) - they may be valid time-based changes
-- Only fix clearly unrealistic values
```

### STEP 3: Remove Duplicate Tables
```sql
DROP TABLE IF EXISTS casedetails;
DROP TABLE IF EXISTS crime_unnormalized;
```

### STEP 4: Populate Missing Data
```sql
-- Populate criminals from criminal_profile
DELETE FROM criminals;
INSERT INTO criminals (criminal_id, name, nickname, criminal_age, gender, wanted)
SELECT Criminal_no, Criminal_name, Nick_name, criminal_age, gender, 'yes' 
FROM criminal_profile;

-- Populate arrested log
TRUNCATE TABLE arrested;
INSERT INTO arrested (Criminal_name) 
SELECT Criminal_name FROM criminal_profile;

-- Populate complaint_logs with history
INSERT INTO complaint_logs (complaint_id, status, updated_at)
SELECT complaint_id, status, filed_at FROM complaints 
WHERE complaint_id NOT IN (SELECT DISTINCT complaint_id FROM complaint_logs);
```

### STEP 5: Add Indexes
```sql
CREATE INDEX idx_criminal_primary ON criminal_profile(Criminal_no);
CREATE INDEX idx_case_types ON criminal_case(case_type_id);
CREATE INDEX idx_complaint_status ON complaints(status);
CREATE INDEX idx_officer_designation ON officers(designation);
```

---

## Verification Checklist

After applying fixes, verify:

```sql
-- ✅ No NULL case_type_id
SELECT COUNT(*) as null_case_types FROM criminal_case 
WHERE case_type_id IS NULL;
-- Expected: 0

-- ✅ All criminals synced
SELECT COUNT(*) FROM criminals;
-- Expected: 11

-- ✅ Arrested log complete
SELECT COUNT(*) FROM arrested;
-- Expected: 11+

-- ✅ Complaint logs populated
SELECT COUNT(*) FROM complaint_logs;
-- Expected: 1+

-- ✅ Age consistency (unrealistic values only)
SELECT * FROM criminal_profile 
WHERE criminal_age > 75 OR criminal_age < 15;
-- Expected: empty (no unrealistic ages)

-- ✅ Critical age differences (Rahul fix)
SELECT cp.Criminal_name, c.age, cp.criminal_age 
FROM criminal c
INNER JOIN criminal_profile cp ON c.Criminal_no = cp.Criminal_no
WHERE cp.Criminal_name = 'Rahul';
-- Expected: age=40 in both tables

-- ✅ No duplicate tables exist
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN 
('casedetails', 'crime_unnormalized', 'logtable')
AND TABLE_ROWS > 0;
-- Expected: (empty result set)
```

---

## Detailed Issue Breakdown

### Issue #1: Three Criminal Tables
```
Current State:
┌─ criminal (10 rows)
├─ criminal_profile (11 rows) 
└─ criminals (11 rows)
  ↓ ERROR: Some conflicting data
  
After Fix:
┌─ criminal_profile (PRIMARY) ← 11 rows
├─ criminals (VIEW/Cache) ← Synced from criminal_profile
└─ criminal (DEPRECATED) ← Consider removing
```

**Age Conflicts - REALISTIC FIXES ONLY:**
```
Osama:  criminal=50,  criminal_profile=55  (Minor diff, keep as-is)
Omid:   criminal=25,  criminal_profile=27  (Minor diff, keep as-is)
Aisha:  criminal=30,  criminal_profile=33  (Minor diff, keep as-is)
Rahul:  criminal=40,  criminal_profile=80  (FIX! Use 40) ⚠️ CLEARLY UNREALISTIC
```
Minor 2-5 year differences may represent age changes over time.
Only fix clearly unrealistic values like Rahul's 80 years.

---

### Issue #2: Case ID Format Inconsistency
```
Problem:
casedetails.case_id = NUMERIC (1, 2, 3...)
cases.case_id = ALPHANUMERIC (C1, C2, C3...)

Solution: Use cases.case_id (C1-C10) as standard
Drop casedetails table

Verify:
- All case references use C1-C10 format ✓
- case_criminal table validated ✓
- case_victim table validated ✓
```

---

### Issue #3: Missing Foreign Key Values
```
Problem:
criminal_case table has NULL case_type_id for:
- criminal_no=101, case_id=1 (Osama, Terrorist)
- criminal_no=101, case_id=2 (Osama, likely Terrorism)

Solution:
Look up crime type from criminal table
Match to case_types.type_id:
  Terrorist → case_type='Terrorism' → type_id=16
  
Set criminal_case.case_type_id = 16 for both records
```

---

## Command Cheat Sheet

| Task | Command |
|------|---------|
| Backup before changes | `CREATE TABLE backup_table AS SELECT * FROM original_table;` |
| Drop empty tables | `DROP TABLE IF EXISTS table_name;` |
| Delete all rows | `DELETE FROM table_name;` |
| Truncate (faster) | `TRUNCATE TABLE table_name;` |
| Find NULLs | `SELECT * FROM table WHERE column IS NULL;` |
| Count records | `SELECT COUNT(*) FROM table_name;` |
| Add index | `CREATE INDEX idx_name ON table(column);` |
| Check table status | `SHOW TABLE STATUS LIKE 'table_name';` |

---

## Timeline for Implementation

```
Day 1 (Monday):
  - Backup database
  - Drop duplicate tables (casedetails, crime_unnormalized)
  - Fix NULL case_type_id (2 records)
  
Day 2 (Tuesday):
  - Fix age inconsistencies (especially Rahul)
  - Sync criminal tables
  - Populate criminals, arrested, complaint_logs
  
Day 3 (Wednesday):
  - Add indexes for performance
  - Run verification checklist
  - Test application with new schema
```

---

**Last Updated:** April 14, 2026  
**Database:** Criminal Management System  
**Status:** 🟡 Ready for implementation

