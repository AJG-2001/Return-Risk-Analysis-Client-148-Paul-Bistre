USE invest;

CREATE VIEW AbiJoshuaGeorge AS;
SELECT 
    pricing.date AS price_date,
    security.major_asset_class AS major_assets,
    security.minor_asset_class AS minor_assets,
    pricing.ticker AS ticker,
    security.sec_type AS asset_type,
    holdings.quantity AS quantity,
    pricing.value AS price_value,
    holdings.quantity * pricing.value AS holding_value 
FROM 
    invest.account_dim AS accounts
INNER JOIN 
    invest.holdings_current AS holdings 
    ON accounts.account_id = holdings.account_id
INNER JOIN 
    invest.pricing_daily_new AS pricing 
    ON holdings.ticker = pricing.ticker
INNER JOIN 
    invest.security_masterlist AS security 
    ON holdings.ticker = security.ticker
WHERE 
    accounts.client_id = 148
    AND pricing.price_type = 'adjusted'
    AND pricing.date >= '2020-08-01'; 
















