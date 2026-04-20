--!jinja
use role accountadmin;

create or replace api integration dora_api_integration 
api_provider = aws_api_gateway 
api_aws_role_arn = 'arn:aws:iam::321463406630:role/snowflakeLearnerAssumedRole' 
enabled = true 
api_allowed_prefixes = ('https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora');

create database if not exists util_db;
use database util_db;
use schema public;

create or replace external function util_db.public.grader(        
 step varchar     
 , passed boolean     
 , actual integer     
 , expected integer    
 , description varchar) 
 returns variant 
 api_integration = dora_api_integration 
 context_headers = (current_timestamp,current_account, current_statement, current_account_name) 
 as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/grader'  
;  

select grader(step, (actual = expected), actual, expected, description) as graded_results from (SELECT
 'AUTO_GRADER_IS_WORKING' as step
 ,(select 123) as actual
 ,123 as expected
 ,'The Snowflake auto-grader has been successfully set up in your account!' as description
);

create or replace external function util_db.public.greeting(
      email varchar
    , firstname varchar
    , middlename varchar
    , lastname varchar)
returns variant
api_integration = dora_api_integration
context_headers = (current_timestamp, current_account, current_statement, current_account_name) 
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/greeting'
; 


-- Be sure to follow the rules your session leader presents
-- Format your name CORRECTLY (do not use all lower case)
-- If you do not have a middle name, use an empty string '' ; do not use "null" in place of any values
-- Double-check your email. You must use the same email for the greeting as you used to register
select util_db.public.greeting('deva04171@gmail.com', 'Deva', '', 'Dharshan D');

-- ============================================
-- Answer Key: From Zero to Agents: Building End-To-End Data Pipelines for an AI Agent (Data for Breakfast HOL)
-- ============================================

use role accountadmin;
use database util_db;
use schema public;

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from (SELECT
 'BWZA01' as step
 , (select count(*) from snowflake.information_schema.databases 
   where database_name in ('DASH_DB_SI', 'SNOWFLAKE_INTELLIGENCE')) as actual
 , 2 as expected
 ,'All databases was created successfully!' as description
);

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from (SELECT
 'BWZA02' as step
 , (select count(*) from dash_db_si.information_schema.stages) as actual
 , 7 as expected
 ,'All stages were created successfully!' as description
);

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from (SELECT
 'BWZA03' as step
 , (select count(*) from dash_db_si.information_schema.tables where table_name in ('MARKETING_CAMPAIGN_METRICS', 'PRODUCTS', 'SALES','SOCIAL_MEDIA', 'SUPPORT_CASES','ENRICHED_MARKETING_INTELLIGENCE')) as actual
 , 6 as expected
 ,'All tables were created successfully!' as description
);

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from (SELECT
 'BWZA04' as step
 , (select count(*) from dash_db_si.information_schema.applicable_roles where role_name = 'SNOWFLAKE_INTELLIGENCE_ADMIN') as actual
 , 1 as expected
 ,'Role for snowflake intelligence admin created successfully!' as description
);

select util_db.public.grader(step, (actual >= expected), actual, expected, description) as graded_results from (SELECT
 'BWZA05' as step
 , (select count(*) from dash_db_si.information_schema.semantic_views where owner = 'SNOWFLAKE_INTELLIGENCE_ADMIN') as actual
 , 1 as expected
 ,'Semantic view created successfully!' as description
);

select util_db.public.grader(step, (actual >= expected), actual, expected, description) as graded_results from (SELECT
 'BWZA06' as step
 , (select count(*) from dash_db_si.information_schema.cortex_search_services where owner = 'SNOWFLAKE_INTELLIGENCE_ADMIN') as actual
 , 1 as expected
 ,'Cortex Search Services created successfully!' as description
);

WITH check_results AS (
  SELECT 'BWZA01' AS step, 'Databases (DASH_DB_SI, SNOWFLAKE_INTELLIGENCE)' AS description,
    IFF((SELECT count(*) FROM snowflake.information_schema.databases
           WHERE database_name IN ('DASH_DB_SI', 'SNOWFLAKE_INTELLIGENCE')) = 2, TRUE, FALSE) AS passed
  UNION ALL
  SELECT 'BWZA02', 'Stages (expected 7)',
    IFF((SELECT count(*) FROM dash_db_si.information_schema.stages) = 7, TRUE, FALSE)
  UNION ALL
  SELECT 'BWZA03', 'Tables (expected 6)',
    IFF((SELECT count(*) FROM dash_db_si.information_schema.tables
           WHERE table_name IN ('MARKETING_CAMPAIGN_METRICS', 'PRODUCTS', 'SALES',
                                'SOCIAL_MEDIA', 'SUPPORT_CASES', 'ENRICHED_MARKETING_INTELLIGENCE')) = 6, TRUE, FALSE)
  UNION ALL
  SELECT 'BWZA04', 'Role (SNOWFLAKE_INTELLIGENCE_ADMIN)',
    IFF((SELECT count(*) FROM dash_db_si.information_schema.applicable_roles
           WHERE role_name = 'SNOWFLAKE_INTELLIGENCE_ADMIN') = 1, TRUE, FALSE)
  UNION ALL
  SELECT 'BWZA05', 'Semantic View (owned by SNOWFLAKE_INTELLIGENCE_ADMIN)',
    IFF((SELECT count(*) FROM dash_db_si.information_schema.semantic_views
           WHERE owner = 'SNOWFLAKE_INTELLIGENCE_ADMIN') >= 1, TRUE, FALSE)
  UNION ALL
  SELECT 'BWZA06', 'Cortex Search Service (owned by SNOWFLAKE_INTELLIGENCE_ADMIN)',
    IFF((SELECT count(*) FROM dash_db_si.information_schema.cortex_search_services
           WHERE owner = 'SNOWFLAKE_INTELLIGENCE_ADMIN') >= 1, TRUE, FALSE)
)
SELECT
  CASE
    WHEN SUM(IFF(passed, 0, 1)) = 0
    THEN 'You''ve successfully completed the From Zero to Agents lab!'
    ELSE 'Not all steps passed. Failed: ' ||
         LISTAGG(CASE WHEN NOT passed THEN step || ' - ' || description END, ' | ')
           WITHIN GROUP (ORDER BY step)
  END AS STATUS
FROM check_results;