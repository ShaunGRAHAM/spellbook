
{{ config(
        schema = 'looksrare',
        alias = alias('trades'),
        tags = ['dunesql'],
        materialized = 'view',
        post_hook='{{ expose_spells(\'["ethereum"]\',
                                    "project",
                                    "looksrare",
                                    \'["0xRob"]\') }}')
}}

SELECT *
FROM {{ ref('nft_trades') }}
WHERE project = 'looksrare'
