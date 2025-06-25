# db_company 데이터 베이스 사용
USE db_company;

/*
    클러스터 인덱스
    1. Primary Inedx 입니다.
    2. 테이블에 1개만 존재할 수 있습니다.
    3. PK로 설정된 칼럼은 클러스터 인덱스를 자동으로 가집니다.
*/

# 부서아이디가 1인 부서를 조회하기 : 인덱스 태우기 성공
EXPLAIN
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id = 1;      -- 인덱스가 설정된 칼럼을 그대로 WHERE 절에서 사용합니다.
# 결과
#  type = const       : PK또는 UK를 WHERE절에서 상수 값과 비교하여 항상(const) 하나의 행만 반환하는 접근 방식(가장 빠른 접근 방식)
#  rows=1               : MySQL이 검사할 것으로 예상되는 행의 수     

# 부서아이디가 1인 부서를 조회하기 : 인덱스 태우기 실패
EXPLAIN
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id *2 = 2;  -- 인덱스가 설정된 칼럼을 조작하면 (연산, 함수 등) 더 이상 인덱스를 타지 않습니다.￦
# 결과
#  type = ALL       : 테이블의 모든 행을 처음부터 모두 읽는 Full Table Scan 방식 (가장 안좋은 방식)
#  rows=4            : MySQL이 검사할 것으로 예상되는 행의 수


# 부서아이디가 1　이상인 부서를 조회하기 : 인덱스 태우기 성공
EXPLAIN
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id >= 1; -- MySQL이 Index Range Scan 또는 Full Talbe Scan 중 선택해서 동작합니다.
#결과
# type =range : Index Range Scan 실시
# rows = 4　  MySQL이 검사할 것으로 예상되는 행의 수

/*
     논-클러스터 인덱스
    1. Secondary Inedx 입니다.
    2. 테이블에 1개 이상 존재할 수 있습니다.
    3. UNIQUE로 설정된 칼럼 또는 CREATE INDEX 문을 이용해서 설정합니다.
*/

#보조 인덱스 생성
CREATE INDEX ix_name
ON tbl_employee(emp_name ASC);  -- 직원 테이블의 직원명 칼럼에 인덱스를 설정

# 직원명이 "이은영"인 직원 정보 조회하기
EXPLAIN
SELECT emp_id, dept_id, emp_name , position,gender, hire_date, salary
FROM tbl_employee
WHERE emp_name = "이은영"; 
#결과
# type = ref : 비고유 인덱스(Non Unique)의 동등 비교(=) 에서 나타나는 방식(여러 행을 찾는 효율적 방식)

# 성이 "이"인 직원 정보 조회하기(2가지 방법 비교해보기)
# 1. INDEX LABEL
EXPLAIN
SELECT emp_id, dept_id, emp_name , position,gender, hire_date, salary
FROM tbl_employee
WHERE emp_name LIKE "이%"; 

# 2. Full Table Scan
EXPLAIN
SELECT emp_id, dept_id, emp_name , position,gender, hire_date, salary
FROM tbl_employee
WHERE SUBSTRING(emp_name,1,1) = "이" ;            -- 인덱스 칼럼은 조작하지 않는 것이 좋음