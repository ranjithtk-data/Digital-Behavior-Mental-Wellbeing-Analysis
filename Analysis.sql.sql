create database Project1

use Project1

--DISPLAY ALL RECORDS FROM THE DATASET
Select * from Mental_Health_and_Social_Media_Balance_Dataset

--COUNT TOTAL NUMBER OF ROWS/USERS IN THE DATASET
SELECT COUNT(*)
FROM Mental_Health_and_Social_Media_Balance_Dataset

--FINDING MIN,MAX,AVG VALUES FOR SCREENTIME AND SLEEP QUALITY
SELECT 
MIN([Daily_Screen_Time_hrs]) as
Min_Screen_Time,
ROUND(MAX([Daily_Screen_Time_hrs]),2) as
Max_Screen_Time,
ROUND(AVG([Daily_Screen_Time_hrs]),2) as
Avg_Screen_Time,
MIN([Sleep_Quality_1_10]) as
Min_Sleep,
MAX([Sleep_Quality_1_10]) as
Max_Sleep,
ROUND(AVG([Sleep_Quality_1_10]),2) as
Avg_Sleep
FROM Mental_Health_and_Social_Media_Balance_Dataset;

--COUNT NUMBER OF USERS FOR EACH SOCIAL MEDIA PLATFORM
SELECT Social_Media_Platform,
count(*) as Users FROM Mental_Health_and_Social_Media_Balance_Dataset
GROUP BY Social_Media_Platform;

--ADDING A NEW COLUMN TO CATEGORIZE USERS BASED ON DAILY SCREEN TIME
ALTER TABLE Mental_Health_and_Social_Media_Balance_Dataset
ADD Screen_Time_Category Varchar(50);

--CATEGORIZE USERS INTO LOW , MEDIUM , AND HIGH SCREEN TIME GROUPS
UPDATE Mental_Health_and_Social_Media_Balance_Dataset
SET Screen_Time_Category = CASE WHEN [Daily_Screen_Time_hrs] <3 THEN 'Low(<3Hrs)'
WHEN [Daily_Screen_Time_hrs] BETWEEN 3 AND 6 THEN 'Medium(3-6Hrs)'
else 'High(>6Hrs)'
END

--ADDING A NEW COLUMN TO GROUP USERS BY AGE RANGES
ALTER TABLE Mental_Health_and_Social_Media_Balance_Dataset
ADD Age_Group Varchar(50);

--CLASSIFYING USERS INTO AGE GROUPS: TEEN , 21-30 , 31-40 , AND 40+ 
update Mental_Health_and_Social_Media_Balance_Dataset
SET Age_Group = case when Age BETWEEN 13 AND 20 THEN 'TEEN'
WHEN Age BETWEEN 21 AND 30 THEN '21=30'
WHEN Age BETWEEN 31 AND 40 THEN '31-40'
ELSE '40+'
END

--ANALYSE HOW SCREEN TIME EFFECTS SLEEP , STRESS LEVELS , HAPPINESS
SELECT Screen_Time_category,
ROUND(AVG([Sleep_Quality_1_10]),2) AS
AVG_Sleep,
ROUND(AVG ([Stress_Level_1_10]),2) AS
AVG_Stress,
ROUND(AVG([Happiness_Index_1_10]),2) AS
AVG_Happiness,
COUNT(*) AS Users
from Mental_Health_and_Social_Media_Balance_Dataset
Group BY Screen_Time_category
Order BY Users desc;

--COMPARE AVERAGE SLEEP , HAPPINESS , AND STRESS LEVEL ACROSS SOCIAL MEDIA PLATFORMS
SELECT Social_Media_platform,
ROUND(avg([Sleep_Quality_1_10]),2) AS
Avg_Sleep,
ROUND(avg([Stress_Level_1_10]),2) as
Avg_Stress,
ROUND(avg([Happiness_Index_1_10]),2) as
Avg_Happiness
from Mental_Health_and_Social_Media_Balance_Dataset
Group BY Social_Media_Platform ;

--ANALYSE HOW EXERCISE FREQUENCY AFFECTS AVERAGE STRESS LEVELS
SELECT [Exercise_Frequency_week],
ROUND(AVG([Stress_Level_1_10]),2) AS
Avg_Stress
FROM Mental_Health_and_Social_Media_Balance_Dataset
Group By [Exercise_Frequency_week]

--FINDING HOW TAKING BREAKS FROM SOCIAL MEDIA AFFECTS HAPPINESS LEVELS
SELECT [Days_Without_Social_Media],
ROUND(AVG ([Happiness_Index_1_10]),2) AS
Avg_Happiness
From Mental_Health_and_Social_Media_Balance_Dataset
Group BY [Days_Without_Social_Media];