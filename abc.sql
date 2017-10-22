#create database BazaW3;
use BazaW3;
select database();
create table users(
	id_u int primary key auto_increment, 
	name varchar(35) not null, 
	last varchar(40) default'anonim'
);

load data local infile  "C:/Users/Kasia/Desktop/users_data.txt" into table users;

#drop table users;

describe users;
/*insert into users (name, last) values ('Adam', 'Wisniewski');
insert into users (name) values ('Michal');
# insert into users (last) values ('Kowalski'); - błąd bo brak wartości domyślnej dla kolumny name
*/
select * from users;

update users
set last='Nowakowski'
where id_u=3;