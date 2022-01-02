/* ------------- Exercice 1 -------------- */

/* Q1 */
select employee_id, last_name, job_id, hire_date as 'STARTDATE' from employees;

/* Q2 */
select distinct job_id from employees;

/* Q3 */
select employee_id as 'Emp', last_name as 'Employee', job_id as 'Job', hire_date as 'Hire Date' from employees;
select last_name || ', ' || job_id as 'Employee and Title' from employees;

/* Q4 */
select employee_id  || ', ' || first_name || ', ' || last_name  || ', ' || email || ', ' || phone_number ||  ', ' || hire_date || ', ' || 
   job_id || ', ' || salary || ', ' || commission_pct || ', ' || department_id || ', ' || manager_id as 'THE_OUTPUT' from employees;

/* ------------- Exercice 2 -------------- */

/* Q1 */
select last_name, salary from employees where salary >= 12000;

/* Q2 */
select last_name, department_id from employees where employee_id = 176;

/* Q3 */
select last_name, salary from employees where salary >= 12000 and salary <= 5000;

/* Q4 */
select last_name, job_id, hire_date from employees where last_name in('Matos','Taylor') order by hire_date asc;

/* Q5 */
select last_name, department_id from employees where department_id in(20, 50) order by last_name asc;

/* Q6 */
select last_name as 'Employee', salary as 'Monthly Salary' from employees where (salary <= 12000 and salary >= 5000) and (department_id in(20, 50));

/* Q7 */
select last_name, hire_date from employees where substr(hire_date, 7, 8) = 94;
select last_name, hire_date from employees where hire_date like '%94';

/* Q8 */
select last_name, job_id from employees where manager_id is null;

/* Q9 */
select last_name, salary, commission_pct from employees where commission_pct is not null order by salary desc, commission_pct desc;

/* Q10 */
select last_name, salary from employees where salary >= &salary; 

/* Q11 */
select employee_id, last_name, salary, department_id from employees where manager_id = &managerId order by &colonneDeTri;

/* Q12 */
select last_name from employees where last_name like '__a%';

/* Q13 */
select last_name from employees where last_name like '%a%' and last_name like '%e%';

/* Q14 */
select last_name, job_id, salary from employees where job_id in('SA_REP','ST_CLERK') and salary is not in (2500, 3500, 7000) ;

/*s Q15 */
select last_name as 'Employee', salary as 'Monthly Salary', commission_pct as 'COMMISSION_PCT' from employees where commission_pct = 0.2;

/* ------------- Exercice 3 -------------- */

/*Q1*/
SELECT sysdate "Date"
FROM dual;

/*Q2 et Q3*/
SELECT employee_id, last_name, salary, ROUND(salary * 1.155, 0) "New Salary" 
FROM employees;

/*Q4*/
SELECT employee_id, last_name, salary, ROUND(salary * 1.155, 0) "New Salary" ROUND(salary * 1.155, 0) - salary "Increase" 
FROM employees;

/*Q5*/
SELECT INITCAP(last_name) "Name", LENGTH(last_name) "Length" FROM employees WHERE SUBSTR(last_name, 0, 1) IN('J','M','A') ORDER BY last_name;

/*Q6*/
SELECT INITCAP(last_name) "Name", LENGTH(last_name) "Length" FROM employees WHERE SUBSTR(last_name, 0, 1)='&start_letter' ORDER BY last_name;

/*Q7*/
SELECT INITCAP(last_name) "Name", LENGTH(last_name) "Length" FROM employees WHERE UPPER(SUBSTR(last_name, 0, 1))=UPPER('&start_letter') ORDER BY last_name;


/*Q8*/
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "MONTHS_WORKED" FROM employees ORDER BY 2;

/*Q9*/
SELECT last_name, LPAD(salary, 15, '$') SALARY FROM employees;

/*Q10*/
SELECT RPAD(last_name, 8) ||' '|| RPAD(' ', salary/1000+1, '*') EMPLOYEES_AND_THEIR_SALARIES FROM employees ORDER BY salary DESC;

