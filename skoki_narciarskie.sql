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

SELECT 
    *
FROM
    trenerzy
WHERE
    data_ur_t IS NULL;
    
  # zawodnicy urodzeni między marcem a listopadem  
SELECT 
    *
FROM
    zawodnicy
WHERE
    MONTH(data_ur) BETWEEN 3 AND 11
ORDER BY nazwisko;    

SELECT 
    *
FROM
    trenerzy
ORDER BY data_ur_t IS NULL DESC , data_ur_t DESC;
    
SELECT 
    kraj,
    imie,
    nazwisko,
    ROUND(waga / POW(wzrost / 100, 2), 1) AS BMI,
    CASE
        WHEN (waga / POW(wzrost / 100, 2)) > 20 THEN 'za duże'
        WHEN
            (waga / POW(wzrost / 100, 2)) > 18
                AND (waga / POW(wzrost / 100, 2)) <= 20
        THEN
            'ok'
        WHEN (waga / POW(wzrost / 100, 2)) <= 18 THEN 'za mało'
    END AS test
FROM
    zawodnicy
ORDER BY  BMI ASC, 2 asc;

# lista w kolejności losowej
SELECT 
    kraj,
    imie,
    nazwisko
FROM
    zawodnicy
ORDER BY  rand();

#łączenie dwóch tabel zawodników i trenerów
SELECT 
    imie, nazwisko, kraj
FROM
    zawodnicy 
UNION SELECT 
    imie_t, nazwisko_t, kraj
FROM
    trenerzy;
    
# łączenie dwóch tabel gdzie jedna jest niepełna (ważna kolejność kolumn w obydwu tabelach
# by nie łączyły się tabele o różnych wartościach
# a następnie sortowanie po kraju
SELECT 
    imie, nazwisko, kraj, data_ur, waga, wzrost, 'zawodnik' as rola
FROM
    zawodnicy 
UNION 
SELECT 
    imie_t, nazwisko_t, kraj, data_ur_t, null, null, 'trener' as rola
FROM
    trenerzy
ORDER BY  kraj, rola, nazwisko;

#--------łączenie tabel - joiny-------------------------------------------------

select z.*, t.* from zawodnicy as z natural left join trenerzy as t
union
select z.*, t.* from zawodnicy as z natural right join trenerzy as t
order by 4;



SELECT 
    z.imie, z.nazwisko, z.kraj, t.imie_t, t.nazwisko_t
FROM
    zawodnicy AS z
        LEFT JOIN
    trenerzy AS t ON z.kraj = t.kraj 
UNION SELECT 
    z.imie, z.nazwisko, z.kraj, t.imie_t, t.nazwisko_t
FROM
    zawodnicy AS z
        RIGHT JOIN
    trenerzy AS t ON z.kraj = t.kraj
ORDER BY 3;

# złączenie trzech tabel
SELECT 
    z.imie,
    z.nazwisko,
    t.imie_t,
    t.nazwisko_t,
    k.imie_k,
    k.nazwisko_k
FROM
    zawodnicy AS z
        LEFT JOIN
    trenerzy AS t ON (z.kraj = t.kraj)
        LEFT JOIN
    kibice AS k ON (z.kraj = k.kraj);
   
#-----------------zadanie-----------------------------------------------
    select * from skocznie;
    select * from zawody;

SELECT 
    z.data, s.miasto, s.kraj_s, s.nazwa, s.k
FROM
    zawody AS z
        LEFT JOIN
    skocznie AS s ON z.id_skoczni = s.id_skoczni
ORDER BY z.data;

# zadanie
SELECT 
    z.*, t.*
FROM
    zawodnicy AS z
        NATURAL right JOIN
    trenerzy AS t
WHERE
    z.kraj IS NULL;
 
 #-----------zadanie-------------
 /* wyświetla zawodników z krajów w których były zawody */
SELECT 
    zaw.imie,
    zaw.nazwisko,
    z.data,
    s.miasto,
    s.kraj_s,
    s.nazwa
FROM
    zawody as z 
        LEFT JOIN
    skocznie as s on s.id_skoczni = z.id_skoczni
        right JOIN
    zawodnicy as zaw on zaw.kraj = s.kraj_s;
 
 #------------zadanie------------ wyświetla zawodników którzy są starsi od swoich ternerów
 SELECT 
    zawodnicy.*, trenerzy.*
FROM
    zawodnicy
         LEFT JOIN
    trenerzy ON zawodnicy.kraj = trenerzy.kraj
