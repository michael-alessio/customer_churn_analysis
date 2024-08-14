-- Segment customers who have created a case by number of total cases created

SELECT num_cases, COUNT(customer_id)
FROM
	(SELECT customer_id, COUNT(case_id) AS num_cases
	FROM (SELECT * FROM customer_cases WHERE reason='support')
	GROUP BY customer_id
	ORDER BY num_cases DESC)
GROUP BY num_cases
ORDER BY num_cases;

-- Get all customer table containing all independant variables
CREATE TABLE risk_test AS
SELECT 
	i.customer_id,
	i.age,
	i.gender,
	p.product,
	CASE
  		WHEN p.cancel_date_time IS NULL THEN (CAST('2022-01-01' AS date))-(CAST(LEFT(p.signup_date_time,10) AS date))
	ELSE
  		(CAST(LEFT(p.cancel_date_time,10) AS date))-(CAST(LEFT(p.signup_date_time,10) AS date))
	END AS subscription_age,
	c.num_cases,
	CASE
		WHEN p.cancel_date_time IS NULL THEN 'active'
	ELSE
		'inactive'
	END AS subscription_status
FROM customer_info AS i
LEFT JOIN customer_product AS p ON i.customer_id = p.customer_id
LEFT JOIN 
	(SELECT customer_id, COUNT(case_id) AS num_cases
	FROM customer_cases
	GROUP BY customer_id) AS c ON i.customer_id = c.customer_id;

UPDATE risk_test
SET num_cases=0
WHERE num_cases IS NULL;

-- Get number of active/inactive for each num_cases

SELECT 
	num_cases,
	total,
	ROUND(CAST(num_active AS numeric)/CAST(total AS numeric),2)*100 AS percent_active,
	ROUND(CAST(num_inactive AS numeric)/CAST(total AS numeric),2)*100 AS percent_inactive
FROM
	(SELECT 
		num_cases,
		COUNT(*) AS total,
		COUNT(*) FILTER (WHERE subscription_status='active') AS num_active,
		COUNT(*) FILTER (WHERE subscription_status='inactive') AS num_inactive
	FROM risk_test
	GROUP BY num_cases);	

-- Get amount active and inactive

SELECT 
	COUNT(*) FILTER (WHERE subscription_status='active') AS amount_active,
	COUNT(*) FILTER (WHERE subscription_status='inactive') AS amount_inactive
FROM risk_test;	

SELECT DISTINCT product FROM risk_test;

-- Create only active customer table

CREATE TABLE active_customers AS
SELECT *
FROM risk_test
WHERE subscription_status='active';


-- Gender
SELECT 
	gender,
	COUNT(*) AS total,
	COUNT(*) FILTER (WHERE subscription_status='active') AS num_active,
	COUNT(*) FILTER (WHERE subscription_status='inactive') AS num_inactive
FROM risk_test
GROUP BY gender;	

-- Product

SELECT 
	product,
	COUNT(*) AS total,
	COUNT(*) FILTER (WHERE subscription_status='active') AS num_active,
	COUNT(*) FILTER (WHERE subscription_status='inactive') AS num_inactive
FROM risk_test
GROUP BY product;

-- Age

SELECT age
FROM risk_test
WHERE subscription_status='active';

SELECT age
FROM risk_test
WHERE subscription_status='inactive';

-- cancelations by subscription age

SELECT subscription_age
FROM risk_test
WHERE subscription_status='inactive';

-- get cases with risk score

SELECT 
	c.*,
	r.prob_stay_active,
	CASE
		WHEN r.prob_stay_active<0.7 THEN 'High'
		WHEN r.prob_stay_active<0.8 THEN 'Medium'
	ELSE
		'Low'
	END AS risk_level
FROM customer_cases AS c
LEFT JOIN customers_with_risk AS r ON c.customer_id = r.customer_id;

-- get active customers with risk classification

SELECT
	*,
	CASE
		WHEN prob_stay_active<0.7 THEN 'High'
		WHEN prob_stay_active<0.8 THEN 'Medium'
	ELSE
		'Low'
	END AS risk_level
FROM active_with_risk;