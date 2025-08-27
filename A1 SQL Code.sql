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
        LEFT JOIN
    invest.holdings_current AS holdings ON accounts.account_id = holdings.account_id
        LEFT JOIN
    invest.pricing_daily_new AS pricing ON holdings.ticker = pricing.ticker
        LEFT JOIN
    invest.security_masterlist AS security ON holdings.ticker = security.ticker
WHERE
    accounts.client_id = 148
        AND pricing.price_type = 'adjusted'
        AND pricing.date >= '2020-08-31'; 
        
-- Question 1
SELECT 
    ticker,
    -- Calculate 12-month return
    (MAX(CASE WHEN price_date = '2022-09-09' THEN price_value END) - 
     MAX(CASE WHEN price_date = '2021-09-09' THEN price_value END)) / 
     MAX(CASE WHEN price_date = '2021-09-09' THEN price_value END) * 100 AS return_12M,
    -- Calculate 18-month return
    (MAX(CASE WHEN price_date = '2022-09-09' THEN price_value END) - 
     MAX(CASE WHEN price_date = '2021-03-09' THEN price_value END)) / 
     MAX(CASE WHEN price_date = '2021-03-09' THEN price_value END) * 100 AS return_18M,
    -- Calculate 24-month return
    (MAX(CASE WHEN price_date = '2022-09-09' THEN price_value END) - 
     MAX(CASE WHEN price_date = '2020-09-09' THEN price_value END)) / 
     MAX(CASE WHEN price_date = '2020-09-09' THEN price_value END) * 100 AS return_24M
FROM 
    AbiJoshuaGeorge
WHERE 
    price_date IN ('2020-09-09', '2021-03-09', '2021-09-09', '2022-09-09')
GROUP BY 
    ticker;
    
 SELECT
    -- Portfolio return for 12 months
    (SUM(CASE WHEN price_date = '2022-09-09' THEN holding_value ELSE 0 END) - 
     SUM(CASE WHEN price_date = '2021-09-09' THEN holding_value ELSE 0 END)) /
     SUM(CASE WHEN price_date = '2021-09-09' THEN holding_value ELSE 0 END) * 100 
     AS portfolio_return_12M,

    -- Portfolio return for 18 months
    (SUM(CASE WHEN price_date = '2022-09-09' THEN holding_value ELSE 0 END) - 
     SUM(CASE WHEN price_date = '2021-03-09' THEN holding_value ELSE 0 END)) /
     SUM(CASE WHEN price_date = '2021-03-09' THEN holding_value ELSE 0 END) * 100 
     AS portfolio_return_18M,

    -- Portfolio return for 24 months
    (SUM(CASE WHEN price_date = '2022-09-09' THEN holding_value ELSE 0 END) - 
     SUM(CASE WHEN price_date = '2020-09-09' THEN holding_value ELSE 0 END)) /
     SUM(CASE WHEN price_date = '2020-09-09' THEN holding_value ELSE 0 END) * 100 
     AS portfolio_return_24M
FROM 
    AbiJoshuaGeorge
WHERE 
    price_date IN ('2020-09-09', '2021-03-09', '2021-09-09', '2022-09-09');
    
-- Question 2
-- Risk
SELECT 
    ticker,
    STDDEV(daily_return) AS sigma_12_months
FROM (
    SELECT 
        ticker,
        price_date,
        (price_value - LAG(price_value) OVER (PARTITION BY ticker ORDER BY price_date)) / 
        LAG(price_value) OVER (PARTITION BY ticker ORDER BY price_date) AS daily_return
    FROM AbiJoshuaGeorge
    WHERE 
        price_date BETWEEN '2021-09-09' AND '2022-09-09'
) AS DailyReturns
WHERE daily_return IS NOT NULL
GROUP BY ticker
ORDER BY sigma_12_months DESC;

-- Return
SELECT 
    ticker, 
    AVG(daily_return) AS avg_daily_return
FROM (
    SELECT 
        ticker, 
        price_date,
        (price_value - LAG(price_value) OVER (PARTITION BY ticker ORDER BY price_date)) / 
        LAG(price_value) OVER (PARTITION BY ticker ORDER BY price_date) AS daily_return
    FROM AbiJoshuaGeorge
    WHERE 
        price_date BETWEEN '2021-09-09' AND '2022-09-09'
) AS DailyReturns
WHERE daily_return IS NOT NULL -- Exclude null daily returns
GROUP BY ticker
ORDER BY avg_daily_return DESC;

-- Question 3
WITH risk_and_return AS (
    SELECT
        p.ticker,
        STDDEV(p.value) AS sigma, 
        (MAX(p.value) - MIN(p.value)) / MIN(p.value) AS return_ratio 
    FROM
        pricing_daily_new p
    WHERE
        p.date >= '2022-09-01'  
    GROUP BY
        p.ticker
),

existing_securities AS (
    SELECT DISTINCT  
        sm.ticker,
        sm.security_name,
        sm.major_asset_class,
        sm.minor_asset_class
    FROM
        security_masterlist sm
    LEFT JOIN
        holdings_current hc
    ON
        sm.ticker = hc.ticker
    LEFT JOIN
        account_dim ad
    ON
        hc.account_id = ad.account_id
    WHERE
        (ad.client_id IS NULL OR ad.client_id != 148) -- Excluding securities already held by the client
)

SELECT DISTINCT  
    e.ticker,
    e.security_name,
    e.major_asset_class,
    e.minor_asset_class,
    r.sigma,
    r.return_ratio,
    (r.return_ratio / r.sigma) AS risk_adjusted_return 
FROM
    existing_securities e
INNER JOIN
    risk_and_return r
ON
    e.ticker = r.ticker
WHERE
    r.sigma > 0  -- Excluding securities with zero or undefined risk
ORDER BY
    risk_adjusted_return DESC;  -- Ranking securities by their risk-adjusted returns

-- Question 4
SELECT 
    A.ticker,
    AVG((A.price_value - B.price_value) / B.price_value) AS avg_return, -- Average return
    STDDEV((A.price_value - B.price_value) / B.price_value) AS sigma,   -- Risk (standard deviation)
    AVG((A.price_value - B.price_value) / B.price_value) / 
    STDDEV((A.price_value - B.price_value) / B.price_value) AS risk_adjusted_return -- Risk-adjusted return
FROM AbiJoshuaGeorge AS A
JOIN AbiJoshuaGeorge AS B
    ON A.ticker = B.ticker 
    AND A.price_date = DATE_ADD(B.price_date, INTERVAL 1 DAY) -- Offset by 1 day
GROUP BY A.ticker
ORDER BY risk_adjusted_return DESC;








    





    
    






    






