create database Project;
-- TASK2
create table Customer(
    customer_id integer primary key,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    city varchar(30) not null,
    street varchar(30) not null,
    home_number integer not null
);
create table Package(
    package_id integer primary key,
    customer_id integer references Customer(customer_id),
    weight integer not null,
    price integer check(price > 0),
    delivery_city varchar(20) not null,
    delivery_street varchar(50) not null,
    delivery_home integer not null,
    delivery_start date not null,
    delivery_end date not null
);
create table Hazardous_material(
    package_id integer references Package(package_id),
    transport_id integer not null,
    price integer check(price > 0)
);
create table International_shipment(
    package_id integer references Package(package_id),
    declaration_id integer unique not null,
    price integer check(price > 0)
);
create table Normal(
    package_id integer references Package(package_id),
    price integer check(price > 0)
);
create table Account(
    account_id integer,
    customer_id integer references Customer(customer_id),
    primary key (account_id, customer_id)
);
create table prepaid(
    account_id integer,
    customer_id integer,
    foreign key(account_id, customer_id) references Account(account_id, customer_id),
    package_id integer references Package(package_id),
    receipt_num text not null
);
create table infrequent_customer(
    account_id integer,
    customer_id integer,
    foreign key(account_id, customer_id) references Account(account_id, customer_id),
    package_id integer references Package(package_id),
    credit_card_number text not null
);
create table contract(
    account_id integer,
    customer_id integer,
    foreign key(account_id, customer_id) references Account(account_id, customer_id),
    package_id integer references Package(package_id),
    monthly_fee integer not null
);
create table Employee(
    employee_id integer primary key,
    first_name varchar(30) not null,
    last_name varchar(50) not null,
    salary integer not null ,
    date_of_birth date,
    shift_at_work varchar(20) not null
);
create table Transport(
    transport_id integer primary key,
    type varchar(20) not null,
    expenses integer not null
);
create table Tracking(
    tracking_id integer ,
    tr_transport_id integer references Transport(transport_id),
    tr_employee_id integer references Employee(employee_id),
    package_id integer references Package(package_id),
    primary key (tracking_id, package_id),
    status varchar(30) not null,
    location_country varchar(30) not null,
    location_city varchar(30) not null,
    location_street varchar(50) not null,
    date_of_arrival date not null
);
-----creating indexes
create index idx_address_customer on customer(city, street);
create index idx_name_customer on customer(first_name, last_name);
create index idx_package_date on package(delivery_start, delivery_end);

-- TASK3
insert into Customer values(1, 'Meru', 'Bolat', 'Sankt-Peterburg', 'Naberezhnaya', 15);
insert into Customer values(2, 'Emilia', 'Theodor', 'Oxford', 'Lombard', 11);
insert into Customer values(3, 'Stella', 'Nathan', 'Berlin', 'Schulstrabe', 13);
insert into Customer values(4, 'Emma', 'Jacob', 'Gamburg', 'Hauptstrabe', 12);
insert into Customer values(5, 'John', 'Donald', 'Pekin', 'Chzhan Czichjun', 15);
insert into Customer values(6, 'Olivia', 'Andrew', 'Frankfurt', 'Schulstrabe', 11);
insert into Customer values(7, 'David', 'Nathan', 'Atyrau', 'Abylai', 15);
insert into Customer values(8, 'Christa', 'Jack', 'Liverpool', 'Lame', 16);
insert into Customer values(9, 'Ethan', 'Trump', 'Gamburg', 'Hauptstrabe', 14);
insert into Customer values(10, 'William', 'Connor', 'Oxford', 'Cat', 18);
insert into Customer values(11, 'Emilia', 'Anthony', 'Gamburg', 'Gartenstrabe', 12);
insert into Customer values(12, 'Christa', 'Jack',' Oxford', 'Cat', 10);
insert into Customer values(13, 'Oliver', 'Donald', 'Gamburg', 'Gartenstrabe', 14);
insert into Customer values(14, 'John', 'Hunter', 'Gamburg', 'Bahnhofstrabe', 15);
insert into Customer values(15, 'John', 'Bob', 'Manchester', 'Baker', 6);
insert into Customer values(16, 'Ethan', 'Hunter', 'Manchester', 'Lombard', 15);
insert into Customer values(17, 'Olivia', 'Samuel', 'Gamburg', 'Gartenstrabe', 4);
insert into Customer values(18, 'Emilia', 'Jacob', 'Novosybirsk', 'Sovetskaya', 10);
insert into Customer values(19, 'Olivia', 'Samuel', 'Guanchjou', 'Tun Linge', 20);
insert into Customer values(20, 'Alex', 'Trump', 'Berlin', 'Hauptstrabe', 20);

