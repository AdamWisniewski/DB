create database skoczkowie;
#drop database skoczkowie
use Skoczkowie;
SELECT DATABASE();
show tables;

CREATE TABLE skocznie (
    id_skoczni INTEGER,
    miasto VARCHAR(25),
    kraj_s VARCHAR(15),
    nazwa VARCHAR(35),
    k INT,
    sedz INT
);

#drop table skocznie;
/*alter table skocznie 	rename 
						change - zmiana nazwy kolumny + podanie rodzaju gromadzonych danych
                        modify - zmiana samego typu danych w kolumnie
                        add / drop
                        add primary key
describe tblname
insert into tblname values (dane, do, kolumn, po, przecinku)
load data local infile  "C:/Users/Kasia/Desktop/users_data.txt" into table users;
delete from tblname
delete from tblname where [warunek];
						
*/
CREATE TABLE trenerzy (
    kraj VARCHAR(25),
    imie_t VARCHAR(25),
    nazwisko_t VARCHAR(25),
    data_ur_t DATE
);

CREATE TABLE zawodnicy (
    id_skoczka INT,
    imie VARCHAR(25),
    nazwisko VARCHAR(25),
    kraj VARCHAR(25),
    data_ur DATE,
    wzorst INT,
    waga INT
);

CREATE TABLE zawody (
    id_zawodow INT,
    id_skoczni INT,
    data DATE
);

CREATE TABLE kibice (
    id_kibica INT,
    imie_k VARCHAR(25),
    nazwisko_k VARCHAR(25),
    data_ur_k DATE
);

describe kibice;

SELECT 
    *
FROM
    kibice;
SELECT 
    *
FROM
    zawodnicy;
SELECT 
    *
FROM
    skocznie;
describe skocznie;


# modyfikacje
alter table skocznie add primary key (id_skoczni);
alter table fani rename as kibice;
describe kibice;
alter table fani change imie_f imie_k varchar(35);
alter table fani change nazwisko_f nazwisko_k varchar(35);
alter table fani change data_ur_f data_ur_k date;
alter table fani modify nazwisko_f text;
alter table fani add id_skoczka int not null;
alter table fani drop id_skoczka;

SELECT 
    *
FROM
    skocznie;
SELECT 
    *
FROM
    trenerzy;
SELECT 
    *
FROM
    zawodnicy;
SELECT 
    *
FROM
    zawody;
SELECT 
    *
FROM
    kibice;
#wprowadzanie danych
alter table skocznie modify nazwa VARCHAR(35);
alter table kibice add kraj VARCHAR(35);
alter table kibice add wzrost int;

use skoczkowie;
SELECT 
    *
FROM
    kibice;
DELETE FROM kibice 
WHERE
    imie_k = 'John' AND nazwisko_k = 'Smith';
UPDATE kibice 
SET 
    data_ur_k = '1974-12-08'
WHERE
    nazwisko_k = 'Kowalski';
alter table kibice modify id_kibica int primary key auto_increment;
DELETE FROM kibice 
WHERE
    id_kibica = 1;

UPDATE kibice, trenerzy 
SET  imie_k = 'krzysztof'
WHERE kibice.kraj = trenerzy.kraj;
    select * from kibice;

alter table zawodnicy change wzorst wzrost int;    
update zawodnicy set wzrost=wzrost-2;
select * from zawodnicy;

select * from skocznie;
update skocznie set nazwa=substring(nazwa, 1, 15);

#zapytania

select *, wzrost + 5 as nowy_wzrost, id_skoczka from zawodnicy;
select imie, nazwisko, zawodnicy.kraj, imie_t, nazwisko_t from zawodnicy, trenerzy;

select 5+6; #możemy działać jak na kalkulatorze

select * from zawodnicy where (kraj = 'pol' or 'ger') and (wzrost<=170);

select distinct kraj from zawodnicy;

select kraj, imie, nazwisko, round(waga/pow(wzrost / 100, 2), 2) as BMI from zawodnicy;

select pi();

select imie, nazwisko, wzrost, wzrost between 160 and 170 as kolumna from zawodnicy; # jeśli spełniony jest warunek zwraca 1 jeśli nie to 0

select *, kraj is null as test from kibice;

select conv(10, 10, 2);

select round((rand() * 10) + 10) as losowo;
select * from zawodnicy where id_skoczka= round(17 * rand());

select curtime();
 
select year(now()), month(now()), minute(now());

select imie, nazwisko, date_format(data_ur, '%d.%m.%Y') as data  from zawodnicy;

select imie, nazwisko, dayname(data_ur) as dzien_tygodnia from zawodnicy;

select imie, nazwisko, quarter(data_ur) as kwartał from zawodnicy;

select *, datediff(current_date(), data_ur) as różnica_dni from zawodnicy; 

select *, year(now()) - year(date_add(data_ur, interval 10 year)) as history from zawodnicy; 

select *, concat(dayofyear(data_ur), ' dnia ', (year(data_ur)), ' roku.') as urodziny from zawodnicy;


