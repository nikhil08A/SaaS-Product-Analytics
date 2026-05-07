

-- Analysis
CREATE TABLE saas_data (
    user_id VARCHAR(10),
    signup_date DATE,
    last_active_date DATE,
    plan_type VARCHAR(10),
    country VARCHAR(20),
    acquisition_channel VARCHAR(20),
    avg_session_time INT,
    feature_used VARCHAR(20),
    revenue INT,
    churn_flag INT,
    retention_days INT
);

SELECT * FROM saas_data;

-- BUSINESS QUESTIONS :-
-- 1. How many users are signing up over time? User Growth (Signups Over Time)
SELECT signup_date, COUNT(user_id) AS total_users
FROM saas_data
GROUP BY signup_date
ORDER BY signup_date;


-- 2.How active are users? (Engagement Proxy)
SELECT last_active_date, COUNT(DISTINCT user_id) AS active_users
FROM saas_data
GROUP BY last_active_date
ORDER BY last_active_date;


-- 3. Who is leaving and why? Churn Rate
SELECT
    COUNT(CASE WHEN churn_flag = 1 THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM saas_data;	

-- 4. Revenue by Plan
SELECT plan_type, SUM(revenue) AS total_revenue
FROM saas_data
GROUP BY plan_type;

-- 5.Conversion Analysis (Free → Paid)
SELECT
    plan_type,
	COUNT(*) AS users
FROM saas_data
GROUP BY plan_type;

-- 6. Feature Usage Impact
SELECT
    feature_used,
	AVG(retention_days) AS avg_retention
FROM saas_data
GROUP BY feature_used
ORDER BY avg_retention DESC;

-- 7. Acquisition Channel Performance
SELECT 
    acquisition_channel,
	COUNT(*) AS users,
	AVG(revenue) AS avg_revenue,
	AVG(retention_days) AS avg_retention
FROM saas_data
GROUP BY acquisition_channel;

-- 8. Power Users (High Engagement)
SELECT *
FROM saas_data
WHERE avg_session_time > 20;



