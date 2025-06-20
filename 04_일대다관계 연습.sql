# db_model 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

# 문제1. 게시글(Post)에 댓글(Comment) 달기
# 한 게시글에 여러 댓글이 달릴 수 있습니다.
# 게시글제목, 게시글내용, 게시글작성일, 댓글내용, 댓글작성일 정보를 저장합니다.

# 게시글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_post (
  post_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  content TEXT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

# 댓글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_comment (
  comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(post_id) REFERENCES tbl_post(post_id) ON DELETE CASCADE
) ENGINE=InnoDB;

# 댓글 테이블 삭제
DROP TABLE IF EXISTS tbl_comment;

# 게시글 테이블 삭제
DROP TABLE IF EXISTS tbl_post;

# 문제2. 부서(Department)에 속한 직원(Employee)
# 한 부서에 여러 직원이 속할 수 있습니다.
# 부서명, 부서위치, 부서장, 직원명, 입사일 정보를 저장합니다.

# 부서 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_department (
  dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL,
  deop_location VARCHAR(100) NULL,
  manager_id INT NULL,
  FOREIGN KEY(manager_id) REFERENCES tbl_employee(emp_id)  # 직원 테이블이 있어야만 부서 테이블을 만들 수 있습니다.
    ON DELETE SET NULL  # 부서장이 삭제되면 manager_id를 NULL 처리합니다.
) ENGINE=InnoDB;

# 직원 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_employee (
  emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dept_id INT NULL,
  emp_name VARCHAR(100) NOT NULL,
  hired_at DATE NOT NULL,
  FOREIGN KEY(dept_id) REFERENCES tbl_department(dept_id)  # 부서 테이블이 있어야만 사원 테이블을 만들 수 있습니다.
    ON DELETE SET NULL  # 부서가 없어지면 dept_id를 NULL 처리합니다.
) ENGINE=InnoDB;

### 위와 같이 작업하면 테이블 생성 순서에 문제가 발생하여 작업을 수행할 수 없습니다.
### 실제로는 외래키 제약조건을 나중에 추가합니다.

# 직원 테이블 생성 (외래키 없이 생성)
CREATE TABLE IF NOT EXISTS tbl_employee (
  emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  emp_name VARCHAR(100) NOT NULL,
  hired_at DATE NOT NULL
) ENGINE=InnoDB;

# 부서 테이블 생성 (외래키 없이 생성)
CREATE TABLE IF NOT EXISTS tbl_department (
  dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL,
  dept_location VARCHAR(100) NULL,
  manager_id INT NULL
) ENGINE=InnoDB;

# 직원 테이블에 dept_id 칼럼 추가하고 외래키 제약조건 추가
ALTER TABLE tbl_employee ADD COLUMN dept_id INT NULL;
ALTER TABLE tbl_employee ADD CONSTRAINT fk_employee_department
  FOREIGN KEY(dept_id) REFERENCES tbl_department(dept_id) ON DELETE SET NULL;

# 부서 테이블의 manager_id 칼럼 외래키 제약조건 추가
ALTER TABLE tbl_department ADD CONSTRAINT fk_department_manager
  FOREIGN KEY(manager_id) REFERENCES tbl_employee(emp_id) ON DELETE SET NULL;

### 부서와 직원 테이블은 서로를 참조하는 순환 참조 구조를 가지기 때문에 DROP TABLE만으로는 삭제할 수 없습니다.
### 외래키 제약조건을 먼저 삭제한 다음 테이블을 삭제할 수 있습니다.
ALTER TABLE tbl_employee DROP FOREIGN KEY fk_employee_department;
ALTER TABLE tbl_department DROP FOREIGN KEY fk_department_manager;

# 직원, 부서 테이블 삭제 (외래키가 없으므로 순서에 상관이 없습니다.)
DROP TABLE IF EXISTS tbl_employee, tbl_department;