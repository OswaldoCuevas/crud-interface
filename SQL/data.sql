CREATE TABLE `users` (
                        `user_id`                   INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                        `type_user`                 VARCHAR(50),
                        `username`                  VARCHAR(200),
                        `email`                     VARCHAR(200),
                        `password`                  VARCHAR(200),
                        `password_token`            VARCHAR(10),
                        `session_token`             VARCHAR(10),
                        `subscription`              BOOLEAN DEFAULT 0,
                        `password_token_confirmed`  BOOLEAN DEFAULT 0,
                        `session_token_confirmed`   BOOLEAN DEFAULT 0,
                        `removed`                   BOOLEAN DEFAULT 0,
                        INDEX                       Index_username(username)
                        );
CREATE TABLE `payment_logs` (
                        `payment_logs_id`           INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                        `producto`                  VARCHAR(200),
                        `user_id`                   INT NOT NULL,
                        `payment_logs_num`          VARCHAR(20),
                        `payment_logs_code`         VARCHAR(20),
                        `customer`                  VARCHAR(200),
                        `price`                     FLOAT,
                        `1_payment_discount`        FLOAT DEFAULT 40,
                        `1_month_payment_discount`  FLOAT DEFAULT 30,
                        `3_month_payment_discount`  FLOAT DEFAULT 10,
                        `6_month_payment_discount`  FLOAT DEFAULT 0,
                        `9_month_payment_discount`  FLOAT DEFAULT 0,
                        `12_month_payment_discount` FLOAT DEFAULT 0,
                        `product_quantity`          INT,
                        `start_date_payment_logs`   DATE,
                        `finalized`                 BOOLEAN DEFAULT 0,
                        `removed`                   BOOLEAN DEFAULT 0,
                        INDEX                       Index_user_id(user_id),
                        FOREIGN KEY                 (user_id)
                        REFERENCES                  users(user_id)
                        );
CREATE TABLE `payments` (
                        `payment_id`                INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                        `payment_logs_id`           INT NOT NULL,
                        `payment`                   FLOAT,
                        `comment`                   TEXT,
                        `payment_date`              DATE,
                        `removed`                   BOOLEAN DEFAULT 0,
                        INDEX                       Index_payment_logs_id(payment_logs_id),
                        FOREIGN KEY                 (payment_logs_id)
                        REFERENCES                  payment_logs(payment_logs_id)
                        );
CREATE TABLE `user_settings` (
                        `settings_id`               INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `user_id`                   INT NOT NULL,
                        `1_payment_discount`        FLOAT DEFAULT 40,
                        `1_month_payment_discount`  FLOAT DEFAULT 30,
                        `3_month_payment_discount`  FLOAT DEFAULT 10,
                        `6_month_payment_discount`  FLOAT DEFAULT 0,
                        `9_month_payment_discount`  FLOAT DEFAULT 0,
                        `12_month_payment_discount` FLOAT DEFAULT 0,
                        INDEX                       Index_user_id(user_id),
                        FOREIGN KEY                 (user_id)
                        REFERENCES                  users(user_id)
                      );

/*------------------------------------------ TRIGGERS --------------------------------------------*/
Delimiter //
create trigger default_settings after insert on users 
FOR EACH ROW
BEGIN 
insert into user_settings (user_id) value (New.user_id);
END // 
Delimiter ;
/*------------------------------------------ CRUD --------------------------------------------*/
/*------------------------------------------ USER --------------------------------------------*/
/* insertar*/
INSERT INTO users (type_user, username, email, password, subscription) 
VALUES ('manager', 'José Cuevas', 'oscuevas18@gmail.com', '123456789', '1');

/* actualizar */
UPDATE users SET password = '12345678' WHERE (user_id = '1');

/* eliminar */
UPDATE users SET removed = '1' WHERE (user_id = '1');

