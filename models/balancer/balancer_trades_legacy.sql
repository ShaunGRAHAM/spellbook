{{ config(
	tags=['legacy'],
	
    schema = 'balancer',
    alias = alias('trades', legacy_model=True),
    post_hook='{{ expose_spells(\'["arbitrum", "avalanche_c", "base", "ethereum", "gnosis", "optimism", "polygon"]\',
                                "project",
                                "balancer",
                                \'["bizzyvinci", "thetroyharris"]\') }}'
    )
}}

{% set balancer_models = [
    ref('balancer_arbitrum_trades_legacy'),
    ref('balancer_avalanche_c_trades_legacy'),
    ref('balancer_base_trades_legacy'),
    ref('balancer_ethereum_trades_legacy'),
    ref('balancer_gnosis_trades_legacy'),
    ref('balancer_optimism_trades_legacy'),
    ref('balancer_polygon_trades_legacy')
] %}


SELECT *
FROM (
    {% for dex_model in balancer_models %}
    SELECT
        blockchain,
        project,
        version,
        block_date,
        block_time,
        token_bought_symbol,
        token_sold_symbol,
        token_pair,
        token_bought_amount,
        token_sold_amount,
        token_bought_amount_raw,
        token_sold_amount_raw,
        amount_usd,
        token_bought_address,
        token_sold_address,
        taker,
        maker,
        pool_id,
        swap_fee,
        project_contract_address,
        tx_hash,
        tx_from,
        tx_to,
        trace_address,
        evt_index
    FROM {{ dex_model }}
    {% if not loop.last %}
    UNION ALL
    {% endif %}
    {% endfor %}
)
