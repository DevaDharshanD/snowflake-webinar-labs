# User Guide -- Snowflake Webinar Labs

This guide walks you through everything built in this workshop, task by task.

---

## Task 1: Snowflake Fundamentals

### What was done
- **Data Loading**: Created the `TASTY_BYTES` database and loaded CSV data from an S3 bucket into `raw_pos.country` and other tables using `COPY INTO`.
- **Weather Data Integration**: Joined Tasty Bytes sales data with the **Weather Source LLC Frostbyte** Marketplace dataset to analyze how weather impacts food truck sales in Hamburg, Germany.
- **Views Created**:
  - `harmonized.daily_weather_v` -- Combines weather history with Tasty Bytes city/country data.
  - `harmonized.windspeed_hamburg` -- Tracks wind speed specifically for Hamburg.
- **UDFs Created**:
  - `analytics.fahrenheit_to_celsius()` -- Converts temperature units.
  - `analytics.inch_to_millimeter()` -- Converts precipitation units.
- **Analytics View**: `harmonized.weather_hamburg` -- Combines daily sales, temperature (F and C), precipitation (inches and mm), and wind speed for Hamburg in Feb 2022.

### Files
| File | Purpose |
|------|---------|
| `Task1_SNOWFLAKE_Webinar.sql` | Database setup, data loading, weather views |
| `Task1_Transformation.sql` | Data transformations and analytics queries |
| `Task1_UDF.sql` | UDF creation and the final analytics view |

---

## Task 2: AWS S3 Integration

### What was done
- **Storage Integration**: Created `S3_role_integration` to securely connect Snowflake to an S3 bucket (`s3://deva-s-snowflake-bucket/snowflake-folder/`).
- **Snowpipe**: Set up auto-ingest pipe `S3_pipe` that automatically loads new files from S3 into `S3_db.public.S3_table`.
- **RBAC for S3**: Created `S3_role` with granular permissions (database usage, schema usage, table insert/select, stage usage, pipe ownership).

### Files
| File | Purpose |
|------|---------|
| `Task2_AWS.sql` | Storage integration setup |
| `Task_pipe.sql` | Snowpipe creation, role setup, and permission grants |

---

## Task 3: Cortex AI

### What was done
- **Cortex Search Service**: Created `DASH_DB_SI.RETAIL.SUPPORT_CASES` search service on customer support transcripts, with attributes for title and product filtering.
- **Semantic Model**: Uploaded `marketing_campaigns.yaml` semantic model from a Snowflake Labs Git repository to a stage for use with Snowflake Intelligence.
- **Environment Setup**: Created the `DASH_DB_SI` database with `RETAIL` schema, loaded 5 datasets (marketing, products, sales, social media, support cases) from S3, and set up email notifications.

### Files
| File | Purpose |
|------|---------|
| `Task3_setup.sql` | Full environment setup (same as Task 5 setup) |
| `Task3_Cortex.sql` | Cortex Search service creation |
| `Task3_yamil_file.sql` | Semantic model stage setup |

---

## Task 4: Dynamic Tables

### What was done
- **Setup**: Created `RAW_DB` and `ANALYTICS_DB` databases. Used Python UDTFs with the Faker library to generate synthetic data:
  - 1,000 customers with spending limits
  - 100 products with stock levels
  - 10,000 customer orders
- **Staging Dynamic Tables**:
  - `stg_customers_dt` -- Cleans and renames customer columns.
  - `stg_orders_dt` -- Extracts and types fields from semi-structured order data (VARIANT).
- **Fact Dynamic Table**: `fct_customer_orders_dt` -- Joins customers with orders.
- **Pipeline Management**: Configured `target_lag` for automatic refresh scheduling and monitored refresh history.

### Files
| File | Purpose |
|------|---------|
| `Task4_setup.sql` | Database, UDTF, and sample data creation |
| `Task4_Create-dt.sql` | Staging dynamic tables |
| `Task4_chaining-dt.sql` | Fact table joining staged data |
| `Task4_pipeline.sql` | Pipeline monitoring and lag configuration |

---

## Task 5: Data Governance & Snowflake Intelligence

### What was done
- **Environment**: Reused the `DASH_DB_SI.RETAIL` setup with marketing, sales, social media, products, and support data.
- **Dynamic Table**: `enriched_marketing_intelligence` -- Joins marketing campaigns with support cases and computes sentiment scores using `SNOWFLAKE.CORTEX.SENTIMENT()`.
- **Secure View**: `marketing_intelligence_view` -- Exposes campaign name, product category, engagement clicks, and sentiment score.
- **Masking Policy**: `mask_engagement_clicks` -- Returns actual click values only for `SNOWFLAKE_INTELLIGENCE_ADMIN` and `ACCOUNTADMIN`; returns `0` for all other roles.
- **Role-Based Access Control**:
  - Created `marketing_intelligence_role` with limited access (can query the view but sees masked click data).
  - Granted Cortex user database role for AI function access.
- **Verification**: Confirmed that `SNOWFLAKE_INTELLIGENCE_ADMIN` sees real data while `marketing_intelligence_role` sees masked zeros.

### Files
| File | Purpose |
|------|---------|
| `Task5_setup.sql` | Full environment and data setup |
| `Task5_dt_creation.sql` | Enriched marketing dynamic table with Cortex sentiment |
| `Task5_new_role.sql` | Secure view, role creation, and permission grants |
| `Task5_masking_policy.sql` | Masking policy creation and application |
| `Task5_masking_verify_as_admin.sql` | Verify admin sees real data |
| `Task5_verify_as_marketing_role.sql` | Verify marketing role sees masked data |

---

## dbt Project

### What was done
- Initialized a starter dbt project (`first_dbt_project`) configured to run against `DEMO_DB.DEMO_SCHEMA` using `COMPUTE_WH` warehouse.
- Default materialization set to `view`.

### Files
| File | Purpose |
|------|---------|
| `dbt_project.yml` | Project configuration |
| `profiles.yml` | Connection profile (Snowflake) |
| `packages.yml` | Package dependencies (dbt_semantic_view commented out) |

---

## Utility Files

| File | Purpose |
|------|---------|
| `Warehouse.sql` | Warehouse management -- suspend, resume, resize, create, drop |
| `Connect_git.sql` | Git API integration and repository setup for this workspace |

---

## Snowflake Objects Created (Summary)

| Category | Objects |
|----------|---------|
| **Databases** | `TASTY_BYTES`, `RAW_DB`, `ANALYTICS_DB`, `S3_DB`, `DASH_DB_SI`, `SNOWFLAKE_INTELLIGENCE` |
| **Roles** | `snowflake_intelligence_admin`, `S3_role`, `marketing_intelligence_role` |
| **Dynamic Tables** | `stg_customers_dt`, `stg_orders_dt`, `fct_customer_orders_dt`, `enriched_marketing_intelligence` |
| **Views** | `daily_weather_v`, `windspeed_hamburg`, `weather_hamburg`, `marketing_intelligence_view` |
| **UDFs/UDTFs** | `fahrenheit_to_celsius`, `inch_to_millimeter`, `gen_cust_info`, `gen_prod_inv`, `gen_cust_purchase` |
| **Integrations** | `S3_role_integration`, `my_git_api_integration`, `email_integration` |
| **Cortex Services** | Cortex Search on `SUPPORT_CASES`, Cortex Sentiment in dynamic table |
| **Policies** | `mask_engagement_clicks` masking policy |
| **Pipes** | `S3_pipe` (auto-ingest from S3) |
