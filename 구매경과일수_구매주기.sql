/*
2013년 2월 28일을 기준으로 각 고객의 구매 경과일수 및 구매주기를 구해주세요.
구매 경과일수 = 기준일 - 마지막 구매일
구매주기 = (마지막 구매일 - 첫 구매일)/(총 구매 일수 - 1)
*/

-- Postgresql 문법으로 작성

WITH purchase_dates AS (
    SELECT 
        customer_id,
        MIN(tran_date) AS first_purchase_date,
        MAX(tran_date) AS last_purchase_date,
        COUNT(tran_date) AS total_purchases
    FROM 
        transactions
    WHERE
        tran_date <= DATE '2013-02-28'
    GROUP BY 
        customer_id
)
SELECT 
    p.customer_id,
    (DATE '2013-02-28' - p.last_purchase_date) AS days_since_last_purchase,
    CASE
        WHEN p.total_purchases > 1 THEN
            (p.last_purchase_date - p.first_purchase_date) / (p.total_purchases - 1)
        ELSE
            NULL
    END AS average_purchase_interval
FROM 
    purchase_dates AS p
;
