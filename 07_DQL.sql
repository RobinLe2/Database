/*
  DQL
  
  1. 기본 구조
    SELECT 칼럼1 , 칼럼2,  ....칼럼N
    FROM 테이블
    WHERE 조건칼럼 = 값
    GROUP BY 그룹화칼럼1, 그룹화칼럼2, ... 그룹화칼럼N
    HAVING 그룹조건칼럼 = 값
    ORDER BY 정렬칼럼1 (ASC|DESC), 정렬칼럼2(ASC|DESC), ...
    LIMIT 시작, 개수;
    
  2. 각 절의 실행 순서
    1) FROM절
      데이터를 조회할 테이블을 선택합니다.
    2) WHERE 절
      FROM 절에서 가져온 데이터 중 조건에 맞는 행만 선택합니다.
    3) GROUP BY 절
     WHERE 절을 통과한 데이터를 지정한 칼럼 기준으로 그룹화합니다.
    4) HAVING 절
     GROUP BY 절에 의해서 그룹화 된 결과 중에서 조건에 맞는 행만 선택합니다.
    5) SELECT 절
      지금까지 과정을 거친 행(데이터)을 조회할 때 조회 할 칼럼을 작성합니다.
    6)ODER BY 절
      SELECT 절에서 선택한 결과 집합을 지정한 칼럼 기준으로 정렬합니다.
    7) LIMIT 절
      지금까지 과정을 거친 행(데이터)을 조회할 때  개수나 범위를 제한합니다.
      
3. 기타 특징
  1) SELECT 절을 제외하면 모두 생략할 수 있습니다.
  2) SELECT 절에서 조회할 컬럼에 별칭(ALIAS)을 부여할 수 있는데, 이 별칭은 ODER BY 절에서만 사용할 수 있습니다.
    (다른 절에서 조회할 칼럼에 지정한 별칭을(ALIAS)을 사용할 수 없습니다.
  3) GROUP BY 절 없이도 HAVING 절을 사용할 수 있습니다.
      (전체 데이터를 하나의 그룹으로 간주하고 처리합니다.)
  4) ORDER BY 절에서 사용하는 정렬 키워드는 다음 의미를 가집니다.
    (1) ASC : 오름차순 정렬, 생략 가능
    (2) DESC: 내림차순 정렬, 생략 불가능
  5) LIMIT 절의 시작 값은 생략 할 수 있습니다. 이 경우 데이터의 처음부터 가져옵니다. (첫 행의 시작 값은 0입니다.)
    
*/

USE db_company;

# 1. 데이터 없이 데이터 조회하기 ( 표현식 : 연산이나 함수 등)
SELECT NOW();
SELECT 1 + 1 AS SUM;

# 2. 테이블 조회하기(부서 테이블 활용)
# 2-1) 부서 테이블의 모든 데이터 조회하기
SELECT * FROM tbl_department;    -- * : 모든 칼럼을 의미합니다. 실무에서는 사용을 금합니다. (성능 저하)

# 2-2) 부서명과 위치만 조회하기
SELECT dept_name, dept_location FROM tbl_department;

# 2-3) 부서명과 위치만 조회하되, "부서명", "위치"라는 칼럼 별칭 사용하기
SELECT dept_name AS "부서명",
              dept_location AS "위치"  -- 별칭에 공백이 포함되면 반드시 ""필요
FROM tbl_department;
              

