{% materialization to_external_stage, adapter = "snowflake" -%}
    -- get variables
    {%- set identifier = model["alias"] -%}
    {%- set named_stage = config.require("named_stage") -%}
    {%- set file_name_prefix = config.get("file_name_prefix", default="") -%}
    -- run pre_hooks outside of transaction
    {{ run_hooks(pre_hooks, inside_transaction=False) }}
    -- run pre_hooks inside of transaction
    {{ run_hooks(pre_hooks, inside_transaction=True) }}

    -- perform main load
    {%- call statement("main") -%}
        COPY INTO {{ '@' + named_stage + '/' + file_name_prefix}}
        FROM (
        {{ sql }}
        )
    {% endcall %}

    -- run post hooks inside of transaction
    {{ run_hooks(post_hooks, inside_transaction=True) }}
    -- commit
    {{ adapter.commit() }}
    -- run post hooks outside of transaction
    {{ run_hooks(post_hooks, inside_transaction=False) }}
{%- endmaterialization %}
