-- CAR DEALERSHIP PROJECT
-- Tatiana Jeon

CREATE TABLE IF NOT EXISTS salesperson(
    salesperson_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS car(
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(25),
    model VARCHAR(25),
    year_ INTEGER,
    color VARCHAR(25),
    new_car_cost NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS mechanic(
    mechanic_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS parts(
    parts_id SERIAL PRIMARY KEY,
    part_name VARCHAR(30),
    part_cost NUMERIC(6,2)
);

CREATE TABLE IF NOT EXISTS new_car_invoice(
    car_invoice_id SERIAL PRIMARY KEY,
    purchase_date DATE,
    salesperson_id INTEGER,
    FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
    customer_id INTEGER NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    car_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE IF NOT EXISTS service(
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(50),
    service_cost NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS service_invoice(
    service_invoice_id SERIAL PRIMARY KEY,
    service_id INTEGER,
    FOREIGN KEY(service_id) REFERENCES service(service_id),
    mechanic_id INTEGER NOT NULL,
    FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
    customer_id INTEGER NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    car_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    parts_id INTEGER,
    FOREIGN KEY(parts_id) REFERENCES parts(parts_id)
);

CREATE TABLE IF NOT EXISTS service_history(
    service_hx_id SERIAL PRIMARY KEY,
    service_invoice_id INTEGER NOT NULL,
    FOREIGN KEY(service_invoice_id) REFERENCES service_invoice(service_invoice_id),
    car_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id)
);


-- INSERTS (salespeople, mechanic, parts)
INSERT INTO salesperson(
    first_name,
    last_name
) VALUES(
    'Ivy',
    'McGee'
);

INSERT INTO salesperson(
    first_name,
    last_name
) VALUES(
    'Wren',
    'McGee'
);

INSERT INTO mechanic(
    first_name,
    last_name
) VALUES(
    'Bob',
    'Builder'
);

INSERT INTO mechanic(
    first_name,
    last_name
) VALUES (
    'Dan',
    'McFarland'
);

INSERT INTO parts(
    part_name,
    part_cost
) VALUES(
    'air filter',
    20.00
);


INSERT INTO parts(
    part_name,
    part_cost
) VALUES(
    'alternator',
    250.00
);

INSERT INTO service(
    service_name,
    service_cost
) VALUES(
    'oil change',
    40.00
);

INSERT INTO service(
    service_name,
    service_cost
) VALUES(
    'replace alternator',
    150
);


-- FUNCTIONS (customer, car, invoices)
CREATE OR REPLACE FUNCTION add_customer(_first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $$
BEGIN
    INSERT INTO customer(first_name, last_name) VALUES (_first_name, _last_name);
END;
$$
LANGUAGE plpgsql;

SELECT add_customer('Jimmy', 'John');
SELECT add_customer('Mario', 'Andretti');


CREATE OR REPLACE FUNCTION add_car(_make VARCHAR, _model VARCHAR, _year INTEGER, _color VARCHAR, _new_car_cost NUMERIC)
RETURNS void
AS $$
BEGIN
    INSERT INTO car(make, model, year_, color, new_car_cost) VALUES(_make, _model, _year, _color, _new_car_cost);
END;
$$
LANGUAGE plpgsql;

SELECT add_car('Subaru', 'Outback', 2022, 'White', 35000.00);
SELECT add_car('Mazda', 'CX 30', 2022, 'Black', 40000.00);

-- identify new cars from customer's existing cars via "new_car_cost"


CREATE OR REPLACE FUNCTION _new_car_invoice(_purchase_date DATE, _salesperson_id INTEGER, _customer_id INTEGER, _car_id INTEGER)
RETURNS void
AS $$
BEGIN
    INSERT INTO new_car_invoice(purchase_date, salesperson_id, customer_id, car_id) VALUES(_purchase_date, _salesperson_id, _customer_id, _car_id);
END;
$$
LANGUAGE plpgsql;

SELECT _new_car_invoice('2022-06-25', 1, 1, 1);


CREATE OR REPLACE FUNCTION _service_invoice(_service_id INTEGER, customer_id INTEGER, car_id INTEGER, parts_id INTEGER, mechanic_id INTEGER)
RETURNS void
AS $$
BEGIN 
    INSERT INTO service_invoice(service_id, customer_id, car_id, parts_id, mechanic_id) VALUES (_service_id, customer_id, car_id, parts_id, mechanic_id);
END;
$$
LANGUAGE plpgsql;


SELECT _service_invoice(2, 1, 1, 2, 1);
SELECT _service_invoice(1, 2, 2, NULL, 2);


INSERT INTO service_history(
    service_invoice_id,
    car_id
) VALUES (
    1, 
    1
);

INSERT INTO service_history(
    service_invoice_id,
    car_id
)VALUES(
    2,
    2
);

SELECT * 
FROM service_history;


