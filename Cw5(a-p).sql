CREATE DATABASE NOWA_FIRMA;
USE NOWA_FIRMA;
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
(1, 'Aleksandra', 'Nowak', 'Kwiatowa 23, Gdańsk','882 382 148'),
(2, 'Piotr', 'Woźniak', 'Dębowa 11, Szczecin','515 602 476'),
(3, 'Natalia', 'Kowalczyk', 'Leśna 5, Katowice','537 574 949'),
(4, 'Kamil', 'Lis', 'Słoneczna 8, Kraków','695 752 120'),
(5, 'Aleksander', 'Mazurek', 'Żeromskiego 12, Łódź','796 443 574'),
(6, 'Magdalena', 'Kowalik', 'Mokra 17, Gdynia','882 786 363'),
(7, 'Marta', 'Zielińska', 'Łąkowa 31, Bytom','537 441 143'),
(8, 'Tomasz', 'Wójcik', 'Akacjowa 6, Lublin','729 218 236'),
(9, 'Karolina', 'Krawczyk', 'Brzozowa 9, Częstochowa','663 960 797'),
(10, 'Łukasz', 'Pawlak', 'Krótka 3, Białystok','671 368 445');


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

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy


SELECT id_pracownika
FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (
    SELECT id_pracownika
    FROM ksiegowosc.wynagrodzenie
    WHERE id_pensji IN (
        SELECT id_pensji
        FROM ksiegowosc.pensja
        WHERE kwota > 1000
    )
);



SELECT id_pracownika
FROM ksiegowosc.pracownicy
WHERE id_pracownika NOT IN (
    SELECT id_pracownika
    FROM ksiegowosc.wynagrodzenie
    WHERE id_premii IS NOT NULL
)
AND id_pracownika IN (
    SELECT id_pracownika
    FROM ksiegowosc.wynagrodzenie
    JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
    WHERE pensja.kwota > 2000
);


SELECT *
FROM ksiegowosc.pracownicy
WHERE LEFT(imie, 1) = 'M';


SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';


SELECT 
    imie, 
    nazwisko, 
    SUM(liczba_godzin - 160) AS nadgodziny
FROM 
    ksiegowosc.pracownicy
JOIN 
    ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
GROUP BY 
    imie, nazwisko;
   
   
   SELECT 
    pracownicy.imie, 
    pracownicy.nazwisko
FROM 
    ksiegowosc.pracownicy
JOIN 
    ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN 
    ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE 
    pensja.kwota BETWEEN 1500 AND 3000;
   
   
   SELECT 
    pracownicy.imie, 
    pracownicy.nazwisko
FROM 
    ksiegowosc.pracownicy
JOIN 
    ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN 
    ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika
LEFT JOIN 
    ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE 
    godziny.liczba_godzin > 160 
    AND premia.id_premii IS NULL;
   
   
   SELECT 
    pracownicy.imie, 
    pracownicy.nazwisko,
    pensja.kwota
FROM 
    ksiegowosc.pracownicy
JOIN 
    ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN 
    ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
ORDER BY 
    pensja.kwota;
   
   
   SELECT 
    pracownicy.imie, 
    pracownicy.nazwisko,
    pensja.kwota AS pensja,
    premia.kwota AS premia
FROM 
    ksiegowosc.pracownicy
JOIN 
    ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN 
    ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN 
    ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
ORDER BY 
    pensja.kwota DESC, 
    premia.kwota DESC;
    
   
 k)
   
  SELECT ksiegowosc.pensja.stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
GROUP BY ksiegowosc.pensja.stanowisko;


l)

SELECT MIN(ksiegowosc.pensja.kwota) as minimum, AVG(ksiegowosc.pensja.kwota) as srednia, MAX(ksiegowosc.pensja.kwota) as maksimum
FROM ksiegowosc.pensja WHERE ksiegowosc.pensja.stanowisko LIKE 'Content Editor';


m)

SELECT SUM(ksiegowosc.pensja.kwota) as suma_wynagrodzen
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie on ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja on ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji;


n)

SELECT ksiegowosc.pensja.stanowisko, SUM(ksiegowosc.pensja.kwota) as suma_wynagrodzen
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
GROUP BY ksiegowosc.pensja.stanowisko;


o)

SELECT ksiegowosc.pensja.stanowisko, COUNT(ksiegowosc.premia.id_premii) AS liczba_premii
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
GROUP BY ksiegowosc.pensja.stanowisko;


p)

DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN
    (SELECT ksiegowosc.pracownicy.id_pracownika
     FROM ksiegowosc.pracownicy
     JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
     JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
     WHERE ksiegowosc.pensja.kwota < 1200);

