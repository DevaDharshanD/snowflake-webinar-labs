-- ============================================
-- SET THESE VARIABLES FROM YOUR .env FILE
-- ============================================
SET aws_iam_role_arn = 'arn:aws:iam::054669811658:role/snowflake_role';       -- .env: AWS_IAM_ROLE_ARN
SET s3_bucket_url = 's3://deva-s-snowflake-bucket/snowflake-folder/';        -- .env: S3_BUCKET_URL

CREATE OR REPLACE STORAGE INTEGRATION S3_role_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = $aws_iam_role_arn
  STORAGE_ALLOWED_LOCATIONS = ($s3_bucket_url);

desc integration S3_role_integration;

