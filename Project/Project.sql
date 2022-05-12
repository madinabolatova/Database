create database Project;

create table client_info(
    client_id integer primary key not null ,
    firstname varchar(30) not null ,
    lastname varchar(30) not null,
    date_of_birth date not null,
    occupation varchar(30) not null,
    phone_number varchar(10) not null,
    email_address varchar(100) not null,
    address varchar not null,
    foreign key (date_of_birth) references age_info(date_of_birth)
);
create table age_info(
    date_of_birth date primary key not null,
    age integer check (age >= 16)
);
create table account_info(
    account_id varchar(25) primary key not null,
    type_of_account varchar(15) check (type_of_account = 'company' or type_of_account = 'customer'),
    type_of_payment varchar(15) check (type_of_payment = 'regular' or type_of_payment = 'subsciption'),
    password varchar(25) check (length(password) >= 8) not null,
    total_num_of_services integer not null,
    total_price integer check (total_price >= 0)
);
create table account_create(
    account_login varchar(25) primary key not null,
    client_id integer not null,
    foreign key (client_id) references client_info(client_id),
    foreign key (account_login) references account_info(account_id)
);
create table payment_info(
    credit_card_number varchar primary key not null check (length(credit_card_number) = 16),
    expiration_date date not null,
    CVV integer not null,
    name_of_bank varchar(10) not null,
);
create table payment_create(
    credit_card_number varchar primary key not null check (length(credit_card_number) = 16),
    account_login varchar(25) not null,
    foreign key (account_login) references account_info(account_id),
    foreign key (credit_card_number) references payment_info(credit_card_number)
);
create table subscription_info(
    financial_statement integer primary key not null,
    monthly_charges integer not null check (monthly_charges > 0),
    paid_money integer not null check (paid_money >= 0),
    dept integer not null check (dept >= 0)
);
create table subscription_create(
    financial_statement integer primary key not null,
    account_id varchar(25) not null,
    foreign key (account_id) references account_info(account_id),
    foreign key (financial_statement) references subscription_info(financial_statement)
);
create table order_info(
    order_id integer primary key not null,
    name varchar(30) not null,
    data_of_formation date not null,
    predicted_day_of_come date not null,
    departure_address varchar not null,
    arrival_address varchar not null,
    timeliness_of_delivery integer not null,
    payment_status varchar not null check (payment_status = 'paid' or payment_status = 'not pais=d'),
    return boolean not null check ((return = 'true' and payment_status = 'paid') or return = 'false'),
    delivery_charges integer not null check (delivery_charges > 0),
    foreign key (name) references product_info(name)
);
create table order_create(
    order_id integer primary key not null,
    account_id varchar(25) not null,
    foreign key (order_id) references order_info(order_id),
    foreign key (account_id) references account_info(account_id)
);
create table product_info(
    name varchar(30) primary key not null,
    description varchar(100) not null,
    price integer not null check (price > 0),
    company_name varchar(25) not null,
    foreign key (company_name) references account_info(account_id)
);
create table transport_info(
    transport_number varchar(10) primary key not null,
    transport_type varchar(25) not null,
    delivery_number varchar(10) not null unique check (length(delivery_number) = 10),
    foreign key (delivery_number) references delivery_info(delivery_number)
);
create table transport_create(
    order_id integer primary key not null,
    transport_number varchar(10) not null unique,
    foreign key (transport_number) references transport_info(transport_number),
    foreign key (order_id) references order_info(order_id)
);
create table delivery_info(
    delivery_number varchar(10) primary key not null,
    delivery_last_name varchar(30) not null,
    delivery_first_name varchar(30) not null
);
create table track_info(
    status_id varchar(30) primary key not null,
    status_description varchar(100) not null,
    country varchar(30) not null,
    city varchar(30) not null,
    location_address varchar not null,
    current_date date not null,
    starting_date date not null,
    ending_date date not null,
    period_on_way integer not null check (period_on_way >= 0)
);
create table track_create(
    status_id varchar(30) primary key not null,
    order_id integer not null,
    foreign key (order_id) references order_info(order_id),
    foreign key (status_id) references track_info(status_id)
);
create table fill_create(
    status_id varchar(30) primary key not null,
    transport_number varchar(10) not null,
    foreign key (transport_number) references transport_info(transport_number),
    foreign key (status_id) references track_info(status_id)
);
create table declaration_info(
    declaration_id integer primary key not null,
    type_of_package varchar not null,
    type_of_delivery varchar not null check (type_of_delivery = 'local' or type_of_delivery = 'international'),
    delivery_feature varchar,
    mass_of_package integer not null check (mass_of_package > 0),
    total_cost integer not null check (total_cost > 0),
    date_of_formation date not null,
    actual_arrival_day date not null,
    days_on_way integer not null check (days_on_way > 0),
    final_delivery_status varchar not null check (final_delivery_status = 'successfully' or
                                                  final_delivery_status = 'failed')
);
create table declaration_create(
    order_id integer primary key not null,
    declaration_id integer not null,
    foreign key (order_id) references order_info(order_id),
    foreign key (declaration_id) references declaration_info(declaration_id)
);
create table rep(
    declaration_id integer primary key not null,
    account_id varchar(25) not null,
    foreign key (account_id) references account_info(account_id),
    foreign key (declaration_id) references declaration_info(declaration_id)
);

insert into age_info values('1979-06-04', 42);
insert into age_info values('1983-11-17', 38);
insert into age_info values('2002-11-25', 19);
insert into age_info values('2005-05-23', 16);

insert into client_info values()



