WHERE
    zawodnicy.data_ur > trenerzy.data_ur_t; 

 #------------zadanie------------ 
 /*wyświetla parę zawodników jednego kraju gdzie drugi jest wyższy niż pierwszy */
 SELECT 
    z1.*, z2.*
FROM
    zawodnicy as z1
		JOIN
    zawodnicy as z2 ON z1.kraj = z2.kraj
WHERE
    z1.wzrost > z2.wzrost;
    
#----------zadanie----- maksymalny wzrost w każdej z reprezentacji

SELECT 
    kraj, MAX(wzrost)
FROM
    zawodnicy
GROUP BY kraj
ORDER BY kraj;

#----------zadanie----- średnia waga w każdej z reprezentacji

SELECT 
    kraj, ROUND(AVG(waga), 2)
FROM
    zawodnicy
GROUP BY kraj
ORDER BY kraj;

#----------zadanie----- liczba reprezentantów danego kraju

SELECT 
    kraj, COUNT(kraj) AS liczba
FROM
    zawodnicy
GROUP BY kraj
ORDER BY liczba DESC;

#----------zadanie----- liczba reprezentantów danego kraju których jest więcej niż dwóch

SELECT 
    kraj, COUNT(kraj) AS liczba
FROM
    zawodnicy
GROUP BY kraj
HAVING liczba > 2
ORDER BY liczba DESC;

#----------zadanie----- liczba wszystkich zawodników
SELECT 
	COUNT(nazwisko) AS liczba
FROM
    zawodnicy;
    
#----------zadanie-----  liczba zawodników wyższych od Adama Małysza
SELECT 
	COUNT(*) AS liczba
FROM
    zawodnicy
    where wzrost > (select wzrost from zawodnicy where nazwisko = 'Małysz');
    
#----------zadanie-----  liczba zawodników wyższych niż 180 w wszystkich dróżynach
SELECT 
    kraj, COUNT(*) AS liczba
FROM
    zawodnicy
WHERE
    wzrost >= 180
GROUP BY kraj
ORDER BY liczba DESC, kraj;

#----------zadanie-----  liczba zawodników urodzonych w poszczególnych kwartałach w poszcz. latach
SELECT 
    YEAR(data_ur) AS rok,
    ELT(QUARTER(data_ur), 'I', 'II', 'III', 'IV') AS kwartal,
    COUNT(*) AS liczba
FROM
    zawodnicy
GROUP BY rok , kwartal
ORDER BY rok ASC , kwartal ASC;

#----------zadanie----- średnia liczba reprezentantów danego kraju 

SELECT count(*) / count(distinct kraj) as avg from zawodnicy; 

#------ kraje których liczebność jest większa niż średnia-----------

SELECT 
    kraj, COUNT(*) AS num
FROM
    zawodnicy
GROUP BY kraj
HAVING
    num > (SELECT 
            COUNT(*) / COUNT(DISTINCT kraj) AS avg
        FROM
            zawodnicy);
            
#------ lista ekip z liczbą zawodników powyżej 180 wzrostu ale bez ekip gdzie jest mniej niż 2 zawodników-----------

SELECT 
    kraj, COUNT(*) AS num
FROM
    zawodnicy
WHERE
    wzrost > 180
GROUP BY kraj
HAVING num >= 2;

#-------ms76 - tylko te ekipy gdzie średnia wzrostu jest powyżej 180 wzrostu
SELECT 
    kraj, AVG(wzrost) AS avg
FROM
    zawodnicy
GROUP BY kraj
HAVING avg > 180;

#-----
/*
select year(now()) - year(data_ur) as wiek_z, kraj from zawodnicy
union
select  year(now()) - year(data_ur_t) as wiek_t, kraj from trenerzy
;
*/

# DZIEŃ 3 SQL -----------------------------------------------

# znajdz zadodników wyższych od Małysza

SELECT 
    imie, nazwisko, wzrost
FROM
    zawodnicy
WHERE
    wzrost > (SELECT 
            wzrost
        FROM
            zawodnicy
        WHERE
            nazwisko = 'Małysz');
#-------
SELECT 
    imie, nazwisko, waga
FROM
    zawodnicy
WHERE
    waga > (SELECT 
            waga
        FROM
            zawodnicy
        WHERE
            nazwisko = 'Małysz');

# zawodnicy wyżsi niż najcięższy

SELECT 
    imie, nazwisko, waga, wzrost
FROM
    zawodnicy
WHERE
    wzrost > (SELECT 
            wzrost
        FROM
            zawodnicy
        ORDER BY waga desc
        LIMIT 1);

