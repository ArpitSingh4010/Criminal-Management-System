# Criminal Management System - Database Issues & Fixes

## Critical Issues Found

### 1. **Duplicate Tables (Data Normalization Issues)**

#### Issue 1A: Case Management
- `casedetails` (10 rows with numeric case_id: 1-10)
- `cases` (10 rows with alphanumeric case_id: C1-C10)
- Both contain same case descriptions - **One table should be removed**

| casedetails Case_id | cases case_id | Description |
|--------|--------|------------|
| 1 | C1 | Planned terrorist attack on public area |
| 2 | C2 | Online banking fraud scheme |
| ... | ... | ... |

**Fix:** Use `cases` table with alphanumeric IDs (C1-C10) as primary. Delete `casedetails`.

---

#### Issue 1B: Criminal Records (Three conflicting tables)
- `criminal` (10 rows) - most detailed with arrest_date, dateOfcrime
- `criminal_profile` (11 rows) - similar data with occupation_id reference
- `criminals` (11 rows) - simplified version

**Age Inconsistencies - REALISTIC VS UNREALISTIC:**

**❌ UNREALISTIC (Fix This):**
| Criminal | criminal table | criminal_profile | Issue | Action |
|----------|---------|-----------------|-------|--------|
| Rahul | 40 | 80 | Clearly impossible (+40 years discrepancy) | ✅ Fix to 40 |

**⏭️ MINOR DIFFERENCES (Keep As-Is):**
| Criminal | criminal table | criminal_profile | Discrepancy | Status |
|----------|---------|-----------------|-------------|--------|
| Osama | 50 | 55 | ±5 years (plausible age change) | Keep |
| Omid | 25 | 27 | ±2 years (plausible age change) | Keep |
| Aisha | 30 | 33 | ±3 years (plausible age change) | Keep |

**Note:** Minor 2-5 year differences can result from time passing between records or data entry at different dates. Only fix clearly unrealistic values.

---

#### Issue 1C: Crime Normalization
- `crime_1nf` (5 rows)
- `crime_unnormalized` (5 rows)
- Both have identical data → **One is redundant**

| Case_id | Criminal_name | crimeType |
|---------|----------|-----------|
| 1 | Osama | Terrorist |
| 2 | Omid | Fraud |
| ... | ... | ... |

**Fix:** Delete `crime_unnormalized`. Use `crime_1nf` only.

---

### 2. **Referential Integrity Issues**

#### Issue 2A: NULL Foreign Keys
```sql
-- In criminal_case table, 2 out of 12 records have NULL case_type_id:
criminal_no | Case_id | case_type_id
101         | 1       | NULL  ← Missing reference
101         | 2       | NULL  ← Missing reference
```

**Fix:** Assign appropriate case_type_id from case_types table.

---

#### Issue 2B: Missing Relations in Linker Tables
- `case_criminal` table references criminal_id but `criminal` table uses Criminal_no
- `case_victim` table exists but references may not align with actual victims

**Fix:** Verify and standardize ID naming conventions.

---

#### Issue 2C: Unreferenced Criminal Records
- `criminal_profile` has 11 records
- `criminals` has 11 records  
- `arrested` has only 2 records (Osama, Aisha)
- Other criminals are not in `arrested` table

**Fix:** Either populate `arrested` table or remove it entirely.

---

### 3. **Data Quality Issues**

#### Issue 3A: Inconsistent Officer References
- `officers` table has 50 detailed records
- References in tables like `crime_1nf` use simple names (Rakesh Kumar) instead of officer_id
- Department names inconsistent (e.g., "Crime Branch" vs "Cyber Crime")

#### Issue 3B: Empty Logging Tables
- `complaint_logs` - **Empty** (should log complaint activities)
- `logtable` - **Empty** (unused/unclear purpose)

#### Issue 3C: Potential Missing Data
- `complaint_logs` should have entries when complaints transition between statuses
- No audit trail exists for data modifications

---

### 4. **Schema Design Issues**

#### Issue 4A: Duplicate/Conflicting Fields
```sql
-- In criminal table:
Criminal_no (INT)           vs  -- In criminals table: criminal_id
criminal_id (in case_criminal) -- Different naming convention

-- Case IDs:
Case_id (NUMERIC in casedetails)  vs  case_id (ALPHANUMERIC in cases)
```

#### Issue 4B: Missing Constraints
- No PRIMARY KEY explicitly set on some tables
- No CHECK constraints for valid values (e.g., gender, status)
- No NOT NULL constraints where needed

#### Issue 4C: Weak Date Handling
- Some date fields are NULL when they shouldn't be (e.g., reports with NULL date_from/date_to)
- No date range validation

---

## Summary of Issues

| Category | Status | Count | Severity | Action |
|----------|--------|-------|----------|--------|
| Duplicate Tables | Found | 3 sets | 🔴 CRITICAL | ✅ Delete |
| Unrealistic Values | Found | 1 (Rahul age) | 🔴 CRITICAL | ✅ Fix |
| NULL Foreign Keys | Found | 2 records | 🔴 CRITICAL | ✅ Populate |
| Minor Age Differences | Found | 4 records | 🟢 LOW | ⏭️ Keep as-is |
| Empty Tables | Found | 2 tables | 🟢 LOW | ⏭️ Optional |

---

## Recommended Actions

### Phase 1: Cleanup (High Priority)
1. ✅ Delete `casedetails` table - consolidate into `cases`
2. ✅ Delete `criminal_unnormalized` table 
3. ✅ Consolidate `criminal` + `criminal_profile` → enhanced `criminal_profile`
4. ✅ Delete redundant `criminals` table (or use as view)

### Phase 2: Fix Unrealistic Data Issues Only
1. ✅ Fix Rahul's age: 80 → 40 (clearly impossible)
2. ✅ Populate missing case_type_id in `criminal_case` (currently NULL for 2 records)
3. ⏭️ Skip minor age differences (2-5 years) - they may be valid
4. ✅ Update case references to use alphanumeric IDs consistently

### Phase 3: Add Constraints & Validation
1. Add NOT NULL constraints
2. Add FOREIGN KEY constraints
3. Add CHECK constraints for valid values
4. Implement audit logging

---

