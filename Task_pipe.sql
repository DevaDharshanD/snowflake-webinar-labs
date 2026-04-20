create or replace database S3_db;

create or replace table S3_table(files string);

use schema S3_db.public;
create or replace stage S3_stage
  url = ('s3://deva-s-snowflake-bucket/snowflake-folder/')
  storage_integration = S3_role_integration;

create or replace pipe S3_db.public.S3_pipe auto_ingest=true as
  copy into S3_db.public.S3_table
  from @S3_db.public.S3_stage;

-- Create Role
use role accountadmin;
ALTER PIPE S3_PIPE SET PIPE_EXECUTION_PAUSED=true;
GRANT OWNERSHIP ON PIPE S3_db.public.S3_pipe TO ROLE accountadmin;
create or replace role S3_role;

-- Grant Object Access and Insert Permission
grant usage on database S3_db to role S3_role;
grant usage on schema S3_db.public to role S3_role;
grant insert, select on S3_db.public.S3_table to role S3_role;
grant usage on stage S3_db.public.S3_stage to role S3_role;

-- Bestow S3_pipe Ownership
grant ownership on pipe S3_db.public.S3_pipe to role S3_role;

-- Grant S3_role and Set as Default
grant role S3_role to user thisisadhav;
alter user thisisadhav set default_role = S3_role;

show pipes;
