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
select last_name, hire_date from employees where hire_date like '__/__/94';

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


/* Q1 */
select SYSDATE as "Date" from dual ;

select employee_id, last_name, salary, trunc(salary*1.155,0)as "New Salary" from employees;

select employee_id, last_name, salary, trunc(salary*1.155,0)as "New Salary", trunc(salary*0.155,0) as "Increase" from employees;

select Initcap(last_name)as "Name",length(last_name)as "Length" from employees where substr(last_name,0,1) in ('A','J','M') order by last_name ;                                                                                                                         

select Initcap(last_name)as "Name",length(last_name)as "Length" from employees where substr(last_name,0,1)='&cara' order by last_name;

select Initcap(last_name)as "Name",length(last_name)as "Length" from employees where substr(last_name,0,1)=upper('&cara') order by last_name;

select DISTINCT last_name , round(months_between(sysdate,hire_date),0) as "Months_Worked" from employees order by "Months_Worked" ASC;

select last_name, lpad(salary,15,'$') from employees; 

select substr(last_name,1,8) || ' ' || LPAD(' ', salary / 1000,'*')as "EMPLOYEES AND THEIR SALARIES" from employees;

/* Q11 */
select last_name, round((sysdate-hire_date)/7, 0) TENURE from employees where department_id=90 order by TENURE desc;


/* ------------- Exercice 4 -------------- */
/* Q2 */
select last_name, hire_date, TO_CHAR(hire_date, 'DAY, "the" ddspth "of" mounth, YYYY') REVIEW from employees;  

/* Q3 */
select last_name, hire_date, TO_CHAR(hire_date, 'DAY') DAY from employees order by mod(TO_CHAR(hire_date, 'D') + 5, 7);