insert into Package values(1, 14, 300, 150, 'Pekin', 'Chzhao Denui', 7, '2020-10-14', '2020-10-22');
insert into Package values(2, 15, 23500, 3147, 'Berlin', 'Hauptstrabe', 13, '2021-04-28', '2021-05-23');
insert into Package values(3, 9, 500, 200, 'Novosybirsk', 'Shkolnaya', 8, '2020-01-13', '2020-01-20');
insert into Package values(4, 15, 58, 4412, 'Atyrau', 'Tolebi', 1, '2021-05-25', '2021-06-20');
insert into Package values(5, 7, 15, 500, 'Astana', 'Shamshi', 14, '2020-06-13', '2020-06-28');
insert into Package values(7, 4, 10200, 1500, 'Frankfurt', 'Gartenstrabe', 1, '2020-06-23', '2020-07-08');
insert into Package values(8, 11, 17, 1380, 'Munhen', 'Schulstrabe', 4, '2020-07-22', '2020-08-17');
insert into Package values(9, 8, 300, 155, 'Kazan', 'Sovetskaya', 2, '2020-01-01', '2020-01-08');
insert into Package values(10, 16, 20300, 3009, 'Oxford', 'Baker', 12, '2020-09-15', '2020-10-10');
insert into Package values(11, 4, 25800, 2500, 'Manchester', 'Cat', 16, '2020-01-27', '2020-02-12');
insert into Package values(12, 20, 70, 8975, 'Oxford', 'Baker', 11, '2020-10-18', '2020-11-13');
insert into Package values(13, 8, 75800, 4757, 'Novosybirsk', 'Novaya', 12, '2021-04-12', '2021-04-27');
insert into Package values(14, 16, 12, 2419, 'Novosybirsk', 'Shkolnaya', 12, '2020-11-28', '2020-12-23');
insert into Package values(15, 3, 800, 25080, 'Ekaterinburg', 'Sovetskaya', 9, '2021-02-01', '2021-02-08');
insert into Package values(16, 2, 17, 3162, 'Oxford', 'Lombard', 2, '2020-04-28', '2020-05-23');
insert into Package values(17, 9, 900, 28070, 'Munhen', 'Gartenstrabe', 18, '2020-10-17', '2020-10-24');
insert into Package values(18, 13, 30, 4570, 'Munhen', 'Gartenstrabe', 20, '2021-02-23', '2021-03-18');
insert into Package values(19, 6, 19700, 189070, 'Shankhai', 'Chzhao Denui', 2, '2020-03-01', '2020-03-26');
insert into Package values(20, 19, 14, 3749, 'Almaty', 'Sholpan', 16, '2020-02-17', '2020-03-12');
insert into Package values(21, 1, 650, 232, 'Aktobe', 'Abylai', 8, '2020-11-19', '2020-11-26');
insert into Package values(22, 20, 12, 1292, 'Almaty',' Sholpan', 18, '2020-02-19', '2020-03-14');
insert into Package values(23, 4, 450, 5780, 'Pekin', 'Chzhan Czichjun', 19, '2021-11-14', '2021-11-21');
insert into Package values(24, 18, 27, 4703, 'Shankhai', 'Chzhao Denui', 14, '2020-02-01', '2020-02-26');
insert into Package values(25, 6, 5800, 1300, 'Pekin', 'Chzhao Denui', 17, '2020-11-14', '2020-11-29');
insert into Package values(26, 15, 25, 3934, 'Aktobe', 'Abai', 4, '2020-04-27', '2020-05-22');
insert into Package values(27, 19, 1800, 121110, 'Gamburg', 'Bahnhofstrabe', 13, '2021-04-13', '2021-04-20');
insert into Package values(28, 10, 21, 8570, 'Almaty', 'Shamshi', 13, '2020-08-18','2020-09-18');
insert into Package values(29, 2, 970, 144, 'Aktobe', 'Shamshi', 1, '2021-02-27', '2021-02-05');
insert into Package values(30, 17, 100, 17064, 'Shymkent', 'Tolebi', 9, '2021-04-12', '2021-05-07');
insert into Package values(31, 13, 24, 6404, 'Shtutgart', 'Gartenstrabe', 12, '2021-05-21', '2021-05-09');
insert into Package values(32, 17, 93, 9465, 'Shymkent', 'Shamshi', 7, '2020-08-09', '2020-08-04');
insert into Package values(33, 4, 4, 1558, 'Munhen', 'Bahnhofstrabe', 14, '2020-10-20', '2020-1-05');
insert into Package values(34, 9, 11, 6470, 'Chendu', 'Chzhao Denui', 6, '2021-01-23', '2021-02-18');
insert into Package values(35, 11, 94, 8708, 'Chendu', 'Tun Linge', 11, '2020-02-04', '2020-02-19');
insert into Package values(36, 7, 21, 4963, 'Gartenstrabe', 'Gartenstrabe', 3, '2021-11-04', '2021-11-29');
insert into Package values(37, 2, 5600, 1277, 'Almaty', 'Abai', 7, '2021-04-02', '2021-04-09');
insert into Package values(38, 18, 52, 8794, 'Novosybirsk', 'Sadovaya', 16, '2020-03-19', '2020-04-14');
insert into Package values(39, 19, 860, 157, 'Frankfurt', 'Bahnhofstrabe', 1, '2021-03-22', '2021-03-29');
insert into Package values(40, 12, 80, 7022, 'Novosybirsk', 'Sadovaya', 19, '2020-03-02', '2020-03-27');
insert into Package values(41, 1, 1900, 50050, 'Chendu', 'Tun Linge', 12, '2021-10-19', '2021-10-26');
insert into Package values(42, 19, 40, 10145, 'Frankfurt', 'Schulstrabe', 18,'2020-02-13', '2020-03-14');
insert into Package values(43, 4, 900, 18970, 'Sankt-Peterburg', 'Sovetskaya', 15, '2020-01-17','2020-01-24');
insert into Package values(44, 4, 72, 7093, 'Pekin', 'Tun Linge', 5, '2020-04-20', '2020-05-20');
insert into Package values(45, 5, 2300, 61290, 'Kazan', 'Naberezhnaya', 5, '2021-09-19', '2021-10-04');
insert into Package values(46, 18, 34, 15403, 'Edinburg', 'Cat', 13, '2021-01-23', '2021-02-23');
insert into Package values(47, 11, 2200, 324, 'Manchester', 'Cat', 1, '2020-03-02', '2020-03-27');
insert into Package values(48, 12, 94, 9449, 'Birmingem', 'Lombard', 5,'2020-11-16', '2020-12-16');
insert into Package values(49, 9, 610, 6590, 'Guanchjou', 'Chzhao Denui', 3,'2021-03-16', '2021-03-23');
insert into Package values(50, 3, 48, 17533, 'Edinburg', 'Lame', 12, '2021-09-19', '2021-10-19');
insert into Package values(51, 7, 3800, 611, 'Novosybirsk','Sovetskaya', 12,'2021-07-16', '2021-07-23');
insert into Package values(52, 8, 52, 8093, 'Ekaterinburg', 'Novaya', 18, '2020-01-03', '2020-02-03');
insert into Package values(53, 15, 53, 8157, 'Shymkent', 'Abai', 16, '2020-05-19', '2020-06-04');
insert into Package values(54, 7, 2, 4304, 'Aktobe', 'Abai', 7, '2021-01-25', '2021-02-25');
insert into Package values(55, 4, 67, 9582, 'Shankhai', 'Chzhao Denui', 1, '2021-01-13', '2021-01-28');
insert into Package values(56, 5, 88, 25021, 'Edinburg', 'Baker', 11, '2021-05-12', '2021-06-12');
insert into Package values(57, 5, 300, 98682, 'Pekin', 'Chzhao Denui', 9, '2020-05-18', '2020-05-25');
insert into Package values(58, 11, 89, 19164, 'Moskva', 'Shkolnaya', 18, '2021-11-08', '2021-12-08');
insert into Package values(59, 6, 1200, 3060, 'Guanchjou', 'Tun Linge', 17, '2020-01-06', '2020-01-13');
insert into Package values(60, 1, 78, 18086, 'Guanchjou', 'Tun Linge', 19, '2021-05-17', '2021-06-17');

