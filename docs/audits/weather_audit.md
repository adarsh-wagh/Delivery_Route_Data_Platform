# Weather Table Audit

## Table Overview

| Metric | Value |
|---------|---------|
| Rows | 150,000 |
| Columns | 5 |

---

## Audit Methodology

Audit notebook:

- [Weather Audit Notebook](../notebooks/03_weather_audit.ipynb)

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
| temperature_c | 10,500 | 7% |
| visibility_km | 15,000 | 10% |

---

### 2. Duplicate Records

| Check | Result |
|---------|---------|
| Fully Duplicated Rows | 0 |

---

### 3. Primary Key Assessment

#### Candidate Primary Key

`weather_id`

#### Findings

| Check | Result |
|---------|---------|
| NULL Values | 0 |
| Unique Values | 145,555 |
| Duplicate Values | 4,445 |

#### Assessment

❌ `weather_id` cannot currently be used as a Primary Key.

Reasons:

- Duplicate values detected
- Uniqueness requirement is not met

---

### 4. Data Standardization Issues

#### timestamp

Issues:

- Stored as object datatype
- Contains inconsistent date formats

Assessment:

- Temporal validation cannot be performed until values are converted to datetime format
- Future-date and historical-date checks should be performed after standardization

---

#### weather_type

Issues:

- Inconsistent casing
- Spelling errors

Examples:

```text
Rain
RAIN
rain
Rn
```

Recommended Action:

- Standardize category values
- Correct spelling inconsistencies

---

#### temperature_c

| Validation Check | Count |
|------------------|--------|
| Missing Values | 10,500 |
| Values Above 50°C | 1,651 |

Assessment:

- Observed values range approximately from 55°C to 65°C
- Values exceed typical real-world weather observations
- Business validation required before remediation

---

#### visibility_km

| Validation Check | Count |
|------------------|--------|
| Missing Values | 15,000 |
| Negative Values | 704 |
| Zero Values | 366 |

Assessment:

- Negative values are invalid
- Zero values may represent severe weather conditions or data quality issues
- Business validation required

---

## Recommended Silver Layer Actions

### Data Cleaning

- Resolve duplicate weather_id records
- Handle missing values
- Correct invalid numeric values
- Convert timestamp to datetime format

### Data Standardization

- Standardize weather_type values
- Standardize timestamp formatting

### Data Validation

- Validate temperature ranges
- Validate visibility measurements
- Perform temporal validation after datetime conversion

---

## Primary Key Status

| Attribute | Status |
|------------|------------|
| Candidate Key | weather_id |
| NULL Check | ✅ Passed |
| Uniqueness Check | ❌ Failed |
| Primary Key Ready | ❌ No |

---

## Final Assessment

`weather_id` is the most likely business key for the Weather table. However, duplicate values prevent it from serving as a valid primary key.

Additional validation of timestamp, temperature, and visibility data is required before promoting the table to the Silver Layer.
