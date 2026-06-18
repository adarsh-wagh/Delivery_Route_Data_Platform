# Roads Table Audit

## Table Overview

| Metric | Value |
|---------|---------|
| Rows | 10,000 |
| Columns | 5 |

---

## Audit Methodology

Audit notebook:

- [Roads Audit Notebook](../notebooks/01_roads_audit.ipynb)

The notebook contains:

- Missing value analysis
- Duplicate analysis
- Primary key validation
- Data type validation
- Category standardization checks
- Business rule validation

---

## Issues Identified

### 1. Missing Values

| Column | Missing Count | Percentage |
|----------|----------|----------|
| road_id | 300 | 3% |
| num_lanes | 700 | 7% |
| num_signals | 600 | 6% |
| zone_type | 800 | 8% |

---

### 2. Duplicate Records

| Check | Result |
|---------|---------|
| Fully Duplicated Rows | 8 |

---

### 3. Primary Key Assessment

#### Candidate Primary Key
`road_id`

#### Findings

| Check | Result |
|---------|---------|
| NULL Values | 300 |
| Unique Values | 9,341 |
| Duplicate Values | 658 |

#### Assessment

❌ `road_id` cannot currently be used as a Primary Key.

Reasons:

- Contains NULL values
- Contains duplicate values
- Uniqueness requirement is not met

#### Required Investigation

- Identify source of duplicate `road_id` values
- Determine whether duplicates are valid business records
- Create remediation strategy before Silver Layer loading

---

### 4. Data Standardization Issues

#### road_type

Issues:

- Inconsistent casing
- Spelling errors
- Multiple representations of the same category

Examples:

```text
HIGHWAY
Highway
highway
Higway
```

Recommended Action:

- Convert values to a standard format
- Correct spelling variations

---

#### num_lanes

Issues:

- Missing values
- Invalid negative values

| Validation Check | Count |
|------------------|--------|
| Missing Values | 700 |
| Negative Values | 61 |

Recommended Action:

- Investigate negative values
- Replace or remove invalid records
- Impute missing values where appropriate

---

#### zone_type

Issues:

- Missing values
- Inconsistent casing
- Spelling errors

Examples:

```text
Urban
URBAN
urban
Urbn
```

Recommended Action:

- Standardize category values
- Correct spelling inconsistencies
- Handle missing records

---

## Recommended Silver Layer Actions

### Data Cleaning

- Remove fully duplicated rows
- Resolve duplicate `road_id` records
- Handle NULL values
- Correct invalid numeric values

### Data Standardization

- Standardize `road_type`
- Standardize `zone_type`
- Apply consistent formatting rules

### Data Validation

- Verify business category values
- Validate lane counts
- Validate signal counts
- Confirm primary key integrity

---

## Silver Layer Objectives

- Ensure data completeness
- Ensure data consistency
- Ensure data validity
- Establish a reliable primary key
- Produce analytics-ready road dimension data

---

## Primary Key Status

| Attribute | Status |
|------------|------------|
| Candidate Key | road_id |
| NULL Check | ❌ Failed |
| Uniqueness Check | ❌ Failed |
| Primary Key Ready | ❌ No |

### Final Assessment

`road_id` is the most likely business key for the Roads table; however, it currently fails both NULL and uniqueness requirements.

Further investigation is required before promoting the column as the official primary key in the Silver Layer.
