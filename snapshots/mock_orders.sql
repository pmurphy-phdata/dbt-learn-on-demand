{% snapshot mock_orders %}

{#
{% set new_schema = target.schema + '_snapshot' %}
#}

{{
    config(
      unique_key='order_id',
      strategy='timestamp',
      updated_at='order_date',
    )
}}

{%- set target_database = config.get('target_database') -%}
{%- set target_schema = config.get('target_schema') -%}

select * from {{ ref('stg_orders')}}

{% endsnapshot %}