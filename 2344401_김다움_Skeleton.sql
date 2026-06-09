-- DB Final Project Skeleton
-- Student Name: 김다움
-- Student ID: 2344401

-- 1. CREATE TABLE

CREATE TABLE class_code (
    code INT PRIMARY KEY,
    class VARCHAR(20),
    basis VARCHAR(50)
);

CREATE TABLE task_code (
    code INT PRIMARY KEY,
    task VARCHAR(50)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(20),
    class_code INT,
    FOREIGN KEY (class_code) REFERENCES class_code(code)
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(20),
    task_code INT,
    FOREIGN KEY (task_code) REFERENCES task_code(code)
);

CREATE TABLE tour (
    tour_id INT PRIMARY KEY,
    tour_name VARCHAR(50) NOT NULL,
    destination VARCHAR(50),
    price INT,
    start_date DATE
);

CREATE TABLE reserve (
    reserve_id INT PRIMARY KEY,
    customer_id INT,
    tour_id INT,
    staff_id INT,
    reserve_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (tour_id) REFERENCES tour(tour_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- 2. INSERT DATA

INSERT INTO class_code VALUES (1, 'Green', '1천 이상');
INSERT INTO class_code VALUES (2, 'Orange', '2천5백 이상');
INSERT INTO class_code VALUES (3, 'Silver', '5천 이상');
INSERT INTO class_code VALUES (4, 'Gold', '7천 이상');
INSERT INTO class_code VALUES (5, 'Black', '1억 이상');

INSERT INTO task_code VALUES (1, '예약관리');
INSERT INTO task_code VALUES (2, '고객상담');
INSERT INTO task_code VALUES (3, '여행가이드');
INSERT INTO task_code VALUES (4, '운전');
INSERT INTO task_code VALUES (5, '회계');

INSERT INTO customer VALUES (101, '김민수', '010-1111-1111', 1);
INSERT INTO customer VALUES (102, '이가영', '010-2222-2222', 2);
INSERT INTO customer VALUES (103, '박준호', '010-3333-3333', 3);
INSERT INTO customer VALUES (104, '최서연', '010-4444-4444', 4);
INSERT INTO customer VALUES (105, '정다움', '010-5555-5555', 5);

INSERT INTO staff VALUES (201, '홍길동', '010-6666-6666', 1);
INSERT INTO staff VALUES (202, '김영희', '010-7777-7777', 2);
INSERT INTO staff VALUES (203, '이철수', '010-8888-8888', 3);
INSERT INTO staff VALUES (204, '박기사', '010-9999-9999', 4);
INSERT INTO staff VALUES (205, '최회계', '010-0000-0000', 5);

INSERT INTO tour VALUES (301, '제주도 여행', '제주', 500000, '2024-07-01');
INSERT INTO tour VALUES (302, '부산 먹방 투어', '부산', 300000, '2024-07-10');
INSERT INTO tour VALUES (303, '강릉 바다 여행', '강릉', 250000, '2024-07-15');
INSERT INTO tour VALUES (304, '서울 시티 투어', '서울', 150000, '2024-07-20');
INSERT INTO tour VALUES (305, '경주 역사 여행', '경주', 350000, '2024-07-25');

INSERT INTO reserve VALUES (401, 101, 301, 201, '2024-06-01', '예약완료');
INSERT INTO reserve VALUES (402, 102, 302, 202, '2024-06-02', '예약완료');
INSERT INTO reserve VALUES (403, 103, 303, 203, '2024-06-03', '예약대기');
INSERT INTO reserve VALUES (404, 104, 304, 201, '2024-06-04', '예약완료');
INSERT INTO reserve VALUES (405, 105, 305, 202, '2024-06-05', '취소');

-- 3. INDEX

CREATE INDEX idx_customer_class ON customer(class_code);
CREATE INDEX idx_staff_task ON staff(task_code);
CREATE INDEX idx_reserve_customer ON reserve(customer_id);
CREATE INDEX idx_reserve_tour ON reserve(tour_id);

-- 4. TEST QUERIES

-- Customer Grade Search
SELECT c.name, c.phone, cc.class, cc.basis
FROM customer c, class_code cc
WHERE c.class_code = cc.code;

-- Employee Task Search
SELECT s.name, s.phone, tc.task
FROM staff s, task_code tc
WHERE s.task_code = tc.code;

-- Tour Reservation Search
SELECT r.reserve_id, c.name, t.tour_name, r.reserve_date, r.status
FROM reserve r, customer c, tour t
WHERE r.customer_id = c.customer_id
AND r.tour_id = t.tour_id;

-- Assigned Driver Search
SELECT name, phone
FROM staff
WHERE task_code = 4;

-- INSERT example
INSERT INTO customer
VALUES (106, '한지민', '010-1212-1212', 2);

-- UPDATE example
UPDATE reserve
SET status = '예약완료'
WHERE reserve_id = 403;

-- DELETE example
DELETE FROM customer
WHERE customer_id = 106;

-- 5. BONUS TABLES

CREATE TABLE driver (
    driver_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(20),
    license_no VARCHAR(30)
);

CREATE TABLE tour_bus (
    bus_id INT PRIMARY KEY,
    bus_no VARCHAR(20),
    seat_count INT
);

CREATE TABLE assign_driver (
    assign_id INT PRIMARY KEY,
    tour_id INT,
    driver_id INT,
    FOREIGN KEY (tour_id) REFERENCES tour(tour_id),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

CREATE TABLE assign_bus (
    assign_id INT PRIMARY KEY,
    tour_id INT,
    bus_id INT,
    FOREIGN KEY (tour_id) REFERENCES tour(tour_id),
    FOREIGN KEY (bus_id) REFERENCES tour_bus(bus_id)
);
