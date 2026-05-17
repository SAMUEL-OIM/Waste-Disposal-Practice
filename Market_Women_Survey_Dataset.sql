create database Market_Waste_Analysis;
Use  Market_Waste_Analysis;

SELECT *
FROM market_women_survey_dataset AS MWSD;

		-- Q1. How many of the 2,000 market women reported illness in the last 3 months? ---
SELECT COUNT(Respondent_ID)
FROM Market_women_survey_dataset
WHERE Reported_Illness_Last_3_months = "Yes";

		-- Q2. What is the most common disposal method among women with high disease risk?
--
SELECT Primary_Disposal_Method, COUNT(*) AS Frequency
FROM Market_women_survey_dataset
WHERE Perceived_Disease_Risk_Level = "High"
GROUP BY Primary_Disposal_Method
ORDER BY Frequency desc;

		-- Q3. Which education level group has the lowest hygiene knowledge score on average?  -- 
SELECT Education_Level, AVG(Hygiene_Knowledge_Score) AS AVG_HKS
FROM market_women_survey_dataset
GROUP BY Education_Level
ORDER BY AVG_HKS ASC;

		-- Q4. How many women who dump waste near water bodies also reported illness? --
SELECT COUNT(Proximity_to_water_body)
FROM market_women_survey_dataset
WHERE Reported_Illness_Last_3_months = "Yes";

	  -- Q5. What percentage of women who received intervention had disease incidence reduced?  --
SELECT 	COUNT(*) AS NO_I_and_DIR, 
		(SELECT COUNT(*) FROM market_women_survey_dataset) AS ALL_DATA, 
        CONCAT(ROUND((SELECT COUNT(*))/ (SELECT COUNT(*) FROM market_women_survey_dataset) * 100, 2),"%")  AS Percentage
FROM market_women_survey_dataset
WHERE Received_Intervention = "Yes" AND Disease_Incidence_Reduced = "Yes";

		-- Q6. Which income group relies most on harmful disposal methods? --
SELECT Income_Range, COUNT(Income_Range) AS Frequency
FROM market_women_survey_dataset
-- WHERE Primary_Disposal_Method != "Municipal waste bin" 
GROUP BY Income_Range
ORDER BY Frequency DESC;

		-- Q7. How many women with no access to clean water reported illness? -- 
SELECT COUNT(*) AS Frequency
FROM market_women_survey_dataset
WHERE Access_to_clean_water = "No" AND Reported_Illness_last_3_months = "Yes";

		-- Q8. What is the average hygiene knowledge score before and after intervention? -- 
SELECT *
FROM market_women_survey_dataset; -- The avg score after wasn't stipulated -- 

		-- Q9. Which age group has the highest perceived disease risk level? -- 
ALTER TABLE market_women_survey_dataset
ADD COLUMN Age_Group TEXT AFTER Age;
desc market_women_survey_dataset;
UPDATE  market_women_survey_dataset
SET Age_Group =  CASE 
					WHEN Age BETWEEN 18 AND 29 THEN '18-29' 
					WHEN Age BETWEEN 30 AND 44 THEN '30-44' 
					WHEN Age BETWEEN 45 AND 54 THEN '45-54' 
					WHEN Age BETWEEN 55 AND 64 THEN '55-64' 
				END;
SELECT Age_Group, COUNT(Age_Group) AS Frequency
FROM market_women_survey_dataset
WHERE Perceived_Disease_Risk_Level = "High"
GROUP BY Age_Group
ORDER BY Frequency DESC;

		-- Q10. How many women changed disposal behaviour after receiving intervention? -- 
SELECT COUNT(*) AS Frequnecy
FROM Market_women_survey_dataset
where Received_Intervention = "Yes" AND Disease_Incidence_Reduced = "Yes";