select *, 
round(waga/pow(wzrost / 100, 2), 2) as BMI_2,
round(waga/pow(wzrost / 100, 2), 3) as BMI_3 
from zawodnicy;

select * from zawodnicy;

select concat(upper(substring(nazwisko, 1, 1)), lower(substring(nazwisko, 2))) as nowe_nazwisko from zawodnicy;

SELECT 
    imie,
    CONCAT(UPPER(SUBSTRING(nazwisko, 1, 1)),
	LOWER(SUBSTRING(nazwisko, 2, LENGTH(nazwisko) - 2)),
	UPPER(SUBSTRING(nazwisko, LENGTH(nazwisko)))) AS nowe_nazwisko 
    FROM zawodnicy;

select upper(concat_ws(';', imie, nazwisko, kraj)) from zawodnicy;

select *, lpad(dayofyear(data_ur), 3, 0) as format from zawodnicy;

select  insert('48 1010 1515 9999 0000',4, 4, '****');

select imie, nazwisko, replace(kraj, 'GER', 'POL') as podbicie from zawodnicy;

select imie, nazwisko, data_ur regexp '[1][9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]' as validacja from zawodnicy;

INSERT INTO zawodnicy VALUES (1, 'Klimek', 'Muranka', 'POL', '2000-12-03', 169, 60);

select imie, nazwisko, elt(quarter(data_ur), 'I', 'II', 'III', 'IV') as kwartal from zawodnicy;

select imie_t, nazwisko_t, data_ur_t is not null from trenerzy;

select *, elt((data_ur_t is not null) + 1,
	'jest znana',
    'nie jest znana') as data
    from trenerzy;
    
select *, year(now()) - year(data_ur_t) as wiek from trenerzy;




# ----------------------------------- mySQL dzień drugi ------------------------------------------------------------------------------------------------

select CONCAT(UPPER(SUBSTRING(imie, 1, 1)),
	LOWER(SUBSTRING(imie, 2, LENGTH(imie))), ' ',
	UPPER(SUBSTRING(nazwisko, 1, 1)), 
    LOWER(SUBSTRING(nazwisko, 2, LENGTH(nazwisko))), ' (', kraj, ')')  AS etykieta 
    FROM zawodnicy;

SELECT 
    kraj,
    imie,
    nazwisko,
    ROUND(waga / POW(wzrost / 100, 2), 1) AS BMI,
    ELT((waga / POW(wzrost / 100, 2) > 20) + 1,
            'za mało',
            'ok') AS test
FROM
    zawodnicy
WHERE
    (waga / POW(wzrost / 100, 2) > 20);

# ------------------------------wyrażenia warunkowe ------------------------------

SELECT 
    kraj,
    imie,
    nazwisko,
    ROUND(waga / POW(wzrost / 100, 2), 1) AS BMI,
    CASE
        WHEN (waga / POW(wzrost / 100, 2)) > 20 THEN 'za duże'
        WHEN (waga / POW(wzrost / 100, 2)) > 18 AND (waga / POW(wzrost / 100, 2)) <= 20 THEN 'ok'
        WHEN (waga / POW(wzrost / 100, 2)) <= 18 THEN 'za mało'
    END AS test
FROM
    zawodnicy;

select *, coalesce(data_ur_t, 'brak_danych') as nowa_data  from trenerzy;


SELECT 
    imie_t,
    nazwisko_t,
    COALESCE(YEAR(NOW()) - YEAR(data_ur_t),
            (SELECT 
                    ROUND(AVG(YEAR(NOW()) - YEAR(data_ur_t)))
                FROM
                    trenerzy)) AS wiek
FROM
    trenerzy;
    
SELECT 
    imie, nazwisko, data_ur
FROM
    zawodnicy
WHERE
    kraj != 'pol'
ORDER BY data_ur DESC
LIMIT 4;

SELECT 
    id_skoczka, imie, nazwisko, wzrost, data_ur
FROM
    zawodnicy
ORDER BY wzrost DESC, nazwisko DESC;

SELECT 
    id_skoczka, imie, nazwisko, wzrost, data_ur
FROM
    zawodnicy
ORDER BY wzrost DESC, nazwisko DESC
LIMIT 1;

# drugi najgrubszy
SELECT 
    *
FROM
    zawodnicy
ORDER BY waga DESC
LIMIT 1 OFFSET 1;

/*wyświetlamy wszystkich z największą wagą 
(jeżeli jestkilku to wyświetli nam kilku z najwyższą tą samoą wartością
*/
SELECT 
    *
FROM
    zawodnicy
WHERE
    waga = (SELECT 
            waga # musi być wynik w postaci jednej komórki bo inaczej program by nie rozmoznał
        FROM
            zawodnicy
        ORDER BY waga DESC
        LIMIT 1 OFFSET 1)
order by nazwisko desc;

# niemcy i austriacy posortowani krajami
SELECT 
    *
FROM
    zawodnicy
WHERE
    kraj IN ('ger' , 'aut')
ORDER BY kraj ASC, nazwisko ASC;

select * from trenerzy where data_ur_t is null;