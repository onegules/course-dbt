{% test non_negative(dbt_model, column_name) %}
    select *
    from {{ dbt_model }}
    where {{ column_name }} < 0
{% endtest %}