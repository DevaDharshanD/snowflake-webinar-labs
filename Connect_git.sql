CREATE OR REPLACE API INTEGRATION my_git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/DevaDharshanD/')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY DASH_DB_SI.RETAIL.my_git_repo
  API_INTEGRATION = my_git_api_integration
  ORIGIN = 'https://github.com/DevaDharshanD/snowflake-webinar-labs.git';