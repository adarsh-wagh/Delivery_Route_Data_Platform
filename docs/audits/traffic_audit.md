# Traffic Table Audit

## Table Overview

| Metric | Value |
|---------|---------|
| Rows | 150,000 |
| Columns | 6 |

---

## Audit Methodology

Audit notebook:

- [Traffic Audit Notebook](../notebooks/02_traffic_audit.ipynb)

The audit includes:

- Missing value analysis
- Duplicate detection
- Primary key validation
- Data type validation
- Category standardization checks
- Business rule validation

---

## Issues Identified

### 1. Missing Values

| Column | Missing Count | Percentage |
|----------|----------|----------|
| day_of_week | 6,000 | 4% |
| zone_type | 7,500 | 5% |
| traffic_level | 10,500 | 7% |
| avg_speed_kmph | 9,000 | 6% |

---

### 2. Duplicate Records

| Check | Result |
|---------|---------|
| Fully Duplicated Rows | 0 |

---

### 3. Primary Key Assessment

#### Candidate Primary Key

`traffic_id`

#### Findings

| Check | Result |
|---------|---------|
| NULL Values | 0 |
| Unique Values | 145,633 |
| Duplicate Values | 4,367 |

#### Assessment

❌ `traffic_id` cannot currently be used as a Primary Key.

Reasons:

- Duplicate values detected
- Uniqueness requirement is not met

---

### 4. Data Standardization Issues

#### hour

| Validation Check | Count |
|------------------|--------|
| Negative Values | 944 |
| Zero Values | 6,110 |

Assessment:

- Negative values are invalid
- Hour value `0` is valid and represents midnight (00:00)

---

#### day_of_week

Issues:

- Mixed representations of weekdays
- Missing values

Examples:

```text
Monday
Mon
1
```

Recommended Action:

- Standardize all values to a single format

---

#### zone_type

Issues:

- Inconsistent casing
- Spelling errors
- Missing values

Recommended Action:

- Standardize category values
- Correct spelling inconsistencies
- Handle missing values

---

#### traffic_level

Issues:

- Inconsistent casing
- Spelling errors
- Missing values

Recommended Action:

- Standardize category values
- Correct spelling inconsistencies
- Handle missing values

---

#### avg_speed_kmph

| Validation Check | Count |
|------------------|--------|
| Missing Values | 9,000 |
| Negative Values | 704 |
| Zero Values | 1,448 |

Assessment:

- Negative values are invalid
- Zero values require investigation
- Missing values require remediation

---

## Recommended Silver Layer Actions

### Data Cleaning

- Resolve duplicate traffic_id records
- Handle missing values
- Correct invalid numeric values

### Data Standardization

- Standardize day_of_week
- Standardize zone_type
- Standardize traffic_level

### Data Validation

- Verify business category values
- Validate hour values
- Validate traffic speed ranges

---

## Primary Key Status

| Attribute | Status |
|------------|------------|
| Candidate Key | traffic_id |
| NULL Check | ✅ Passed |
| Uniqueness Check | ❌ Failed |
| Primary Key Ready | ❌ No |

---

## Final Assessment

`traffic_id` is the most likely business key for the Traffic table. However, duplicate values prevent it from serving as a valid primary key.

Further investigation is required before promoting the column as the official primary key in the Silver Layer.
