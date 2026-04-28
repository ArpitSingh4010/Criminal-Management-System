# Website Migration Guide - Database Cleanup Implementation

## Overview
This guide explains how to apply the database fixes to the Criminal Management System website. The main changes involve consolidating duplicate tables and updating Java code to reference the new schema.

---

## Phase 1: Pre-Migration Checklist

### ✅ Backup Current State
```bash
# Backup the database
mysqldump -u root -p management > criminal_management_backup.sql

# Backup the Java source code
# Use Git: git commit -m "Pre-database-migration backup"
```

### ✅ Review Database Changes
The following tables will be affected:
- `criminal` → Consolidated into `criminal_profile`
- `casedetails` → DELETED (consolidated into `cases`)
- `crime_unnormalized` → DELETED (duplicate of `crime_1nf`)
- `arrest` → Will be POPULATED with all criminals
- `complaint_logs` → Will be POPULATED with history

---

## Phase 2: Update Database

### Step 1: Apply Database Cleanup (Run in MySQL)
```sql
-- From: database_fix_scripts.sql
-- Execute phases in order:

-- Phase 1-5: Clean up tables and fix data
-- [See database_fix_scripts.sql for full details]
```

### Step 2: Verify Database Changes
```sql
-- Verify tables were cleaned up
SHOW TABLES WHERE Tables_in_management NOT IN ('casedetails', 'crime_unnormalized', 'logtable');

-- Verify criminal_profile has all 11 records
SELECT COUNT(*) as criminal_count FROM criminal_profile;
-- Expected: 11

-- Verify Rahul's age was fixed
SELECT Criminal_name, criminal_age FROM criminal_profile WHERE Criminal_name = 'Rahul';
-- Expected: Rahul | 40

-- Verify no NULL case_type_id
SELECT COUNT(*) as null_count FROM criminal_case WHERE case_type_id IS NULL;
-- Expected: 0
```

---

## Phase 3: Update Java Code

### Step 1: Update CriminalsDao.java

**File Location:** `Criminal Mangement/src/main/java/com/Criminals/dao/CriminalsDao.java`

**Changes Required:**
1. Update `getAllCriminals()` query
2. Update `filterCriminals()` query  
3. Update `mapResultSetToCriminal()` mapping
4. Handle missing fields gracefully

**Replace entire file with UPDATED_CriminalsDao.java content provided**

Key Changes:
```java
// OLD
String sql = "select * from criminal";

// NEW
String sql = "SELECT * FROM criminal_profile ORDER BY Criminal_name";

// OLD - mapResultSetToCriminal
criminal.setAge(rs.getString("age"));

// NEW
criminal.setAge(rs.getString("criminal_age")); // Field renamed after consolidation
```

### Step 2: Check Other DAOs (No Changes Usually Needed)

These DAOs reference tables that were NOT changed and should work as-is:
- ✅ LawDao.java - queries `laws` table (unchanged)
- ✅ CaseTypeDao.java - queries `case_types` table (unchanged)
- ✅ AdminCaseDao.java - queries `case_types` table (unchanged)
- ✅ ComplaintDao.java - queries `complaints` table (unchanged)
- ✅ OfficerDao.java - queries `officers` table (unchanged)

**Verify They Still Work:**
```bash
# Run a test query in each DAO to ensure no broken references
# No DAO should reference: casedetails, crime_unnormalized, or logtable
# Use Find/Replace to search for these table names
```

### Step 3: Update JSP Pages (Optional Enhancements)

The JSP pages should work without changes, but can be optimized:

**Criminals.jsp:**
- Currently works (queries criminal data via DAO)
- Can be enhanced to fetch crimeType via JOIN if needed

**CaseTypes.jsp:**
- No changes needed (queries case_types table)

**Laws.jsp:**
- No changes needed (queries laws table)

**Recommendation:** Keep JSP files as-is for now. They reference DAO objects which handle the database queries.

---

## Phase 4: Compilation and Testing

### Step 1: Compile Java Code
```bash
# From project root
./compile.bat

# Or manually
javac -cp "lib/*" -d build/classes src/main/java/com/Criminals/dao/CriminalsDao.java
```

### Step 2: Build WAR File
```bash
# From Criminal Mangement folder
ant war

# Or using provided task
# Build Web App task in VS Code
```

### Step 3: Deploy to Tomcat
```bash
# Option 1: Copy WAR file
copy Criminal Mangement\build\criminal.war C:\apache-tomcat-10.1.52\webapps\

# Option 2: Use provided deploy task
# Quick Deploy JSP task
```

### Step 4: Restart Tomcat
```bash
# In Tomcat bin directory
catalina.bat restart
# or
shutdown.bat && startup.bat
```

---

## Phase 5: Testing Procedures

### Test 1: Verify Criminal Search Still Works
```
1. Navigate to: http://localhost:8080/criminal/Criminals
2. Click "Get All" to load all criminals
   - Expected: 11 criminals displayed
3. Search by name: "Osama"
   - Expected: Find Osama with age 50-55 (may vary)
4. Search by age: "40"
   - Expected: Find Rahul and others (age now fixed to 40)
```

### Test 2: Verify Deleted Tables Don't Break System
```
1. Check application logs for table not found errors:
   - No "Table 'management.casedetails' doesn't exist"
   - No "Table 'management.crime_unnormalized' doesn't exist"
   - No "Table 'management.logtable' doesn't exist"
2. All searches should work normally
```