insert into Employee values(1, 'Anjelina', 'Andrew', 15000, '1995-06-21', 'Day');
insert into Employee values(2, 'Emilia', 'Bob', 20000, '1985-10-25', 'Night');
insert into Employee values(3, 'Aiden', 'Hunter', 10000, '1995-07-13', 'Day');
insert into Employee values(4, 'Emma', 'Andrew', 20000, '1995-01-30', 'Night');
insert into Employee values(5, 'John', 'Connor', 20000, '1992-06-17', 'Day');
insert into Employee values(6, 'Alex', 'Jacob', 20000, '1995-07-28', 'Night');
insert into Employee values(7, 'William', 'Anthony', 10000, '2003-05-19', 'Day');
insert into Employee values(8, 'David', 'Bob', 15000, '1978-05-26', 'Night');
insert into Employee values(9, 'Olivia', 'Biden', 20000, '1992-02-17', 'Day');
insert into Employee values(10, 'Alex', 'Andrew', 20000, '1995-07-20', 'Night');
insert into Employee values(11, 'Alex', 'Theodor', 10000, '1990-04-02', 'Day');
insert into Employee values(12, 'Emma', 'Nathan', 15000, '2000-08-24', 'Night');
insert into Employee values(13, 'John', 'Trump', 20000, '1975-06-22', 'Day');
insert into Employee values(14, 'Stella', 'Theodor', 15000, '1985-02-24', 'Night');
insert into Employee values(15, 'James', 'Jack', 15000, '1992-04-15', 'Day');
insert into Employee values(16, 'Ethan', 'Nathan', 20000, '1992-10-02', 'Night');
insert into Employee values(17, 'John', 'Theodor', 10000, '1997-05-22', 'Day');
insert into Employee values(18, 'John', 'Ryan', 20000, '2003-09-27', 'Night');
insert into Employee values(19, 'Stella', 'Trump', 20000, '2000-10-29', 'Day');
insert into Employee values(20, 'Aiden' ,'Biden', 20000, '1992-07-21', 'Night');

