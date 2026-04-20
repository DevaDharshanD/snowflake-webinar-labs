-- First, create the stage if it doesn't exist
CREATE STAGE IF NOT EXISTS DASH_DB_SI.RETAIL.SEMANTIC_MODELS;

-- Then upload via PUT (from SnowSQL/CLI) or use the Snowsight stage UI