# 2-4) 부서명과 위치만 조회하되, 테이블 별칭 사용하기
SELECT d.dept_name AS "부서명",
              d.dept_location AS "위치"
  FROM tbl_department  d;  -- 테이블의 경우 일반적으로 AS 생략
  
  # 2-5) 부서 위치만 조회하되, 중복 제거 후 조회하기
  SELECT  DISTINCT dept_location from tbl_department;
  
  # 2-6) 위치가 "대구"인 부서 조회하기
  SELECT * 
  from tbl_department
  WHERE dept_location ="대구";  -- 비교 연산자 : =, !-, > , >=, < , <=
  
  # 2-7) 위치가 "대구"이고  부서 아이디가 3 이상인 부서 조회하기
  SELECT *
  FROM tbl_department 
  WHERE (dept_location="대구") AND (dept_id >= 3);  -- 논리연산자 : AND, OR
  
  #2-8) 위치가 "서울" 또는 "대구" 인 부서 조회하기
  SELECT *
  FROM tbl_department
  WHERE dept_location = "서울" OR dept_location="대구";
  
  #2-8) 위치가 "서울" 또는 "대구" 인 부서 조회하기
  SELECT *
  FROM tbl_department
  WHERE dept_location IN ("서울", "대구");  -- OR 연산의 대체 연산 : IN연산
  
  # 2-9) 위치가 "서울" 또는 "대구" 가 아닌 부서 조회하기
  SELECT *
  FROM tbl_department
  WHERE dept_location NOT IN ("서울","대구");
  
  SELECT *
  FROM tbl_department
  WHERE dept_location != "서울" AND dept_location <> "대구";
  
  # 2-10) 부서 아이디가 1~3 인 부서 조회하기
  SELECT *
  FROM tbl_department
  WHERE dept_id >=1 and dept_id <= 3 ;
  

  
  SELECT *
  FROM tbl_department
  WHERE dept_id BETWEEN 1 AND 3; 
  
  # 2-11) 부서 위치가 NULL인 부서 조회하기
  SELECT *
  FROM tbl_department
  WHERE dept_location IS NULL;  -- IS NULL(NULL 이다) IS NOT NULL (NULL이 아니다.)
  
  # 2-12) 부서 이름이 "영"으로 시작하는 부서 조회하기
  SELECT * 
  FROM tbl_department
  WHERE dept_name LIKE "영%";  -- % : 와일드카드(만능문자) 글자 수 제한 없음
                                                    -- "영%" : 영으로 시작 , "%영: 영으로 끝,   "%영%" :영을 포함
                                                    --  LIKE:  와일드카드 전용 연산자, 와일드 카드 사용 시 반드시 필요
                                                    --  부정 연산을 함께 사용할 땐 NOT LIKE 순으로 사용
                                                    
  # 2-13) 부서의 위치별로 그룹화하여 부서 수 조회하기        
  # SUM() : 합계, AVG() : 평균 , MAX(): 최대 , MIN(): 최소, COUNT() : 개수
  SELECT dept_location
  FROM tbl_department
  GROUP BY dept_location; -- dept_location 값이 동일하면 하나로 모아서 조회
  
  SELECT dept_name, dept_location  -- GROUP BY절의 칼럼만 조회(SELECT) 가능(dept_name 칼럼 때문에 조회 실패)
  FROM tbl_department
  GROUP BY dept_location; -- dept_location 값이 동일하면 하나로 모아서 조회
  
  SELECT dept_location, COUNT(*)  -- COUNT(*) : 어떤 칼럼이든 값을 가지면 칼럼에 포함
  FROM tbl_department 
  GROUP BY dept_location; -- dept_location 값이 동일하면 하나로 모아서 조회
  
  # 2-14) 부서의 위치별로 그룹화하여 부서 수 조회하되, 부서수가 2개 이상인 부서만 조회하기
   SELECT dept_location AS "부서위치"
                , COUNT(*) AS "부서수"
 FROM tbl_department
 GROUP BY dept_location-- dept_location 값이 동일하면 하나로 모아서 조회
 HAVING  COUNT(*)>= 2;
  

  SELECT dept_location AS "부서위치"
                , COUNT(*) AS "부서수"
 FROM tbl_department
 GROUP BY dept_location-- dept_location 값이 동일하면 하나로 모아서 조회
 HAVING  부서수>= 2;   -- HAVING 절에서 별칭 사용은 버전에 따라 다름(최신 버전은 지원하는 추세)
 
 # 2-15) 부서 이름 순으로 조회하기
 SELECT *
 FROM tbl_department 
 ORDER BY dept_name ASC;  -- ASC : 오름차순(가나다순)   생략가능 DESC :내림차순
                                                
 SELECT *
 FROM tbl_department 
 ORDER BY dept_name DESC;
 
 # 2-16) 부서 위치 순으로 조회하되, 같은 위치의 부서들은 부서 이름 순으로 조회하기
 SELECT *
 FROM tbl_department
 ORDER BY dept_location ASC,
                   dept_name ASC;
                   
# 2-17) 첫 번째 부서부터 2개 부서만 조회하기
SELECT *
FROM tbl_department
LIMIT 0, 2 ;   -- 0: 첫 번째 부서를 의미함 , 2: 2개 부서를 의미함

# 2-18) 세 번째 부서부터 2개 부서만 조회하기
SELECT *
FROM tbl_department
LIMIT 2, 2 ; 

# 2-19) 부서 이름 순으로 조회한 뒤 첫 2개 부서만 조회하기
SELECT * 
FROM tbl_department
ORDER BY dept_name ASC
LIMIT 0 , 2;