insert into Transport values(1721, 'lorry', 10000);
insert into Transport values(335, 'ship', 20000);
insert into Transport values(477, 'ship', 20000);
insert into Transport values(406, 'plane', 15000);
insert into Transport values(1481, 'lorry', 10000);
insert into Transport values(1002, 'lorry', 10000);
insert into Transport values(1145, 'lorry', 10000);
insert into Transport values(276, 'plane', 15000);
insert into Transport values(1620, 'lorry', 10000);
insert into Transport values(443, 'lorry', 10000);
insert into Transport values(758, 'lorry', 10000);
insert into Transport values(1413, 'plane', 15000);

insert into Account values(1,1);
insert into Account values(2,2);
insert into Account values(3,3);
insert into Account values(4,4);
insert into Account values(5,5);
insert into Account values(6,6);
insert into Account values(7,7);
insert into Account values(8,8);
insert into Account values(9,9);
insert into Account values(10,10);
insert into Account values(11,11);
insert into Account values(12,12);
insert into Account values(13,13);
insert into Account values(14,14);
insert into Account values(15,15);
insert into Account values(16,16);
insert into Account values(17,17);
insert into Account values(18,18);
insert into Account values(19,19);
insert into Account values(20,20);
insert into Account values(21,1);

insert into Normal values(1, 100);
insert into Normal values(3, 100);
insert into Normal values(5, 300);
insert into Normal values(7, 300);
insert into Normal values(9, 100);
insert into Normal values(11, 300);
insert into Normal values(13, 300);
insert into Normal values(15, 100);
insert into Normal values(17, 100);
insert into Normal values(19, 300);
insert into Normal values(21, 100);
insert into Normal values(23, 100);
insert into Normal values(25, 300);
insert into Normal values(27, 100);
insert into Normal values(29, 100);
insert into Normal values(31, 300);
insert into Normal values(33, 300);
insert into Normal values(35, 300);
insert into Normal values(37, 100);
insert into Normal values(39, 100);
insert into Normal values(41, 100);
insert into Normal values(43, 100);
insert into Normal values(45, 300);
insert into Normal values(47, 200);
insert into Normal values(49, 100);
insert into Normal values(51, 100);
insert into Normal values(53, 300);
insert into Normal values(55, 300);
insert into Normal values(57, 100);
insert into Normal values(59, 100);

insert into International_shipment values(2, 9570,300);
insert into International_shipment values(4, 4236, 500);
insert into International_shipment values(8, 4360, 200);
insert into International_shipment values(10, 2376, 200);
insert into International_shipment values(12, 4319, 200);
insert into International_shipment values(14, 4571, 300);
insert into International_shipment values(16, 7768, 400);
insert into International_shipment values(18, 5372, 200);
insert into International_shipment values(20, 1466, 500);
insert into International_shipment values(22, 9637, 100);
insert into International_shipment values(24, 5955, 500);
insert into International_shipment values(26, 3830, 400);
insert into International_shipment values(28, 8291, 600);
insert into International_shipment values(30, 4353, 100);
insert into International_shipment values(32, 8806, 200);
insert into International_shipment values(34, 1146, 500);
insert into International_shipment values(36, 5102, 400);
insert into International_shipment values(38, 7065, 400);
insert into International_shipment values(40, 6187, 300);

