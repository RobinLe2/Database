-- DDL (Data Definition Language)
--     1) 데이터 정의어
--     2) 데이터베이스 객체(데이터베이스 ,테이블, 사용자 등)의 정보를 다루는 언어
--     3) 종류
--         (1) CREATE: 생성
--         (2) ALTER: 수정
--         (3) DROP : 삭제
--         (4) TRUNC : 삭제의 한 종류

#데이터베이스 생성하기
CREATE DATABASE IF NOT EXISTS db_ddl; 

# 데이터베이스 사용하기
USE db_ddl;

#테이블 생성하기 (데이터 저장을 위한 데이터베이스 객체)
# 행 (row) 열 (column)
# 기본 문법 : 칼럼명 -> 데이터 타입 -> 제약조건 순으로 작성
CREATE TABLE IF NOT EXISTS tbl_product (
  product_id          INT                         NOT NULL  AUTO_INCREMENT  PRIMARY KEY,   # 자동 순번(1부터 시작), 기본 키(식별자) 
  product_name    VARCHAR(50)         NOT NULL,    #Variable length character string 최대 글자 수 
  price                  DECIMAL(10, 2)       NOT NULL,            #실수 (10, 2)  전체 자리 수 10(소수점 자리 포함), 소수점 2자리, NULL(빈칸)(필수로 입력해야함)이면 안된다.
  discount            DECIMAL(10,2)         NULL,                 # 비어있어도 된다.
  create_at           DATETIME               DEFAULT NOW() 
) ENGINE=InnoDB;

# 대표적인 스토리지 엔진들
# InnoDB	기본 엔진 : 트랜잭션 지원(동시성), 외래 키(무결성 지원), 은행 또는 일반적인 사이트
# MyISAM	: 트랜잭션 및 외래 키 미지원, 풀테스트 인덱스 지원(읽기 위주의 환경에 적합)

# AUTO_INCREAMENT 시작 값을 바꾸는 방법
ALTER TABLE tbl_product AUTO_INCREMENT = 1000;  #순번이 1000부터 시작

# TABLE 삭제하기(취소 불가능)
DROP TABLE IF EXISTS tbl_product;

#데이터베이스 삭제하기(취소 불가능)
DROP DATABASE IF EXISTS db_ddl;