/*Q11*/
select last_name, TRUNC((sysdate-hire_date)/7) TENURE from employees where department_id=90 ORDER BY TENURE;


/* ------------- Exercice 4 -------------- */
/*Q1*/
SELECT ( LAST_NAME || ' earns ' || TO_CHAR(SALARY,'$99,999.99') || ' monthly but wants ' ||  TO_CHAR(3*SALARY,'$99,999.99') ) as "dream salary" 
FROM EMPLOYEES;

/*Q2*/
SELECT LAST_NAME , HIRE_DATE , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'LUNDI'),'DAY,"the" DDspth "OF" Month YYYY')  as  REVIEW
FROM EMPLOYEES;

/*Q3*/
SELECT LAST_NAME ,TO_CHAR(HIRE_DATE,'DD MON YY'),TO_CHAR(HIRE_DATE,'DAY') AS DAY, TO_CHAR(HIRE_DATE,'D')
FROM EMPLOYEES
ORDER BY TO_CHAR(HIRE_DATE,'D');

/*Q4*/
SELECT LAST_NAME , NVL(TO_CHAR(SALARY *COMMISSION_PCT) , 'NO COMM') 
FROM EMPLOYEES;

/*Q5*/
SELECT JOB_ID  , DECODE( JOB_ID  ,'AD_PRES' , 'A'
                              ,'ST_MAN'  , 'B'
                              ,'IT_PROG' , 'C'
                              ,'SA_REP'  , 'D'
                              ,'ST_CLERK' , 'E'
                              ,0
                       ) GRADE
FROM EMPLOYEES;

/*Q6*/
SELECT JOB_ID ,  CASE JOB_ID  WHEN 'AD_PRES' THEN 'A'
                              WHEN 'ST_MAN' THEN  'B'
                              WHEN'IT_PROG' THEN 'C'
                              WHEN'SA_REP'  THEN 'D'
                              WHEN'ST_CLERK' THEN 'E'
                              ELSE '0'                       
                END GRADE
FROM EMPLOYEES;

/* ------------- Exercice 5 -------------- */

/*Q1*/
VRAI

/*Q2*/
FAUX

/*Q3*/
VRAI

/*Q4*/
SELECT max(salary) Maximum, min(salary) Minimum, sum(salary) Sum, avg(salary) Average FROM employees

/*Q5*/
SELECT job_id, max(salary) Maximum, min(salary) Minimum, sum(salary) Sum, avg(salary) Average FROM employees GROUP BY job_id;
SELECT job_id, count(*) FROM employees GROUP BY job_id;

/*Q6*/
SELECT job_id, count(*) FROM employees where job_id='&job' GROUP BY job_id;

/*Q7*/
SELECT count(DISTINCT manager_id) FROM employees where job_id=null;

/*Q8*/
SELECT max(salary)-min(salary) DIFFERENCE FROM employees;

/*Q9*/
SELECT manager_id, min(salary) 
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING min(salary)>6000
ORDER BY min(salary) DESC;

/*Q10*/
SELECT COUNT(*) total,
       SUM(DECODE(TO_CHAR(hire_date,'YYYY'), 1995, 1, 0)) "1995", 
       SUM(DECODE(TO_CHAR(hire_date,'YYYY'), 1996, 1, 0)) "1996", 
       SUM(DECODE(TO_CHAR(hire_date,'YYYY'), 1997, 1, 0)) "1997", 
       SUM(DECODE(TO_CHAR(hire_date,'YYYY'), 1998, 1, 0)) "1998"
FROM employees;

/*Q11*/
SELECT job_id "Job",
SUM(DECODE(department_id, 20, salary)) "Dept 20",
SUM(DECODE(department_id, 50, salary)) "Dept 50",
SUM(DECODE(department_id, 80, salary)) "Dept 80",
SUM(DECODE(department_id, 90, salary)) "Dept 90",
SUM(salary) "Total"
FROM employees
GROUP BY job_id;
