{% macro generate_schema_name(custom_schema_name, node) -%}

    {# 1. Identify the executing environment target (e.g., dev, prod, staging) #}
    {%- set default_schema = target.schema -%}
    
    {# 2. Capture the currently logged-in Snowflake user and clean the string #}
    {%- set user_name = target.user | trim | lower -%}

    {# 3. Production/Deployment Isolation Logic #}
    {%- if target.name in ['prod', 'sit', 'ppt'] -%}
        
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}

    {# 4. Developer / Snowsight Workspace Isolation Logic #}
    {%- else -%}

        {{ log('inside target dev' ,True) }}
        
        {# Fallback to default schema if user variable isn't captured safely #}
        {%- if user_name is not none and user_name != '' -%}

            {{ log('inside user provided in the profile' ,True) }}
            
            {%- if custom_schema_name is none -%}
                {{ log('inside empty custom schema' ,True) }}            
                dev_{{ user_name }}
            {%- else -%}
                {{ log('inside custom schema has value' ,True) }}            
                dev_{{ user_name }}_{{ custom_schema_name | trim }}
            {%- endif -%}
            
        {%- else -%}
            {{ log('inside user not provided in the profile' ,True) }}        
            {{ default_schema }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