insert into Hazardous_material values(42, 335, 400);
insert into Hazardous_material values(44, 1002, 100);
insert into Hazardous_material values(46, 1481, 600);
insert into Hazardous_material values(48, 1145, 400);
insert into Hazardous_material values(50, 1002, 500);
insert into Hazardous_material values(52, 335, 600);
insert into Hazardous_material values(54, 1145, 500);
insert into Hazardous_material values(56, 443, 500);
insert into Hazardous_material values(58, 758, 600);
insert into Hazardous_material values(60, 1413, 600);

insert into prepaid values(13, 13, 31, '1330');
insert into prepaid values(17, 17, 32, '1003');
insert into prepaid values(4, 4, 33, '1011');
insert into prepaid values(9, 9, 34, '1974');
insert into prepaid values(11, 11, 35, '1959');
insert into prepaid values(7, 7, 36, '1007');
insert into prepaid values(2, 2, 37, '1124');
insert into prepaid values(18, 18, 38, '1507');
insert into prepaid values(19, 19, 39, '1041');
insert into prepaid values(19, 19, 42, '1817');
insert into prepaid values(6, 6, 43, '1061');
insert into prepaid values(4, 4, 44, '1145');
insert into prepaid values(5, 5, 45, '1075');

insert into infrequent_customer values(14, 14, 1, '58789279');
insert into infrequent_customer values(15, 15, 2, '53283876');
insert into infrequent_customer values(9, 9, 3, '54707483');
insert into infrequent_customer values(15, 15, 4, '77067018');
insert into infrequent_customer values(7, 7, 5, '54120707');
insert into infrequent_customer values(10, 10, 6, '64900853');
insert into infrequent_customer values(4, 4, 7, '66354664');
insert into infrequent_customer values(11, 11, 8, '76503392');
insert into infrequent_customer values(8, 8, 9, '60002707');
insert into infrequent_customer values(16, 16, 10, '76038374');
insert into infrequent_customer values(4, 4, 11, '61336282');
insert into infrequent_customer values(20, 20, 12, '73333839');
insert into infrequent_customer values(8, 8, 13, '58946966');
insert into infrequent_customer values(16, 16, 14, '51472711');
insert into infrequent_customer values(3, 3, 15, '58830607');
insert into infrequent_customer values(2, 2, 16, '61555493');
insert into infrequent_customer values(9, 9, 17, '76466162');
insert into infrequent_customer values(13, 13, 18, '79107554');
insert into infrequent_customer values(6, 6, 19, '78766102');
insert into infrequent_customer values(19, 19, 20, '55730751');
insert into infrequent_customer values(21, 1, 21, '63911308');
insert into infrequent_customer values(20, 20, 22, '71797131');
insert into infrequent_customer values(4, 4, 23, '56588497');
insert into infrequent_customer values(18, 18, 24, '67902110');
insert into infrequent_customer values(6, 6, 25, '76222190');
insert into infrequent_customer values(15, 15, 26, '79308666');
insert into infrequent_customer values(19, 19, 27, '58374772');
insert into infrequent_customer values(10, 10, 28, '76534937');
insert into infrequent_customer values(2, 2, 29, '57302450');
insert into infrequent_customer values(17, 17, 30, '59552693');

insert into contract values(18, 18, 46, 3000);
insert into contract values(11, 11, 47, 3000);
insert into contract values(12, 12, 48, 2000);
insert into contract values(9, 9, 49, 1000);
insert into contract values(3, 3, 50, 2000);
insert into contract values(7, 7, 51, 3000);
insert into contract values(8, 8, 52, 3000);
insert into contract values(15, 15, 53, 2000);
insert into contract values(7, 7, 54, 3000);
insert into contract values(4, 4, 55, 1000);
insert into contract values(5, 5, 56, 2000);
insert into contract values(5, 5, 57, 1000);
insert into contract values(11, 11, 58, 2000);
insert into contract values(6, 6, 59, 2000);
insert into contract values(1, 1, 60, 3000);

