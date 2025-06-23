# db_company 데이터베이스의 직원 테이블(tbl_employee)을 이용하여 조회하세요.
USE db_company;
SELECT * FROM tbl_employee;

# 1. 직급이 "과장", "부장"인 직원 조회하기
SELECT *
FROM  tbl_employee
WHERE  position IN ("과장","부장");

# 2. 급여가 3000000~5000000인 직원 조회하기
SELECT *
FROM tbl_employee
WHERE salary BETWEEN 3000000 AND 5000000;

# 3. 이름에 "민"이 포함된 직원 조회하기
SELECT *
FROM tbl_employee
WHERE emp_name LIKE ("%민%");

# 4. 직원들이 근무 중인 부서명 중복 제거 후 조회하기
SELECT DISTINCT dept_id
FROM tbl_employee;

# 5. 직급별 급여 평균 조회하기
SELECT position , AVG(salary)
FROM tbl_employee 
GROUP BY  position;


# 6. 부서별 직원 수 조회하기
SELECT dept_id AS 부서번호
              , COUNT(*) AS 사원수
FROM tbl_employee
GROUP BY dept_id;

# 7. 급여 평균이 5000000 이상인 직급 조회하기
SELECT position, AVG(salary)
FROM tbl_employee
GROUP BY POSITION
HAVING AVG(SALARY) >= 5000000;

# 8. 직급이 "과장"인 직원 수 조회하기
SELECT COUNT(*)
FROM tbl_employee
WHERE position = "과장";


# 9. 입사일 과거 순으로 조회하기
SELECT *
FROM tbl_employee
ORDER BY hire_date ASC;

# 10. 직급 순으로 조회하되, 같은 직급은 최신 고용 순으로 조회하기
SELECT *
FROM tbl_employee
ORDER BY position ASC,
                  hire_date DESC;


# 11. 가장 급여가 높은 직원 1명 조회하기
SELECT *
FROM tbl_employee
ORDER BY salary DESC
LIMIT 0 , 1;

# 12. 가장 먼저 입사한 직원 1명 조회하기
SELECT *
FROM tbl_employee
ORDER BY hire_date DESC
LIMIT 0, 1;