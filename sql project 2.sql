create table hospital (
   hospital_name varchar(100) ,
   location varchar(50),
   Department	varchar (100),
   Doctors_Count	int,
   Patients_Count int,
   Admission_Date date	,
   Discharge_Date date 	,
   Medical_Expenses numeric(10, 2)

);
drop table hospital;

select * from hospital;





/*1. Total Number of Patients
o Write an SQL query to find the total number of patients across all hospitals.*/
SELECT SUM(Patients_Count) AS Total_Patients
FROM   hospital;


/*2. Average Number of Doctors per Hospital
o Retrieve the average count of doctors available in each hospital.*/
SELECT   hospital_name,
         ROUND(AVG(Doctors_Count), 2) AS Avg_Doctors
FROM     hospital
GROUP BY hospital_name
ORDER BY Avg_Doctors DESC;

/*3. Top 3 Departments with the Highest Number of Patients
o Find the top 3 hospital departments that have the highest number of patients.*/
SELECT   Department,
         SUM(Patients_Count) AS Total_Patients
FROM     hospital
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT    3;

/*4. Hospital with the Maximum Medical Expenses
o Identify the hospital that recorded the highest medical expenses.*/
SELECT   hospital_name,
         ROUND(SUM(Medical_Expenses), 2) AS Total_Expenses
FROM     hospital
GROUP BY hospital_name
ORDER BY Total_Expenses DESC
LIMIT    1;

/*5. Daily Average Medical Expenses
o Calculate the average medical expenses per day for each hospital.*/
SELECT   hospital_name,
         ROUND(
           (SUM(medical_expenses) /
            SUM(Discharge_Date - Admission_Date))::NUMERIC,
         2) AS daily_avg_expense
FROM     hospital
GROUP BY hospital_name
ORDER BY daily_avg_expense DESC;

/*6. Longest Hospital Stay
o Find the patient with the longest stay by calculating the difference between
Discharge Date and Admission Date.*/

SELECT   hospital_name, Department,
         Admission_Date, Discharge_Date,
         (discharge_date - admission_date) AS stay_days
FROM     hospital
ORDER BY stay_days DESC
LIMIT    1;

/*7. Total Patients Treated Per City
o Count the total number of patients treated in each city.*/
SELECT   location AS city,
         SUM(patients_count) AS total_patients
FROM     hospital
GROUP BY location
ORDER BY total_patients DESC;

/*8. Average Length of Stay Per Department
o Calculate the average number of days patients spend in each department.*/
SELECT   Department,
         ROUND(AVG(Discharge_Date - Admission_Date), 2)
           AS Avg_Stay_Days
FROM     hospital
GROUP BY Department
ORDER BY Avg_Stay_Days DESC;

/*9. Identify the Department with the Lowest Number of Patients
o Find the department with the least number of patients*/.
SELECT   Department,
         SUM(Patients_Count) AS Total_Patients
FROM     hospital
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT    1;

/*10. Monthly Medical Expenses Report
• Group the data by month and calculate the total medical expenses for each month.*/
SELECT   To_char(Admission_Date,'month')        AS Month_Name,
         ROUND(SUM(Medical_Expenses), 2)  AS Total_Expenses
FROM     hospital
GROUP BY extract(month from Admission_Date),
         to_char(Admission_Date,'month')
ORDER BY extract(month from Admission_Date);




