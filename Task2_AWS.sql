CREATE OR REPLACE STORAGE INTEGRATION S3_role_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::054669811658:role/snowflake_role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://deva-s-snowflake-bucket/snowflake-folder/');

desc integration S3_role_integration;