# zawodnicy niżsi niż najcięższy

SELECT 
    imie, nazwisko, waga, wzrost
FROM
    zawodnicy
WHERE
    wzrost < (SELECT 
            wzrost
        FROM
            zawodnicy
        ORDER BY waga desc
        LIMIT 1);
 
 # podzapytania zawsze muszą być w nawiasach
 
 # znajdz zawodnikow starszych niz heinz kuttin
 
 SELECT 
    imie, nazwisko
FROM
    zawodnicy
WHERE
    data_ur > (SELECT 
            data_ur_t
        FROM
            trenerzy
        WHERE
            nazwisko = 'Kuttin');
            
# zawodnicy o wzroscie takim samym jak janne ahonen

SELECT 
    *
FROM
    zawodnicy
WHERE
    wzrost = (SELECT 
            wzrost
        FROM
            zawodnicy
        WHERE
            nazwisko = 'Ahonen')
        AND nazwisko != 'Ahonen';
        
# imie nazwisko najwyzszego zawodnika

SELECT 
    imie, nazwisko, wzrost
FROM
    zawodnicy
WHERE
    wzrost = (SELECT 
            MAX(wzrost)
        FROM
            zawodnicy);

# zawodnicy ciezsi niz średnia wsrod wszystkich

SELECT 
    imie, nazwisko, waga
FROM
    zawodnicy
WHERE
    waga > (SELECT 
            AVG(waga)
        FROM
            zawodnicy);
 
# zawodnicy ciezsi niz przecietny zawodnik z polski

SELECT 
    imie, nazwisko, waga
FROM
    zawodnicy
WHERE
    waga > (SELECT 
            AVG(waga)
        FROM
            zawodnicy
		WHERE kraj = 'POL');

# wypisz zawodnikow ciezszych niz srednia w danej ekipie
 
 SELECT 
    *
FROM
    zawodnicy AS a
WHERE
    waga > (SELECT 
            AVG(waga)
        FROM
            zawodnicy AS b
        WHERE
            a.kraj = b.kraj);
            
# cwiczenie 86

SELECT 
    kraj, sum(wzrost > 180) AS sum
FROM
    zawodnicy
GROUP BY kraj;

#zawodnicy ktorych wzrost jest wyzszy niz 180 
# i rok urodzenia jest pomiedzy 1980 i 1990, z zapytaniem zagniezdzonym

SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        zawodnicy
    WHERE
        YEAR(data_ur) BETWEEN 1980 AND 1990) AS a1
WHERE
    wzrost > 180;


SELECT 
    AVG(x) AS srednia
FROM
    (SELECT 
        MAX(wzrost) AS x
    FROM
        zawodnicy
    GROUP BY kraj) AS table;
 
 # wypisz srednia stonowiaca sume wzrostu i wagi wszystkich zawodnikow
 
 SELECT 
    AVG(suma) AS srednia
FROM
    (SELECT 
        waga + wzrost AS suma
    FROM
        zawodnicy) AS tabela;
        
# srednia waga z najlzejszych zawodikow kazdego kraju

 SELECT 
    AVG(x) AS srednia
FROM
    (SELECT 
        min(waga) AS x
    FROM
        zawodnicy
    GROUP BY kraj) AS tabela;
        
# podzapytania skorelowane -----------------------

# wypisz zawodnikow ktorzy maja to samo imie co trenerzy

SELECT 
    *
FROM
    zawodnicy
WHERE
    EXISTS (SELECT 
            *
        FROM
            trenerzy
        WHERE
            zawodnicy.imie = trenerzy.imie_t);
 
 #prostrze rozwiązanie bez zagnieżdżania selecta
select z.imie, z.nazwisko from zawodnicy z, trenerzy t where z.imie = t.imie_t;

# zawodnicy ktorych kraj pochodzenia nie istnieje w tabeli skocznie

SELECT 
    *
FROM
    zawodnicy
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            skocznie
        WHERE
            kraj_s = kraj);

#wypisz duplikaty zawodników których data urodzenia jest taka sama

select count(data_ur) as liczba from zawodnicy group by data_ur;

select * from zawodnicy as z1 where exists (select * from zawodnicy as z2 where z1.data_ur = z2.data_ur and z1.id_skoczka != z2.id_skoczka);

#wypisz duplikaty zawodnikow ktorych waga jest taka sama

SELECT 
    *
FROM
    zawodnicy AS z1
