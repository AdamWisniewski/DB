create database skoczkowie;
use skoczkowie;
select database();
show tables;
DROP DATABASE;
describe trenerzy;
alter table kibice rename as fani;
alter table fani rename as kibice;
CREATE TABLE test (
    id INT,
    imie VARCHAR(35),
    nazwisko VARCHAR(35)
);
SELECT 
    *
FROM
    test;
drop table test;
alter table kibice
add test int;
select * from kibice;
alter table kibice
drop test;
insert into kibice values (4, 'Adam', 'Nowak', 0, 'POL', 176); 
update kibice set data_ur_k = '1986-12-27' where imie_k = 'Adam';

delete from kibice where id_kibica = 4;

update kibice, trenerzy set data_ur_k = '2000-01-08' where kibice.kraj=trenerzy.kraj;
update zawodnicy set wzrost = wzrost - 2; 
select * from zawodnicy;
select *, wzrost * 1.46 as narty from zawodnicy;
select imie, nazwisko, date_format(data_ur, '%d.%m.%Y') from zawodnicy;
select *, concat(dayofyear(data_ur), ' dnia ', year(data_ur), ' roku.') from zawodnicy;
select imie, nazwisko, round(waga / power(wzrost /100, 2)) as BMI, elt(round((waga / power(wzrost /100, 2)) > 20) + 1, 'złe', 'właściwe')  from zawodnicy;
