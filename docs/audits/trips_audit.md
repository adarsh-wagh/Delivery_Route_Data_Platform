# Trips Table Audit

## Table Overview

| Metric | Value |
|---------|---------|
| Rows | 2,040,000 |
| Columns | 11 |

---

## Audit Methodology

Audit notebook:

- [Trips Audit Notebook](../notebooks/04_trips_audit.ipynb)

The audit includes:

- Missing value analysis
- Duplicate detection
- Primary key validation
- Foreign key validation
- Data type validation
- Geospatial validation
- Business rule validation

---

## Issues Identified

### 1. Missing Values

| Column | Missing Count | Percentage |
|----------|----------|----------|
| timestamp | 30,782 | 1.5% |
| road_id | 81,119 | 4.0% |
| traffic_id | 82,153 | 4.0% |
| weather_id | 61,156 | 3.0% |
| travel_time_min | 20,337 | 1.0% |

---

### 2. Duplicate Records

| Check | Result |
|---------|---------|
| Fully Duplicated Rows | 40,000 |

Assessment:

- Duplicate records were identified within the dataset.
- Further investigation is required to determine whether these records represent ingestion errors or intentional duplicate events.

---

### 3. Primary Key Assessment

#### Candidate Primary Key

`trip_id`

#### Findings

| Check | Result |
|---------|---------|
| NULL Values | 0 |
| Unique Values | 2,000,000 |
| Duplicate Values | 40,000 |

#### Assessment

❌ `trip_id` cannot currently be used as a Primary Key.

Reasons:

- Duplicate values detected
- Uniqueness requirement is not met

Required Investigation:

- Determine whether duplicate `trip_id` values originate solely from fully duplicated records
- Verify whether duplicate trip IDs represent legitimate business events or data quality issues

---

### 4. Foreign Key Assessment

#### road_id

| Check | Result |
|---------|---------|
| NULL Values | 81,119 |
| Distinct Values | 9,641 |

Assessment:

- Contains missing values
- Referential integrity validation required against Roads table

---

#### traffic_id

| Check | Result |
|---------|---------|
| NULL Values | 82,153 |
| Distinct Values | 145,932 |

Assessment:

- Contains missing values
- Referential integrity validation required against Traffic table

---

#### weather_id

| Check | Result |
|---------|---------|
| NULL Values | 61,156 |
| Distinct Values | 145,555 |

Assessment:

- Contains missing values
- Referential integrity validation required against Weather table

---

### 5. Data Standardization & Validation Issues

#### Geospatial Validation

Valid Coordinate Ranges:

| Coordinate | Valid Range |
|------------|-------------|
| Latitude | -90° to +90° |
| Longitude | -180° to +180° |

---

#### start_lat

| Validation Check | Count |
|------------------|--------|
| Outside Latitude Range | 17,012 |
| Within Longitude Range but Outside Latitude Range | 3,159 |

Assessment:

- Invalid latitude values detected
- Some records may indicate latitude and longitude values were swapped

---

#### start_lon

| Validation Check | Count |
|------------------|--------|
| Outside Longitude Range | 12,376 |
| Within Latitude Range but Outside Longitude Range | 21,667 |

Assessment:

- Invalid longitude values detected
- Some records may indicate latitude and longitude values were swapped

---

#### end_lat

| Validation Check | Count |
|------------------|--------|
| Outside Latitude Range | 0 |
| Outside Longitude Range | 0 |

Assessment:

✅ No issues identified.

---

#### end_lon

| Validation Check | Count |
|------------------|--------|
| Outside Latitude Range | 0 |
| Outside Longitude Range | 0 |

Assessment:

✅ No issues identified.

---

#### Coordinate Integrity Assessment

Potential coordinate corruption detected.

Observations:

- A subset of `start_lat` values fall outside the valid latitude range while remaining valid longitude values.
- A subset of `start_lon` values fall outside the valid longitude range while remaining valid latitude values.

Possible Cause:

- Latitude and longitude values may have been swapped during data generation or ingestion.

Recommended Action:

- Investigate coordinate pairs before applying remediation rules.

---

#### timestamp

Issues:

- Stored as object datatype
- Contains inconsistent date formats

Assessment:

- Temporal validation cannot be performed until values are converted to datetime format
- Future-date and historical-date checks should be performed after standardization

---

#### travel_time_min

| Validation Check | Count |
|------------------|--------|
| Missing Values | 20,337 |
| Zero Values | 0 |
| Negative Values | 0 |

Assessment:

✅ No invalid values identified.

Missing values require remediation before downstream analysis.

---

## Recommended Silver Layer Actions

### Data Cleaning

- Remove fully duplicated rows
- Resolve duplicate trip_id records
- Handle missing values
- Convert timestamp to datetime format

### Data Standardization

- Standardize timestamp formatting
- Correct coordinate inconsistencies
- Investigate and remediate swapped latitude/longitude values

### Data Validation

- Validate foreign key relationships
- Verify referential integrity with Roads table
- Verify referential integrity with Traffic table
- Verify referential integrity with Weather table
- Perform temporal validation after datetime conversion
- Validate geospatial coordinates

---

## Primary Key Status

| Attribute | Status |
|------------|------------|
| Candidate Key | trip_id |
| NULL Check | ✅ Passed |
| Uniqueness Check | ❌ Failed |
| Primary Key Ready | ❌ No |

---

## Candidate Foreign Keys

| Column |
|---------|
| road_id |
| traffic_id |
| weather_id |

---

## Final Assessment

`trip_id` is the most likely business key for the Trips table.

Although no NULL values were identified, duplicate records prevent the column from serving as a valid primary key in its current state.

Additional investigation is required to determine whether duplicated trip_id values originate solely from fully duplicated records or represent broader data quality issues.

The Trips table also contains foreign key completeness issues, timestamp formatting inconsistencies, and potential coordinate integrity problems that should be addressed before promotion to the Silver Layer.

Overall, the table requires moderate remediation before it can be considered analytics-ready.