insert into Tracking values(1, null, null, 9, 'created','Russian','Ekaterinburg','Novaya','2020-01-01');
insert into Tracking values(2, null ,2, 9, 'processed','Russian','Ekaterinburg','Novaya','2020-01-01');
insert into Tracking values(3, 1721, 3, 9, 'submitted for delivery','Russian','Ekaterinburg','Novaya','2020-01-02');
insert into Tracking values(4, null, null, 52, 'created','Russian','Ekaterinburg','Sovetskaya','2020-01-03');
insert into Tracking values(5, null, 2, 52, 'processed','Russian','Ekaterinburg','Sovetskaya','2020-01-03');
insert into Tracking values(6, 335, 3, 52, 'submitted for delivery','Russian','Ekaterinburg','Sovetskaya','2020-01-04');
insert into Tracking values(7, null, null, 59, 'created','China','Chendu','Chzhao Denui','2020-01-06');
insert into Tracking values(8, 1721, 3, 9, 'delivered','Russian','Kazan','Sovetskaya','2020-01-07');
insert into Tracking values(9, null, null, 9, 'received','Russian','Kazan','Sovetskaya','2020-01-08');
insert into Tracking values(10, null, 4, 59, 'processed','China','Chendu','Chzhao Denui','2020-01-08');
insert into Tracking values(11, 1721, 5, 59, 'submitted for delivery','China','Chendu','Chzhao Denui','2020-01-09');
insert into Tracking values(12, 1721, 5, 59, 'delivered','China','Guanchjou','Tun Linge','2020-01-13');
insert into Tracking values(13, null, null, 3, 'created','Russian','Kazan','Naberezhnaya','2020-01-13');
insert into Tracking values(14, null, 6, 3, 'processed','Russian','Kazan','Naberezhnaya','2020-01-13');
insert into Tracking values(15, 1721, 7, 3, 'submitted for delivery','Russian','Kazan','Naberezhnaya','2020-01-14');
insert into Tracking values(16, 1721, 5, 59, 'received','China','Guanchjou','Tun Linge','2020-01-14');
insert into Tracking values(17, null, null, 43, 'created','Russian','Novosybirsk','Sadovaya','2020-01-17');
insert into Tracking values(18, null, 14, 43, 'processed','Russian','Novosybirsk','Sadovaya','2021-01-18');
insert into Tracking values(19, 1413, 8, 43, 'submitted for delivery','Russian','Novosybirsk','Sadovaya','2020-01-19');
insert into Tracking values(20, 1721, 7, 3, 'delivered','Russian','Novosybirsk','Shkolnaya','2020-01-21');
insert into Tracking values(21, null, null, 3, 'received','Russian','Novosybirsk','Shkolnaya','2020-01-21');
insert into Tracking values(22, 335, 3, 52, 'delivered','Russian','Ekaterinburg','Novaya','2020-02-04');
insert into Tracking values(23, null, null, 52, 'received','Russian','Ekaterinburg','Novaya','2020-02-05');
insert into Tracking values(24, 1413, 8, 43, 'delivered','Russian','Sankt-Peterburg','Sovetskaya','2020-01-23');
insert into Tracking values(25, null, null, 43, 'received','Russian','Sankt-Peterburg','Sovetskaya','2020-01-23');
insert into Tracking values(26, null, null, 11, 'created','British','Oxford','Cat','2020-01-27');
insert into Tracking values(27, null, 11, 11, 'processed','British','Oxford','Cat','2020-01-28');
insert into Tracking values(28, 1145, 19, 11, 'submitted for delivery','British','Oxford','Cat','2020-01-29');
insert into Tracking values(29, 1145, 19, 11, 'delivered','British','Manchester','Cat','2020-02-13');
insert into Tracking values(30, 1145, 19, 11, 'received','British','Manchester','Cat','2020-02-15');
insert into Tracking values(31, null, null, 24, 'created','Kazakhstan','Shymkent','Tolebi','2020-02-01');
insert into Tracking values(32, null, 12, 24, 'processed','Kazakhstan','Shymkent','Tolebi','2020-02-01');
insert into Tracking values(33, 477, 18, 24, 'submitted for delivery','Kazakhstan','Shymkent','Tolebi','2020-02-01');
insert into Tracking values(34, 477, 18, 24, 'delivered','China','Shankhai','Chzhao Denui','2020-02-25');
insert into Tracking values(35, null, null, 24, 'received','China','Shankhai','Chzhao Denui','2020-02-25');
insert into Tracking values(36, null, null, 35, 'created','China','Guanchjou','Chzhao Denui','2020-02-04');
insert into Tracking values(37, null, 11, 35, 'processed','China','Guanchjou','Chzhao Denui','2020-02-04');
insert into Tracking values(38, 758, 19, 35, 'submitted for delivery','China','Guanchjou','Chzhao Denui','2020-02-06');
insert into Tracking values(39, 758, 19, 35, 'delivered','China','Chendu','Tun Linge','2020-02-19');
insert into Tracking values(40, null, null, 35, 'received','China','Chendu','Tun Linge','2020-02-19');
insert into Tracking values(41, null, null, 42, 'created','Germany','Berlin','Schulstrabe','2020-02-13');
insert into Tracking values(42, null, 7, 42, 'processed','Germany','Berlin','Schulstrabe','2020-02-14');
insert into Tracking values(43, 1620, 17, 42, 'submitted for delivery','Germany','Berlin','Schulstrabe','2020-02-15');
insert into Tracking values(44, 1620, 17, 42, 'delivered','Germany','Frankfurt','Schulstrabe','2020-03-15');
insert into Tracking values(45, null, null, 42, 'received','Germany','Frankfurt','Schulstrabe','2020-03-16');
insert into Tracking values(46, null, null, 20, 'created','Russian','Moskva','Sovetskaya','2020-02-17');
insert into Tracking values(47, null, 2, 20, 'processed','Russian','Moskva','Sovetskaya','2020-02-18');
insert into Tracking values(48, 276, 12, 20, 'submitted for delivery','Russian','Moskva','Sovetskaya','2020-02-18');
insert into Tracking values(49, 276, 12, 20, 'delivered','Kazakhstan','Almaty','Abylai','2020-03-11');
insert into Tracking values(50, null, null, 20, 'received','Kazakhstan','Almaty','Abylai','2020-03-12');
insert into Tracking values(51, null, null, 22, 'created','China','Shankhai','Chzhao Denui','2020-02-19');
insert into Tracking values(52, null, 1, 22, 'processed','China','Shankhai','Chzhao Denui','2020-02-20');
insert into Tracking values(53, 477, 11, 22, 'submitted for delivery','China','Shankhai','Chzhao Denui','2020-02-20');
insert into Tracking values(54, 477, 11, 22, 'delivered','Kazakhstan','Almaty','Abylai','2020-03-15');
insert into Tracking values(55, null, null, 22, 'received','Kazakhstan','Almaty','Abylai','2020-03-16');
insert into Tracking values(56, null, null, 40, 'created','China','Guanchjou','Chzhan Czichjun','2020-03-02');
insert into Tracking values(57, null, 18, 40, 'processed','China','Guanchjou','Chzhan Czichjun','2020-03-02');
insert into Tracking values(58, 1721, 16, 40, 'submitted for delivery','China','Guanchjou','Chzhan Czichjun','2020-03-03');
insert into Tracking values(59, 1721, 16, 40, 'crash','China','Guanchjou','Chzhan Czichjun','2020-03-05');
insert into Tracking values(60, null, null, 40, 'in the warehouse','China','Guanchjou','Chzhan Czichjun','2020-03-06');
insert into Tracking values(61, null, null, 47, 'created','China','Guanchjou','Chzhan Czichjun','2020-03-02');
insert into Tracking values(62, null, 8, 47, 'processed','China','Guanchjou','Chzhan Czichjun','2020-03-02');
insert into Tracking values(63, 1721, 16, 47, 'submitted for delivery','China','Guanchjou','Chzhan Czichjun','2020-03-03');
insert into Tracking values(64, 1721, 16, 47, 'crash','China','Guanchjou','Chzhan Czichjun','2020-03-05');
insert into Tracking values(65, null, null, 47, 'in the warehouse','China','Guanchjou','Chzhan Czichjun','2020-03-06');
insert into Tracking values(66, null, null, 19, 'created','China','Guanchjou','Chzhan Czichjun','2020-03-01');
insert into Tracking values(67, null, 1, 19, 'processed','China','Guanchjou','Chzhan Czichjun','2020-03-02');
insert into Tracking values(68, 1721, 16, 19, 'submitted for delivery','China','Guanchjou','Chzhan Czichjun','2020-03-03');
insert into Tracking values(69, 1721, 16, 19, 'crash','China','Guanchjou','Chzhan Czichjun','2020-03-05');
insert into Tracking values(70, null, null, 19, 'in the warehouse','China','Guanchjou','Chzhan Czichjun','2020-03-06');
insert into Tracking values(71, null, null, 36, 'created','Kazakhstan','Karaganda','Shamshi','2021-11-04');
insert into Tracking values(72, null, 4, 36, 'processed','Kazakhstan','Karaganda','Shamshi','2021-11-04');
insert into Tracking values(73, 1413, 19, 36, 'submitted for delivery','Kazakhstan','Karaganda','Shamshi','2021-11-05');
insert into Tracking values(74, 1413, 19, 36, 'delivered','Germany','Gartenstrabe','Gartenstrabe','2021-11-28');
insert into Tracking values(75, null, null, 36, 'received','Germany','Gartenstrabe','Gartenstrabe','2021-11-29');
insert into Tracking values(76, null, null, 58, 'created','Russian','Kazan','Naberezhnaya','2021-11-08');
insert into Tracking values(77, null, 13, 58, 'processed','Russian','Kazan','Naberezhnaya','2021-11-09');
insert into Tracking values(78, 1481, 6, 58,' submitted for delivery','Russian','Kazan','Naberezhnaya','2021-11-10');
insert into Tracking values(79, 1481, 6, 58, 'delivered','Russian','Moskva','Shkolnaya','2021-12-10');
insert into Tracking values(80, null, null, 58, 'received','Russian','Moskva','Shkolnaya','2021-12-12');
insert into Tracking values(81, null, null, 23, 'created','China','Pekin','Chzhan Czichjun','2021-11-14');
insert into Tracking values(82, null, 10, 23, 'processed','China','Pekin','Chzhan Czichjun','2021-11-14');
insert into Tracking values(83, 1721, 10, 23, 'submitted for delivery','China','Pekin','Chzhan Czichjun','2021-11-15');
insert into Tracking values(84, 1721, 10, 23, 'delivered','China','Pekin','Chzhan Czichjun','2021-11-20');
insert into Tracking values(85, null, null, 23, 'received','China','Pekin','Chzhan Czichjun','2021-11-21');

