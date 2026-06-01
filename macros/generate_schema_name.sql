{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- set dev_user = target.user
        | replace('.', '_')
        | replace('-', '_')
        | lower -%}
    {%- if custom_schema_name is none -%}
        
        {{ log('inside custom schema none clause' ,True) }}


         {{ default_schema }}         

    {%- elif target.name == 'dev' and not custom_schema_name.lower().startswith('raw') -%}
    
        {{ default_schema }}_{{ dev_user}}

    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}
