/*
  서브 쿼리
  1. 쿼리 내부의 다른 쿼리를 포함하는 것을 의미합니다.
  2. 쿼리가 포함되는 절에 따라 종류를 구분합니다.
  3. 종류
    1) WHERE 절   : 중첩 서브쿼리(단일 행 서브쿼리, 다중 행 서브쿼리)
    2) FROM 절     : 인라인 뷰(테이블 형식의 결과 반환)
    3) SELECT 절  : 스칼라 서브쿼리(하나의 값을 반환하는 서브쿼리)
*/

# dp_ company 데이터베이스 사용
USE db_company;

#  1) WHERE 절   : 중첩 서브쿼리(단일 행 서브쿼리, 다중 행 서브쿼리)

# 직원 아이디가 1001 직원과 같은 직급의 직원 정보 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE position = (SELECT position FROM tbl_employee WHERE emp_id =1001);   -- 단일 행 서브쿼리 (단일행 연산자 : =, !=, > , >= , <, <= )

# 평균 급여 이상을 받는 직원 정보 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE salary >= (SELECT AVG(salary) FROM tbl_employee );  -- 단일 행 서브쿼리

#"영업부"와 "인사부"에 근무하는 직원 정보 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE dept_id IN (SELECT dept_id  
                              FROM tbl_department 
                              WHERE dept_name = "영업부" 
                              OR        dept_name =  "인사부");   -- 다중 행 서브쿼리 ( 다중 행 연산자 : IN, ANY, ALL)
                              
# 2) FROM 절     : 인라인 뷰(테이블 형식의 결과 반환)

#부서별 급여 평균 중에서 가장 높은 급여 평균 구하기
SELECT MAX(a.average)
FROM (  SELECT d.dept_name   AS deptname,     -- 인라인 뷰의 칼럼에 별칭을 추고, 메인쿼리에서 별칭을 사용합니다.
                          AVG (e.salary) AS  average
              FROM tbl_department d
              INNER JOIN tbl_employee e
              ON d.dept_id = e.dept_id
              GROUP BY d.dept_id, d.dept_name) a;
              
  # 직원 아이디가 1003인 직원 정보와 전체 직원의 급여 평균을 함께 조회
  
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary,
              (SELECT AVG(salary) FROM tbl_employee) AS Average
FROM tbl_employee
WHERE emp_id = 1003;

/*
  상관 서브쿼리(Correlated Subquery)
  1. 서브쿼리가 메인쿼리의 값을 참조하는 방식의 쿼리입니다.
  2. 서브쿼리가 메인쿼리의 각 행마다 한 번씩 실행되고, 메인쿼리의 값을 서브쿼리에서 사용합니다.
*/

# 직원 정보와 부서명을 함께 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary,
              ( SELECT dept_name 
                FROM tbl_department  
                WHERE dept_id = e.dept_id)
FROM tbl_employee  e;

SELECT e.emp_id, e.dept_id, e.emp_name, e.position, e.gender, e.hire_date, e.salary, d.dept_name
FROM tbl_employee e
JOIN  tbl_department d
ON e.dept_id = d.dept_id;

# 직원 정보와 해당 직원이 속한 부서의 급여 평균을 함께 조회하기
SELECT e1.emp_id, e1.dept_id, e1.emp_name, e1.position, e1.gender, e1.hire_date, e1.salary,
              (SELECT AVG(e2.salary)
               FROM tbl_employee e2
               WHERE e2.dept_id = e1.dept_id)  AS AVG
FROM tbl_employee e1;
               
               
               