/*------------------------------------------ payment_logs --------------------------------------------*/
/* insertar*/
INSERT INTO payment_logs (producto, user_id, payment_logs_num, payment_logs_code, customer, price, product_quantity, start_date_payment_logs) 
VALUES ('Colcha', '1', '01', '2SVR3T945', 'Juan Felipe', '3000', '1', '2000/03/04');

/* actualizar */
UPDATE payment_logs SET producto             = 'Colchaa',
                   user_id                   = '1q', 
                   payment_logs_num          = '01q', 
                   payment_logs_code         = '2SVR3T945q', 
                   customer                  = 'Juan Felipeq', 
                   price                     = '3000q', 
                   product_quantity          = '1q', 
                   start_date_payment_logs   = '2000-03-05' 
                   WHERE (payment_logs_id = '1');
/* eliminar */
UPDATE payment_logs SET removed = '1' WHERE (payment_logs_id = '1');

/* finalized */
UPDATE payment_logs SET finalized = '1' WHERE (payment_logs_id = '1');

/*------------------------------------------ payments --------------------------------------------*/
/* insertar*/
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-13');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-11');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-13');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-02');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-01');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-04');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-05');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-06');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-04-07');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-05-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-05-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2000-05-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2004-05-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2010-06-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2011-07-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-08-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-09-05');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-02-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2019-04-11');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2019-04-06');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-04-05');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-04-23');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-04-13');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-01-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-02-05');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2014-03-03');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2019-04-11');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2019-05-06');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-07-05');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-08-23');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-12-21');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-12-20');
INSERT INTO payments (payment_logs_id, payment, payment_date) VALUES ('1', '20', '2022-12-19');
-- paiment updat
UPDATE payments SET payment = IFNULL(?,payment), payment_date = IFNULL(?,payment_date) WHERE (payment_id = ?);
--  delete
UPDATE payments SET removed = 1 WHERE (payment_id = ?);
--  muestra la cantidad y el monto de amount_of_payments hechos esta semana
create view weekly_payments as SELECT p.payment_logs_id, u.username as manager, u.user_id as manager_id, p.payment_date, count(*) as amount_of_payments, sum(p.payment) as full_payment,date_format(payment_date, '%d') as _day, date_format(payment_date, '%m') as _month, date_format(payment_date, '%Y') as _year
 FROM payments p
 INNER JOIN payment_logs t on p.payment_logs_id = t.payment_logs_id
 INNER JOIN users u on t.user_id = u.user_id
  where p.payment_date 
between DATE(DATE_ADD(NOW(), INTERVAL -WEEKDAY(NOW()) DAY)) 
 AND
 DATE(DATE_ADD(DATE_ADD(DATE(NOW()), INTERVAL -WEEKDAY(NOW()) DAY),INTERVAL 6 DAY) )
 AND p.removed=0
 AND u.type_user = "manager"
 GROUP BY payment_date,u.user_id
 order BY payment_date asc;
  -- muestra los userss que pagaron en la semana actua
 create view weekly_customer_payments as SELECT t.producto p.payment_logs_id, u.username as manager, u.user_id as manager_id, t.payment_logs_num, t.customer, count(*) as amount_of_payments, sum(p.payment) as full_payment,date_format(payment_date, '%d') as _day, date_format(payment_date, '%m') as _month, date_format(payment_date, '%Y') as _year
 FROM payments p
 INNER JOIN payment_logs t on p.payment_logs_id = t.payment_logs_id
 INNER JOIN users u on t.user_id = u.user_id
  where p.payment_date 
  between DATE(DATE_ADD(NOW(), INTERVAL -WEEKDAY(NOW()) DAY)) 
 AND
 DATE(DATE_ADD(DATE_ADD(DATE(NOW()), INTERVAL -WEEKDAY(NOW()) DAY),INTERVAL 6 DAY) )
 AND p.removed=0
 GROUP BY p.payment_logs_id,u.user_id
 order BY p.payment_date asc;
