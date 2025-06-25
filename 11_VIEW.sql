/*
    뷰
    1. 행과 열로 구성된 테이블입니다.
    2. 데이터를 저장하지는 않기 때문에 가상 테이블이라고 합니다.
    3. 자주 사용하는 복잡한 쿼리문을 뷰로 저장해두면 편리하게 사용할 수 있습니다.
*/

# 뷰 생성
CREATE VIEW  v_company AS
  SELECT emp_id, e.dept_id, emp_name, position, gender, hire_date, salary, dept_name, dept_location
  FROM tbl_department d 
  INNER JOIN tbl_employee e
  ON d.dept_id = e.dept_id;
  
# 뷰 조회하기 
SELECT *
FROM v_company;

# 인라인 뷰 조회하기
SELECT a.* 
FROM (  SELECT emp_id, e.dept_id, emp_name, position, gender, hire_date, salary, dept_name, dept_location
              FROM tbl_department d 
              INNER JOIN tbl_employee e
              ON d.dept_id = e.dept_id) a;