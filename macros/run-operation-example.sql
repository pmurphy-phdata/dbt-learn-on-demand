{% macro select(schema=target.schema, role=target.role) %}

  {% set sql %}
  select 1234;
  {% endset %}


  {% if execute %}
    {{ log('about to run sql in schema ' ~ target.schema ~ ' using role ' ~ role, info=True) }}
    {% set results = run_query(sql) %}
    {{ log('sql executed: ' ~  results, info=True) }}
  {% endif %}
{% endmacro %}