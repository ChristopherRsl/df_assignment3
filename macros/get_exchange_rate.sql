{% macro get_exchange_rate(column_name, scale=2) %}
  ROUND(SUM({{ column_name }}*16241.5), 2)
{% endmacro %}
