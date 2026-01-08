-- SELECT * FROM telco_churn;

-- Calculate basic KPIs

-- Total number of customers:
SELECT COUNT(customerID) AS total_customers FROM telco_churn;

-- Number of churned customers:
SELECT COUNT(customerID) As total_churned
FROM telco_churn
WHERE Churn = 'Yes';

-- Churn Rate
SELECT 
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate
FROM telco_churn;

-- Churn by Contract Type

SELECT Contract,
     Count(*) As total,
     SUM(CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END) AS total_churned,
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- Churn by Tenure Bands

SELECT 
    CASE WHEN  tenure < 7 THEN '0-6 months'
    WHEN tenure < 13 THEN '6-12 months'
    WHEN tenure < 25 ThEN '1-2 years'
    ELSE '2+ years'
    END As tenure_band,
    COUNT(*) as total,
    SUM(CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END) AS total_churned,
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate
FROM telco_churn
GROUP BY tenure_band
ORDER BY churn_rate DESC;

-- Churn by Internet Service
SELECT InternetService,
     Count(*) As total,
     SUM(CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END) AS total_churned,
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate
FROM telco_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- Payment Method analysis

SELECT PaymentMethod,
     Count(*) As total,
     SUM(CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END) AS total_churned,
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate,
    AVG(MonthlyCharges) AS avg_monthly_payments
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- High Risk Segments
SELECT PaymentMethod,
     Count(*) As total,
     SUM(CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END) AS total_churned,
    SUM(
        CASE WHEN Churn='Yes' THEN 1
        ELSE 0
        END
    ) / COUNT(*) AS churn_rate,
    AVG(MonthlyCharges) AS avg_monthly_payments
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT Contract,
    CASE WHEN MonthlyCharges>80 THEN 'High'
    ELSE 'Normal' END AS charge_level,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn='Yes' THEN 1
            ELSE 0
            END) AS total_churned,
    SUM(
            CASE WHEN Churn='Yes' THEN 1
            ELSE 0
            END
        ) / COUNT(*) AS churn_rate
FROM telco_churn
GROUP BY Contract, charge_level
ORDER BY churn_rate DESC;