-- muestra los amount_of_payments agrupados en _days
 Create view payments_grouped_by_days as SELECT p.payment_logs_id,u.username as manager, u.user_id as manager_id, payment_date, count(p.payment) as amount_of_payments, sum(p.payment)  as full_payment, date_format(payment_date, '%d') as _day, date_format(payment_date, '%m') as _month, date_format(payment_date, '%Y') as _year
 FROM payments p
 INNER JOIN payment_logs t on p.payment_logs_id = t.payment_logs_id
 INNER JOIN users u on t.user_id = u.user_id
 where p.removed=0
 GROUP BY payment_date, u.user_id
 order BY payment_date asc;
-- muestra los amount_of_payments agrupados en _monthes
CREATE VIEW payments_grouped_by_month AS SELECT p.payment_logs_id, u.username as manager, u.user_id as manager_id, payment_date, count(*) as amount_of_payments, sum(payment)  as full_payment,date_format(payment_date, '%d') as _day, date_format(payment_date, '%m') as _month, date_format(payment_date, '%Y') as _year
 FROM payments p
 INNER JOIN payment_logs t on p.payment_logs_id = t.payment_logs_id
 INNER JOIN users u on t.user_id = u.user_id
 where p.removed=0
 GROUP BY date_format(payment_date, '%y%m'), u.user_id
 order BY payment_date asc;

-- muestra los userss agrupados que han hecho un payment
create view customer_who_paid as SELECT p.payment_logs_id, u.username as manager, u.user_id as manager_id,p.payment_date, t.payment_logs_num, t.customer,t.producto, count(*) as amount_of_payments, sum(p.payment) as full_payment,date_format(payment_date, '%d') as _day, date_format(payment_date, '%m') as _month, date_format(payment_date, '%Y') as _year
 FROM payments p
 INNER JOIN payment_logs t on p.payment_logs_id = t.payment_logs_id
 INNER JOIN users u on t.user_id = u.user_id
 where p.removed=0
 GROUP BY p.payment_logs_id , date_format(p.payment_date, '%y%m'), u.user_id
 order BY p.payment_date asc;
 -- vista sin eliminar de logs
  CREATE VIEW payment_logs_view AS SELECT * FROM payment_logs WHERE removed = 0 ORDER BY start_date_payment_logs DESC;
 -- vista sin eliminar de payment
  CREATE VIEW payments_view AS SELECT * FROM payments WHERE removed = 0 ORDER BY payment_date ASC;
 -- vista sin eliminar de user
  CREATE VIEW user_view AS SELECT * FROM users WHERE removed = 0 ;

-- pedir pagos semanles de manager en la semana
SELECT * FROM weekly_payments where manager_id = ?;
-- pedir usuario que pagaron en la semana de manager
SELECT * FROM weekly_customer_payments where manager_id = ?;
-- Pagos del mes agrupado en dias
SELECT * FROM payments_grouped_by_days where month(payment_date)=? AND year(payment_date) = ? AND manager_id = ?;
-- Pagos del año agrupado en dias
SELECT * FROM payments_grouped_by_days where year(payment_date) = ? AND manager_id = ?;
-- Pagos del año agrupado en meses
SELECT * FROM payments_grouped_by_month where year(payment_date) = ? AND manager_id = ?;
-- Todos los pagos agrupados en dias
SELECT * FROM payments_grouped_by_days where manager_id = ?;
-- Todos los pagos agrupados en mes
SELECT * FROM payments_grouped_by_month where manager_id = ?;
-- Todos los pagos agrupados en años
SELECT * FROM customer_who_paid where month(payment_date)=? AND year(payment_date) = ? AND manager_id = ?;
-- Pagos del año agrupado en dias
SELECT * FROM customer_who_paid where year(payment_date) = ? AND manager_id = ?;
-- Pagos del año agrupado en meses
SELECT * FROM customer_who_paid where manager_id = ?;