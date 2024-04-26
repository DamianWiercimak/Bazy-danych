CREATE DATABASE FIRMA;
USE FIRMA;
CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy(
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    adres VARCHAR(100),
    telefon VARCHAR(15)
);

CREATE TABLE ksiegowosc.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE,
    liczba_godzin INT,
    id_pracownika INT
);

CREATE TABLE ksiegowosc.pensja (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(100),
    kwota INT
);

CREATE TABLE ksiegowosc.premia (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota INT
);

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE,
    id_pracownika INT,
    id_godziny INT,
    id_pensji INT,
    id_premii INT
);

ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);


INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Aleksandra', 'Nowak', 'Kwiatowa 23, Gdańsk','882382148'),
(2, 'Piotr', 'Woźniak', 'Dębowa 11, Szczecin','515602476'),
(3, 'Natalia', 'Kowalczyk', 'Leśna 5, Katowice','537574949'),
(4, 'Kamil', 'Lis', 'Słoneczna 8, Kraków','695752120'),
(5, 'Aleksander', 'Mazurek', 'Żeromskiego 12, Łódź','796443574'),
(6, 'Magdalena', 'Kowalik', 'Mokra 17, Gdynia','882786363'),
(7, 'Marta', 'Zielińska', 'Łąkowa 31, Bytom','537441143'),
(8, 'Tomasz', 'Wójcik', 'Akacjowa 6, Lublin','729218236'),
(9, 'Karolina', 'Krawczyk', 'Brzozowa 9, Częstochowa','663960797'),
(10, 'Łukasz', 'Pawlak', 'Krótka 3, Białystok','671368445');


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
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


INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
(1, 'Senior Google Translate Expert', 5000),
(2, 'Social Media Influencer', 5500),
(3, 'EVENT Coordinator', 4000),
(4, 'PR Manager', 4800),
(5, 'Employer Branding Manager', 5800),
(6, 'Senior Motion Manager', 4200),
(7, 'Junior Video Editor', 3500),
(8, 'Senior Data Analyst', 4500),
(9, 'Junior Social Media Manager', 6000),
(10, 'Content Editor', 6500);


INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
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


INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2024-05-13', 1, 1, 1, 9),
(2, '2024-10-15', 6, 2, 10, 3),
(3, '2024-11-06', 2, 3, 6, 5),
(4, '2024-11-12', 7, 4, 4, 6),
(5, '2025-02-09', 3, 5, 2, 2),
(6, '2024-06-28', 8, 6, 8, 9),
(7, '2024-07-05', 4, 7, 7, 7),
(8, '2024-10-20', 9, 8, 3, 1),
(9, '2024-10-29', 5, 9, 9, 4),
(10, '2024-12-29', 10, 10, 5, 10);


ALTER TABLE ksiegowosc.godziny
ADD liczba_nadgodzin INT;


UPDATE ksiegowosc.godziny
SET liczba_nadgodzin = CASE
    WHEN (liczba_godzin * 20) > 160 THEN (liczba_godzin * 20) - 160
    ELSE 0
    END;

a)
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon VARCHAR(20);
UPDATE ksiegowosc.pracownicy
SET telefon = '(+48) ' + telefon;

b)

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 3) + '-' + SUBSTRING(telefon, 4, 3) + '-' + SUBSTRING(telefon, 7, 3)


c)

SELECT 
    ksiegowosc.pracownicy.id_pracownika, 
    UPPER(ksiegowosc.pracownicy.imie) AS IMIE, 
    UPPER(ksiegowosc.pracownicy.nazwisko) AS NAZWISKO, 
    UPPER(ksiegowosc.pracownicy.adres) AS ADRES, 
    ksiegowosc.pracownicy.telefon 
FROM
    ksiegowosc.pracownicy 
WHERE 
    LEN(ksiegowosc.pracownicy.nazwisko) = (
        SELECT MAX(LEN(ksiegowosc.pracownicy.nazwisko)) 
        FROM ksiegowosc.pracownicy
    );


d)

SELECT HASHBYTES('md5', CONCAT(ksiegowosc.pracownicy.id_pracownika, '_', ksiegowosc.pracownicy.imie, '_', ksiegowosc.pracownicy.nazwisko, '_', ksiegowosc.pracownicy.adres, '_', ksiegowosc.pracownicy.telefon, '_', ksiegowosc.pensja.kwota))
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji;


e)

SELECT 
    ksiegowosc.pracownicy.imie AS Imię, 
    ksiegowosc.pracownicy.nazwisko AS Nazwisko, 
    ksiegowosc.pensja.kwota AS Pensja, 
    ksiegowosc.premia.kwota AS Premia 
FROM 
    ksiegowosc.pracownicy 
LEFT JOIN 
    ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika 
LEFT JOIN 
    ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
LEFT JOIN 
    ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii;


f)

SELECT 
    CONCAT('Pracownik ', ksiegowosc.pracownicy.imie, ' ', ksiegowosc.pracownicy.nazwisko, ' w dniu ', ksiegowosc.godziny.data, ' otrzymał pensję całkowitą na kwotę ',
            (ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota + (ksiegowosc.godziny.liczba_nadgodzin * 50)), ' zł, gdzie wynagrodzenie zasadnicze wyniosło: ',
            ksiegowosc.pensja.kwota, ' zł, premia: ', ksiegowosc.premia.kwota, ' zł, nadgodziny: ', (ksiegowosc.godziny.liczba_nadgodzin * 50), ' zł')
FROM 
    ksiegowosc.pracownicy 
LEFT JOIN 
    ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika 
LEFT JOIN 
    ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
LEFT JOIN 
    ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii 
LEFT JOIN 
    ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika;

