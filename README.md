# Snowflake Webinar Labs

Hands-on Snowflake workshop covering data loading, AWS integration, Cortex AI, dynamic tables, data governance, and dbt -- with setup scripts, answer keys, and autograders.

## Workshop Tasks

| Task | Topic | Key Files |
|------|-------|-----------|
| **Task 1** | Snowflake Fundamentals -- Data Loading, Transformations & UDFs | `Task1_SNOWFLAKE_Webinar.sql`, `Task1_Transformation.sql`, `Task1_UDF.sql` |
| **Task 2** | AWS S3 Integration & Snowpipe | `Task2_AWS.sql`, `Task_pipe.sql` |
| **Task 3** | Cortex AI -- Cortex Search & Semantic Models | `Task3_Cortex.sql`, `Task3_setup.sql`, `Task3_yamil_file.sql` |
| **Task 4** | Dynamic Tables -- Staging, Chaining & Pipelines | `Task4_Create-dt.sql`, `Task4_chaining-dt.sql`, `Task4_pipeline.sql`, `Task4_setup.sql` |
| **Task 5** | Data Governance -- Masking Policies, RBAC & Snowflake Intelligence | `Task5_setup.sql`, `Task5_masking_policy.sql`, `Task5_new_role.sql`, `Task5_dt_creation.sql` |

## Additional Files

- `Warehouse.sql` -- Warehouse management operations
- `Connect_git.sql` -- Git integration setup
- `dbt_project.yml` / `profiles.yml` / `packages.yml` -- Starter dbt project

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` access
- AWS account (for Task 2)
- Snowflake Marketplace: **Weather Source LLC -- Frostbyte** dataset (for Task 1)

## Getting Started

1. Run `Task4_setup.sql` or `Task5_setup.sql` to set up the required databases, roles, and sample data for the respective tasks.
2. Follow each task sequentially or jump to a specific topic.
3. Use the `*_answerkey.sql` files to check your work and `*_autograder.sql` files for automated validation.
