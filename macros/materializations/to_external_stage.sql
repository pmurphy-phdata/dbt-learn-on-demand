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
    {% set target_relation = adapter.get_relation(database=this.database,schema=this.schema,identifier=this.name) %}
    {% set table_exists=target_relation is not none %}

    {{ log("target_relation: " ~ target_relation, true) }}
    {{ log("target.schema: " ~ target.schema, true) }}

    {%- call statement("main") -%}
        use schema cert;
        COPY INTO {{ '@' + named_stage + '/' + file_name_prefix}}
        FROM (
        {{ sql }}
        )
        OVERWRITE=true
    {% endcall %}

    -- run post hooks inside of transaction
    {{ run_hooks(post_hooks, inside_transaction=True) }}
    -- commit
    {{ adapter.commit() }}
    -- run post hooks outside of transaction
    {{ run_hooks(post_hooks, inside_transaction=False) }}

    {# doing the following to avoid relation not returned to the cache error#}
    {% set relation = api.Relation.create(database=target.database, schema=target.schema, identifier='cert') %}
    {{return({"relations": [relation]})}}
{%- endmaterialization %}