WHERE
    EXISTS( SELECT 
            *
        FROM
            zawodnicy AS z2
        WHERE
            z1.waga = z2.waga
                AND z1.id_skoczka != z2.id_skoczka);	

# zawodnicy wraz z dodatkowa informacja o ilosci zawodnikow

select imie, nazwisko, (select count(*) from zawodnicy) as suma from zawodnicy;

#------------------widoki-----------------------------------------------------------------------------
drop database firma;
create database firma;
use firma;
create table uzytkownicy (
ID  integer PRIMARY KEY auto_increment,
imie varchar(45),
nazwisko varchar(45));

create table systemy (
ID  integer PRIMARY KEY auto_increment,
nazwa varchar(45),
liczbaprogramow int);

create table uprawnienia (
ID integer PRIMARY KEY auto_increment,
ID_uzytkownicy int,
ID_systemy int);

create table programy (
ID integer PRIMARY KEY auto_increment,
ID_systemy int,
nazwa varchar(45));

show tables;

insert into uzytkownicy values (1, 'Tomasz', 'Tomaszewski');
insert into uzytkownicy values (default, 'Anna', 'Kowalska');
insert into uzytkownicy values (default, 'Michał', 'Jabłoński');
insert into uzytkownicy values (default, 'Kamila', 'Nowak');

insert into systemy values (default, 'Windows', 2);
insert into systemy values (default, 'Linux', 0);
insert into systemy values (default, 'MacOS', 0);

insert into uprawnienia values (default, 1, 1);
insert into uprawnienia values (default, 1, 3);
insert into uprawnienia values (default, 2, 2);
insert into uprawnienia values (default, 3, 1);
insert into uprawnienia values (default, 3, 2);
insert into uprawnienia values (default, 3, 3);

insert into programy values (default, 1, 'Word');
insert into programy values (default, 1, 'Exel');


create view V_uzytkownicy as select * from uzytkownicy;

select * from V_uzytkownicy;

#ms 08
CREATE VIEW v2 AS
    SELECT 
        imie, nazwisko
    FROM
        uzytkownicy
            NATURAL LEFT JOIN
        uprawnienia;

SELECT 
    imie, nazwisko, COUNT(nazwisko)
FROM
    uzytkownicy AS u
        LEFT JOIN
    uprawnienia AS up ON u.ID = up.ID_uzytkownicy
GROUP BY nazwisko;

alter view v2 as select u.imie, u.nazwisko, count(nazwisko) from uzytkownicy as u inner join uprawnienia as up on u.ID=up.ID_uzytkownicy group by up.ID_uzytkownicy;

select * from v2;

# widok z uzytkownikami ktirzy posiadaja wiecej niz 2 uprawnienia
CREATE VIEW v3 AS
    SELECT 
        *
    FROM
        uzytkownicy u
    WHERE
        (SELECT 
                COUNT(*)
            FROM
                uprawnienia up
            WHERE
                up.ID_uzytkownicy = u.ID) >= 2;

select * from v3;

# widok ktory wypisze systemy zawerajace litre o wraz z przypisanymi do niego programamai. 
# jezeli system nie bedzie posiadal przypisanego porgamu to rowniez ma zostac wypisany

SELECT 
    s.nazwa, p.nazwa
FROM
    systemy AS s
        LEFT JOIN
    programy p ON s.ID = p.ID_systemy
WHERE
    s.nazwa LIKE '%o%';
 
# wyzwalacze / triggery ------------------------------------ 
 drop trigger if exists AfterInsert;
 create trigger BeforeInsert after insert on uzytkownicy for each row insert into uprawnienia (ID_uzytkownicy, ID_systemy) values (new.ID, 1);
 
 insert into uzytkownicy value (default, 'Adam', 'Wiśniewski');
 
 select * from uzytkownicy;
 
# wyzwalacz który przed dodaniem nazwy zmieni ja na wielie litery

drop trigger if exists duze_litery;
create trigger duze_litery before insert on systemy for each row set new.nazwa = upper(new.nazwa);

insert into systemy value (default, 'dos', 0);

select * from systemy;
drop trigger if exists dodawanie;
insert into systemy value (default, 'dos', 2);


#delimiter $$
create trigger dodawanie before insert on systemy for each row if (exists(select * from systemy where nazwa=new.nazwa) = true) then set new.nazwa = concat(new.nazwa, '_copy'); end if;

select * from systemy;

# trigger ktory po usunieciu uzytkownika usunie tez jego uprawnienia

create trigger usuwanie after delete on uzytkownicy for each row delete from uprawnienia where ID_uzytkownicy=old.ID;