-- TASK4
-- a)Find all customers who had a package on that truck at the time of the crash.
-- Find the last successful delivery by that truck prior to the crash.
with crash_date(value) as
    (select tracking.date_of_arrival from tracking, package, customer
    where tracking.tr_transport_id = 1721 and tracking.status = 'crash' and package.package_id = tracking.package_id
      and customer.customer_id = package.customer_id limit 1)
select tracking_id, tr_transport_id, package_id, status, date_of_arrival from tracking, crash_date
    where tr_transport_id = 1721 and status = 'delivered' and tracking.date_of_arrival < crash_date.value
        order by date_of_arrival desc limit 1;
-- b)Find the customer who has shipped the most packages in the past year.
select customer_id, count(package_id) as cnt
    from package where extract(year from package.delivery_start) = extract(year from now())-1
    group by customer_id
    order by cnt desc limit 1;
-- c)Find the customer who has spent the most money on shipping in the past year.
select customer_id, sum(price) as sum
    from package where extract(year from package.delivery_start) = extract(year from now())-1
    group by customer_id
    order by sum desc limit 1;
-- d)Find the street with the most customers
select count(customer_id) as cnt_customers, city, street from customer
    group by city, street
    order by cnt_customers desc limit 1;
-- e)Find those packages that were not delivered within the promised time
select package.package_id, package.delivery_end as planned_date,
       tracking.date_of_arrival as delivered_date from tracking, package
    where tracking.package_id = package.package_id and tracking.status = 'delivered' and tracking.date_of_arrival > package.delivery_end;
