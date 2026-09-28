CREATE database THROAT_CANCER_ANALYSIS;
USE THROAT_CANCER_ANALYSIS;
select * from `throat_cancer_synthetic_5000-1`;
select Smoking_Status, count(*) as Total_Patients,
sum(case when Clinical_Stage in ('III' ,'IV') then 1 else 0 end) as Advanced_Stage,
round(sum(case when Clinical_Stage in ('III' ,'IV') then 1 else 0 end) * 100.0/count(*),1) as Pct_Advanced
from `throat_cancer_synthetic_5000-1`
group by Smoking_Status
order by  Pct_Advanced desc;
select Cancer_Subsite, HPV_Status,
count(*) as Patient_Count, round(count(*) * 100.0/sum(count(*)) over(partition by Cancer_Subsite),1) as Pct_Within_Subsite
from `throat_cancer_synthetic_5000-1`
group by Cancer_Subsite, HPV_Status
order by  Cancer_Subsite, HPV_Status;
select Alcohol_Use, count(*) as Total,sum(case when Metastasis_Status = 'Distant metastasis' then 1 else 0 end) as Metastatic_Cases,
round(sum(case when Metastasis_Status =  'Distant metastasis' then 1 else 0 end) * 100.0/count(*),1) as Pct_Metastatic
from `throat_cancer_synthetic_5000-1`
group by Alcohol_Use
order by Pct_Metastatic desc;
select Smoking_Status, count(*) as Total,
round(avg(Survival_Months),1) as Average_Survival_Months,
sum(case when Outcome = 'Dead' then 1 else 0 end) as Deaths,
round(sum(case when Outcome = 'Dead' then 1 else 0 end) * 100.0/count(*),1) as Mortality_Rate
from `throat_cancer_synthetic_5000-1`
group by Smoking_Status
order by Mortality_Rate desc;
select (case when Smoking_Status = 'Current' then 1 else 0 end + case when Alcohol_Use = 'High' then 1 else 0 end
+ case when Areca_Nut_Use = 'Yes' then 1 else 0 end + case when Betel_Quid_Use = 'Yes' then 1 else 0 end) as Risk_Factor_Count,
count(*) as Patients, round(avg(case when Clinical_Stage in('III','IV') THEN 1 else 0 end) * 100,1) as Pct_Advanced_Stage
from `throat_cancer_synthetic_5000-1`
group by Risk_Factor_Count
order by Risk_Factor_Count;