### Test 3: Verify Data Consistency
```
Database Query:
SELECT cp.Criminal_name, cp.criminal_age, cp.wanted
FROM criminal_profile cp
ORDER BY cp.Criminal_name;

Expected Results:
- 11 records displayed
- Rahul should have criminal_age = 40
- All names match JSP display
```

### Test 4: Case Type and Law Search
```
1. Navigate to Case Types page
   - All 20 case types should display
2. Search for "Theft"
   - Should return 1 result
3. Navigate to Laws page
   - All 50 laws should display
4. Filter by act_name: "Indian Penal Code"
   - Should return relevant results
```

### Test 5: File a Complaint
```
1. File a complaint from public page
   - Complaint should save successfully
2. Check complaint_logs table
   - Entry should exist with status
```

---

## Phase 6: Troubleshooting

### Issue: "Column 'age' doesn't exist"
**Cause:** CriminalsDao.java still references old table
**Solution:** Replace with UPDATED_CriminalsDao.java content

### Issue: "Table 'casedetails' doesn't exist"
**Cause:** Code references deleted table
**Solution:** 
```bash
# Search for table references
grep -r "casedetails" "Criminal Mangement/src/"
grep -r "crime_unnormalized" "Criminal Mangement/src/"

# Replace with correct table names
```

### Issue: Criminals display shows NULL for certain fields
**Cause:** Field mapping doesn't match new schema
**Solution:** Check Criminal model getters/setters and DAO mapping

### Issue: Age shows incorrect value
**Cause:** Data wasn't synced properly
**Solution:**
```sql
-- Verify the data
SELECT Criminal_name, criminal_age FROM criminal_profile WHERE Criminal_name = 'Rahul';

-- If still showing 80, re-run fix
UPDATE criminal_profile SET criminal_age = 40 
WHERE Criminal_name = 'Rahul' AND criminal_age = 80;
```

---

## Phase 7: Post-Migration Verification

### ✅ Code Quality Checks
```bash
# No references to old tables
grep -r "FROM casedetails" "Criminal Mangement/src/"  # Should return nothing
grep -r "FROM crime_unnormalized" "Criminal Mangement/src/"  # Should return nothing

# No compilation errors
cd "Criminal Mangement"
ant clean
ant war
# Should complete without errors
```

### ✅ Performance Verification
```sql
-- Check query performance (should execute in < 100ms)
EXPLAIN SELECT * FROM criminal_profile ORDER BY Criminal_name;

-- Check index usage
SELECT * FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_NAME = 'criminal_profile';

-- Expected indexes:
-- - PRIMARY KEY on Criminal_no
-- - Index on Criminal_name (for search)
```

### ✅ Data Integrity
```sql
-- No orphaned records
SELECT * FROM case_criminal WHERE Criminal_no NOT IN (SELECT Criminal_no FROM criminal_profile);
-- Expected: 0 rows

-- All case types have references
SELECT * FROM criminal_case WHERE case_type_id IS NULL;
-- Expected: 0 rows

-- Total records check
SELECT COUNT(*) FROM criminal_profile;             -- Expected: 11
SELECT COUNT(*) FROM cases;                        -- Expected: 10
SELECT COUNT(*) FROM case_types;                   -- Expected: 20
SELECT COUNT(*) FROM laws;                         -- Expected: 50
SELECT COUNT(*) FROM officers;                     -- Expected: 50
```

---

## Phase 8: Rollback Plan (If Needed)

### Rollback to Previous State
```bash
# Restore database from backup
mysql -u root -p management < criminal_management_backup.sql

# Revert Java code
git revert HEAD
# or replace with original CriminalsDao.java

# Rebuild and redeploy
cd "Criminal Mangement"
ant clean war
# Restart Tomcat
```

---

## Summary of Changes

| Component | Before | After | Impact |
|-----------|--------|-------|--------|
| **Criminal Table** | `criminal` (10 rows) | `criminal_profile` (11) | Medium - DAO updated |
| **Case Details** | `casedetails` | `cases` (consolidated) | Low - Not used by website |
| **Crime Data** | 2 tables (crime_1nf, crime_unnormalized) | `crime_1nf` only | Low - Not directly used |
| **Arrest Log** | 2 records | 11 records | Low - Audit trail only |
| **Age (Rahul)** | 80 years | 40 years | Low - Data cleanup |
| **NULL case_type_id** | 2 records | 0 records | Medium - Data integrity |

---

## Files Modified/Created

### Created (New Version):
- ✅ `UPDATED_CriminalsDao.java` - Updated DAO for consolidated schema

### To Be Updated:
- ⚠️ `Criminal Mangement/src/main/java/com/Criminals/dao/CriminalsDao.java` - Replace with updated version

### Unchanged:
- ✅ All JSP files
- ✅ All other DAO files
- ✅ All servlet classes
- ✅ Configuration files

---

## Next Steps

1. **Backup database** (mysql dump)
2. **Run database_fix_scripts.sql** in order
3. **Replace CriminalsDao.java** with updated version
4. **Rebuild project** (ant war)
5. **Restart Tomcat**
6. **Test thoroughly** using Test Procedures above
7. **Monitor application logs** for errors
8. **Verify data integrity** with SQL queries

---

**Estimated Migration Time:** 30-45 minutes  
**Risk Level:** LOW (with backup in place)  
**Rollback Time:** 10 minutes (database restore)

