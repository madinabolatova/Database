CREATE DATABASE lab6;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

-- TASK 1
-- a
select * from dealer, client;
-- b
select sell.dealer_id, client.name, client.city, client.priority as grade, sell.id as sell_number, sell.date, sell.amount
    from sell inner join client on sell.client_id = client.id;
-- c
select dealer.id, dealer.name, client.id, client.name, client.city
    from dealer inner join client on dealer.id = client.dealer_id and dealer.location = client.city;
-- d
select sell.id, sell.amount, client.name, client.city
    from sell inner join client on sell.client_id = client.id
    where sell.amount >= 100 and sell.amount <= 500;
-- e
select dealer.id, dealer.name
    from dealer left join client on client.dealer_id = dealer.id;
-- f
select client.name as client_name, client.city, dealer.name as dealer_name, dealer.charge
    from dealer inner join client on dealer.id = client.dealer_id;
-- g
select client.name, client.city, dealer.name, dealer.charge
    from client inner join dealer on dealer.id = client.dealer_id where dealer.charge > 0.12;
-- h
select client.name, client.city, sell.id as sell_id, sell.date as sell_date, sell.amount, dealer.name, dealer.charge
    from client left join sell on client.id = sell.client_id left join dealer on sell.dealer_id = dealer.id;
-- i
select client.name, client.priority as client_grade, dealer.name, sell.id as sell_id, sell.amount as sell_amount
    from client inner join dealer on client.dealer_id = dealer.id left join sell on client.id = sell.client_id
    where sell.amount > 2000 and client.priority is not null or sell.amount is null;

-- TASK 2
-- a
create view cnt_date as
    select sell.date, count(distinct sell.client_id), avg(sell.amount), sum(sell.amount)
        from client inner join sell on client.id = sell.client_id
        group by sell.date;
select * from cnt_date;
-- b
create view order_sum as
    select date, sum(amount) from sell
    group by date
    order by sum(amount) desc;
select * from order_sum
    limit 5;
-- c
create view cnt as
    select dealer_id, count(id), sum(amount), avg(amount) from sell
        group by dealer_id;
select * from cnt;
-- d
create view cnt_location_total as
    select dealer.location, sum(sell.amount) * sum(dealer.charge)
        from dealer inner join sell on dealer.id = sell.dealer_id
        group by dealer.location;
select * from cnt_location_total;
-- e
create view cnt_location_number as
    select dealer.location, count(sell.id), avg(sell.amount), sum(sell.amount)
        from sell inner join dealer on sell.dealer_id = dealer.id
        group by dealer.location;
select * from cnt_location_number;
-- f
create view cnt_city as
    select client.city, count(sell.id), avg(sell.amount), sum(sell.amount)
        from sell inner join client on sell.client_id = client.id
        group by client.city;
select * from cnt_city;
-- g
create view find_location as
    select dealer.location as location, sum(sell.amount) as total_lacotion
        from sell inner join dealer on sell.dealer_id = dealer.id
        group by dealer.location;
create view find_city as
    select client.city as city, sum(sell.amount) as total_city
        from sell inner join client on client.id = sell.client_id
        group by client.city;
select city, total_lacotion, total_city
    from find_location inner join find_city on location = city
    where total_lacotion < total_city;