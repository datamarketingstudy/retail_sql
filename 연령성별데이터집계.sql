/* 2011년 시점을 기준으로 5세 단위로 연령 구간을 나누고 
 * 각 성별(Gender), 연령 구간별로 고객 수를 Python 코드를 이용해 집계해주세요. 
 * (단, 고객의 성별, 연령 정보를 구할 수 없을 경우 해당 데이터는 집계에서 제외해 주세요.)
 */

WITH 
	age_calculated AS (
    	SELECT	customer_id
    		,	gender
    		,	dob
    		,	city_code
    		,	DATE_PART('year', AGE('2011-01-01', dob)) AS age
    	FROM 
        		customer
    	WHERE 	gender IS NOT NULL 
        AND 	dob IS NOT NULL
	)
		SELECT	*
		FROM	age_calculated
		
	,
	age_grouped AS (
    	SELECT 	customer_id
    		,	gender
    		,	dob
    		,	city_code
    		,	age
    		,	(age / 5) * 5 	AS age_group
    	FROM	age_calculated
	)
		SELECT	gender
			,	age_group
			,	COUNT(*) 		AS customer_count
		FROM 	age_grouped
		GROUP BY 
    			gender
    		,	age_group
		ORDER BY 
				gender
			,	age_group
		;
