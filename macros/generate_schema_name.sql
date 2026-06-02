--add the additional flag in the run dropdown option to create developer specific schemas
--var '{"dbt_user": "tsahoo"}'
{% macro generate_schema_name(custom_schema_name, node) -%}

    {# 1. Identify the executing environment target (e.g., dev, sit, ppt, prod) #}
    {%- set default_schema = target.schema -%}
    
    {# 2. Capture the currently logged-in Snowflake user and clean the string #}
    {%- set user_name = var('dbt_user',target.user) | default('') | trim | lower -%}
        
    {# 3. Production/Deployment Isolation Logic #}
    {%- if target.name in ['prod', 'sit', 'ppt'] -%}
        
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}

    {# 4. Developer / Snowsight Workspace Isolation Logic #}
    {%- else -%}
       
        {# Fallback to default schema if user variable isn't captured safely #}
        {%- if user_name is not none and user_name != '' -%}
           
            {%- if custom_schema_name is none -%}
                dbt_{{ user_name }}
            {%- else -%}
                dbt_{{ user_name }}_{{ custom_schema_name | trim }}
            {%- endif -%}
            
        {%- else -%}
            {{ default_schema }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