-- f)Generate the bill for each customer for the past month.
-- f)1)A simple bill: customer, address, and amount owed.
    select customer.first_name, customer.last_name, customer.city, customer.street, customer.home_number, sum(package.price) as amount
    from package, customer
        where extract(month from package.delivery_start) = extract(month from now())-1 and package.customer_id = customer.customer_id
    group by package.customer_id, customer.first_name, package.customer_id, customer.last_name,
             customer.home_number, package.customer_id, customer.city, customer.street;
-- f)2)A bill listing charges by type of service.
    select package.customer_id, customer.first_name, customer.last_name, sum(package.price) as amount,
           package.price - coalesce(Normal.price, 0) - coalesce(Hazardous_material.price, 0) - coalesce(international_shipment.price, 0) as price_m,
           count(package.package_id) as cnt, normal.price as price_of_normal,
           Hazardous_material.price as price_of_hazardous, international_shipment.price as price_of_international
        from package inner join customer on package.customer_id = customer.customer_id
            left join hazardous_material on package.package_id = Hazardous_material.package_id
            left join normal on package.package_id = normal.package_id
            left join international_shipment on package.package_id = international_shipment.package_id
        where extract(month from package.delivery_start) = extract(month from now())-1
        group by Package.customer_id, Customer.first_name, Customer.last_name, price_of_normal, price_of_hazardous, price_of_international, price_m;
-- f)3)An itemize billing listing each individual shipment and the charges for it.
    select package.customer_id, customer.first_name, customer.last_name, package.package_id, package.price,
           package.price - coalesce(Normal.price,0) - coalesce(Hazardous_material.price,0) - coalesce(international_shipment.price,0) as price_m,
           normal.price as price_of_normal, Hazardous_material.price as price_of_hazardous, international_shipment.price as price_of_international
        from package inner join customer on package.customer_id = customer.customer_id
            left join hazardous_material on package.package_id = Hazardous_material.package_id
            left join normal on package.package_id = normal.package_id
            left join international_shipment on package.package_id = international_shipment.package_id
        where extract(month from package.delivery_start) = extract(month from now())-1;