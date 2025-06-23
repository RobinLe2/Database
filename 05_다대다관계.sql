
# 학생 테이블      과목 테이블
# 1                      M    (학생 1명이 여러 과목을 배웁니다.)
# M                     1     (과목 1개를 여러 학생이 배웁니다.)
# M                     M    (일대다 관계가 모두 성립하는  경우 다대다 관계입니다. 다대다 관계는 두테이블을  직접 관계지을 수 없습니다.(


# 다대다 관계는 일대다 관계 2개로 구성합니다.
# 일대다 관계 2개를 구성하려면 테이블이 3개가 필요합니다.

# 학생 테이블      수강현황 테이블      과목 테이블  
#       1                 1,M 모두 작성             
#                         M,1 모두 작성              1
#     PK                       FK
#                                FK                       PK
#     부모                    자식                    부모


 #db model 데이터 베이스 생성
 CREATE DATABASE IF NOT EXISTS  db_model;
 
 # db_model 데이터베이스 사용
 USE db_model;
 
 # 학생 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_student (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    phone     CHAR(11) NULL,
    email       VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)ENGINE = InnoDB;
 
 
 # 과목 테이블 생성
 CREATE TABLE IF NOT EXISTS tbl_subject(
   subject_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   title   VARCHAR(100) NOT NULL,
   credit   TINYINT NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 ) ENGINE = InnoDB;
 

 
 # 수강현황 테이블
 CREATE TABLE IF NOT EXISTS tbl_enrollment(
    enrollment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stud_id INT NOT NULL,
    subj_id INT NOT NULL,
    erolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (stud_id) REFERENCES tbl_student(student_id)   ON DELETE CASCADE,
    FOREIGN KEY (subj_id) REFERENCES tbl_subject(subject_id)    ON DELETE CASCADE,
    UNIQUE KEY(stud_id, subj_id)    # 학생 아이디와 과목 아이디의 조합은 중복이 불가능하도록 설정  (한 학생이 한 과목을 중복 수강하지 못하도록)
 ) ENGINE = InnoDB;
 
 #수강현황 테이블 삭제
 DROP TABLE IF EXISTS tbl_enrollment;
 
 # 과목 테이블 삭제
 DROP TABLE IF EXISTS tbl_subject;
 
 # 학생 테이블 삭제  
 DROP TABLE IF EXISTS tbl_student;
 
  # db_model 데이터베이스 삭제
 DROP DATABASE IF EXISTS db_model;