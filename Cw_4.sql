CREATE DATABASE Firma;
USE Firma;
create schema rozliczenia;

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    adres VARCHAR(100),
    telefon VARCHAR(15)
);

CREATE TABLE rozliczenia.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE,
    liczba_godzin DECIMAL(5, 2),
    id_pracownika INT
);

CREATE TABLE rozliczenia.pensje (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50),
    kwota DECIMAL(10, 2),
    id_premii INT
);

CREATE TABLE rozliczenia.premie (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota DECIMAL(10, 2)
);

alter table rozliczenia.godziny add FOREIGN key (id_pracownika) references rozliczenia.pracownicy(id_pracownika);
alter table rozliczenia.pensje add FOREIGN key (id_premii) references rozliczenia.premie(id_premii);

insert into rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
values
(1, 'Aleksandra', 'Nowak', 'Kwiatowa 23, Gdańsk','88 238 21 48'),
(2, 'Piotr', 'Woźniak', 'Dębowa 11, Szczecin','51 560 24 76'),
(3, 'Natalia', 'Kowalczyk', 'Leśna 5, Katowice','53 757 49 49'),
(4, 'Kamil', 'Lis', 'Słoneczna 8, Kraków','69 575 21 20'),
(5, 'Aleksander', 'Mazurek', 'Żeromskiego 12, Łódź','79 644 35 74'),
(6, 'Magdalena', 'Kowalik', 'Mokra 17, Gdynia','88 278 63 63'),
(7, 'Marta', 'Zielińska', 'Łąkowa 31, Bytom','53 744 11 43'),
(8, 'Tomasz', 'Wójcik', 'Akacjowa 6, Lublin','72 921 82 36'),
(9, 'Karolina', 'Krawczyk', 'Brzozowa 9, Częstochowa','66 396 07 97'),
(10, 'Łukasz', 'Pawlak', 'Krótka 3, Białystok','67 136 84 45');


insert into rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
values
(1, '2024-05-13', 86, 1),
(2, '2024-10-15', 156, 6),
(3, '2024-11-06', 184, 2),
(4, '2024-11-12', 97, 7),
(5, '2025-02-09', 153, 3),
(6, '2024-06-28', 188, 8),
(7, '2024-07-05', 120, 4),
(8, '2024-10-20', 198, 9),
(9, '2024-10-29', 89, 5),
(10, '2024-12-29', 99, 10);

insert into rozliczenia.premie (id_premii, rodzaj, kwota)
values
(1, 'frekfencja', 200),	
(2, 'uznaniowa', 400),
(3, 'regulaminowa', 500),
(4, 'regulaminowa', 200),
(5, 'uznaniowa', 100),
(6, 'frekfencja', 500),
(7, 'frekfencja', 150),
(8, 'regulaminowa', 300),
(9, 'uznaniowa', 400),
(10, 'frekfencja', 350); 

insert into rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
values
(1, 'Senior Google Translate Expert', 5000, 9),
(2, 'Social Media Influencer', 5500, 3),
(3, 'EVENT Coordinator', 4000, 7),
(4, 'PR Manager', 4800, 2),
(5, 'Employer Branding Manager', 5800, 1),
(6, 'Senior Motion Manager', 4200, 3),
(7, 'Junior Video Editor', 3500, 6),
(8, 'Senior Data Analyst', 4500, 8),
(9, 'Junior Social Media Manager', 6000, 5),
(10, 'Content Editor', 6500, 10);

select nazwisko, adres from rozliczenia.pracownicy;

select datepart(WeekDay, data) as dzien, datepart(Month, data) as miesiąc from rozliczenia.godziny; 


EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje ADD kwota_netto DECIMAL(10, 2);


update rozliczenia.pensje set kwota_netto = kwota_brutto*0.73;

select * from rozliczenia.pensje;
select * from rozliczenia.godziny;
select * from rozliczenia.pracownicy;
select * from rozliczenia.premie;

