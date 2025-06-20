# 고객, 제품, 구매, 구매상세 테이블을 생성
# 한 고객은 여러 번 구매할 수 있습니다. (고객 - 구매)
# 여러번 의 구매에는 각 각 제품이 포함 될 수 있습니다.(구매 - 구매상세 - 제품)
# 고객명, 연락처, 제품명, 제품가격, 재고, 구매일 , 구매한 제품 갯수

 #db model 데이터 베이스 생성
 CREATE DATABASE IF NOT EXISTS  db_model;
 
 # db_model 데이터베이스 사용
 USE db_model;
 

CREATE TABLE IF NOT EXISTS tbl_customer (
customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
customer_number VARCHAR(11)  NULL
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS tbl_purchase(
purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
customer_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES tbl_customer(customer_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS tbl_product(
product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
stock INT NOT NULL,
price DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS tbl_purchasedetail(
purchasedetail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ea INT NOT NULL DEFAULT 1,
product_id INT NOT NULL,
purchase_id INT NOT NULL,
FOREIGN KEY (product_id) REFERENCES tbl_product(product_id) ON DELETE CASCADE,
FOREIGN KEY (purchase_id) REFERENCES tbl_purchase(purchase_id) ON DELETE CASCADE
) ENGINE = InnoDB;


#고객 테이블 삭제
 DROP TABLE IF EXISTS tbl_customer ;
 
 
#제품 테이블 삭제
 DROP TABLE IF EXISTS tbl_product ;
 
 # 구매 테이블 삭제
 DROP TABLE IF EXISTS tbl_purchase;
 
 # 구매 목록 테이블 삭제  
 DROP TABLE IF EXISTS tbl_purchasedetail;
 
  # db_model 데이터베이스 삭제
 DROP DATABASE IF EXISTS db_model;