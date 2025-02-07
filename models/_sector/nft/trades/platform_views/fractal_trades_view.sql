
{{ config(
        schema = 'fractal',
        alias = alias('trades'),
        tags = ['dunesql'],
        materialized = 'view',
        post_hook='{{ expose_spells(\'["polygon"]\',
                                    "project",
                                    "fractal",
                                    \'["0xRob"]\') }}')
}}

SELECT *
FROM {{ ref('nft_trades') }}
WHERE project = 'fractal'
