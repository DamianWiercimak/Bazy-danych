CREATE DATABASE PROJECT;
USE PROJECT;

CREATE SCHEMA GEOL;



CREATE TABLE GeoEon(
id_eon INT IDENTITY(1,1) PRIMARY KEY,
nazwa_eon VARCHAR(50)
);

CREATE TABLE GeoEra(
id_era INT IDENTITY(1,1) PRIMARY KEY,
id_eon INT NOT NULL,
nazwa_era VARCHAR(50)
);

CREATE TABLE GeoOkres(
id_okres INT IDENTITY(1,1) PRIMARY KEY,
id_era INT NOT NULL,
nazwa_okres VARCHAR(50)
);

CREATE TABLE GeoEpoka(
id_epoka INT IDENTITY(1,1) PRIMARY KEY,
id_okres INT NOT NULL,
nazwa_epoka VARCHAR(50)
);

CREATE TABLE GeoPietro(
id_pietro INT IDENTITY(1,1) PRIMARY KEY,
id_epoka INT NOT NULL,
nazwa_pietro VARCHAR(50)
);

CREATE TABLE GeoTabela(
id_pietro INT IDENTITY(1,1) PRIMARY KEY,
nazwa_pietro VARCHAR(50),
id_epoka INT,
nazwa_epoka VARCHAR(50),
id_okres INT,
nazwa_okres VARCHAR(50),
id_era INT,
nazwa_era VARCHAR(50),
id_eon INT,
nazwa_eon VARCHAR(50),
);

ALTER TABLE GeoEra ADD FOREIGN KEY (id_eon) REFERENCES GeoEon (id_eon);
ALTER TABLE GeoOkres ADD FOREIGN KEY (id_era) REFERENCES GeoEra (id_era);
ALTER TABLE GeoEpoka ADD FOREIGN KEY (id_okres) REFERENCES GeoOkres (id_okres);
ALTER TABLE GeoPietro ADD FOREIGN KEY (id_epoka) REFERENCES GeoEpoka (id_epoka);

INSERT INTO dbo.GeoEon(nazwa_eon)
VALUES('Fanerozoik');

INSERT INTO dbo.GeoEra(nazwa_era, id_eon)
VALUES('Kenozoik', 1), 
	('Mezozoik', 1), 
	('Paleozoik', 1);

INSERT INTO dbo.GeoOkres(nazwa_okres, id_era)
VALUES ('Czwartorzêd' ,1), 
	('Trzeciorzêd Neogen', 1), 
	('Trzeciorzêd Paleogen', 1), 
	('Kreda', 2), 
	('Jura', 2), 
	('Trias', 2), 
	('Perm', 3), 
	('Karbon', 3), 
	('Dewon', 3);

INSERT INTO dbo.GeoEpoka(nazwa_epoka, id_okres)
VALUES ('Halocen', 1), 
	('Plejstocen', 1), 
	('Pliocen', 2), 
	('Miocen', 2), 
	('Oligocen', 3), 
	('Eocen', 3), 
	('Paleocen', 3), 
	('Górna', 4), 
	('Dolna', 4), 
	('Górna', 5), 
	('Œrodkowa', 5), 
	('Dolna', 5), 
	('Górny', 6), 
	('Œrodkowy', 6),
	('Dolny', 6), 
	('Górny', 7),
	('Dolny', 7), 
	('Górny', 8), 
	('Dolny', 8), 
	('Górny', 9), 
	('Œrodkowy', 9), 
	('Dolny', 9);

	INSERT INTO dbo.GeoPietro(nazwa_pietro, id_epoka)
	VALUES ('Wurm',2), 
		('Riss-wurm', 2),
		('Riss', 2),
		('Mindel-riss', 2),
		('Mindel', 2),
		('Gunz-mindel', 2),
		('Gunz' , 2),
		('Donau-gunz' , 2),
		('Donau' , 2),
		('Biber-donau' , 2),
		('Biber' , 2),
		('Roman' , 3),
		('Dak' , 3),
		('Pont' , 4),
		('Panon' , 4),
		('Sarat' , 4),
		('Baden', 4),
		('Karpat', 4),
		('Otnang', 4),
		('Egenburg', 4),
		('Egger', 4),
		('Szat', 5),
		('Rupel', 5),
		('Priabon', 6),
		('Barton', 6),
		('Lutet', 6),
		('Yprez', 6),
		('Tanet', 7),
		('Dan', 7),
		('Mastrycht', 8),
		('Kampan', 8),
		('Santon', 8),
		('Koniak', 8),
		('Turon', 8),
		('Cenoman', 8),
		('Alb', 9),
		('Apt', 9),
		('Barrem', 9),
		('Hoteryw', 9),
		('Walanzyn', 9),
		('Berias', 9),
		('Tyton', 10),
		('Kimeryd', 10),
		('Oksford', 10),
		('Kelowej', 11),
		('Baton', 11),
		('Bajos', 11),
		('Aalen', 11),
		('Toark', 12),
		('Plinsbach', 12),
		('Synemur', 12),
		('Hetang', 12),
		('Retyk', 13),
		('Noryk', 13),
		('Karnik', 13),
		('Ladyn', 14),
		('Anizyk', 14),
		('Scytyk', 15),
		('Tatar', 16),
		('Kazan', 16),
		('Kungur', 16),
		('Artynsk', 17),
		('Sakmar', 17),
		('Aselsk', 17),
		('Stefan', 18),
		('Westfal', 18),
		('Namur', 18),
		('Wizen', 19),
		('Turnej', 19),
		('Famen', 20),
		('Fran', 20),
		('Zywet', 21),
		('Eifel', 21),
		('Ems', 22),
		('Zigen', 22),
		('Zedyn', 22);

INSERT INTO GeoTabela (nazwa_pietro, id_epoka, nazwa_epoka, id_okres, nazwa_okres, id_era, nazwa_era, id_eon, nazwa_eon)
SELECT 
    GeoPietro.nazwa_pietro,
    GeoEpoka.id_epoka,
    GeoEpoka.nazwa_epoka,
    GeoOkres.id_okres,
    GeoOkres.nazwa_okres,
    GeoEra.id_era,
    GeoEra.nazwa_era,
    GeoEon.id_eon,
    GeoEon.nazwa_eon
FROM GeoPietro
INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon;



CREATE TABLE Dziesiec (
cyfra INT PRIMARY KEY
);

INSERT INTO Dziesiec(cyfra) 
VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE Dziesiec_milionow (
liczba INT PRIMARY KEY
);

INSERT INTO Dziesiec_milionow(liczba)
SELECT a.cyfra + b.cyfra * 10 + c.cyfra * 100 + d.cyfra * 1000 + e.cyfra * 10000 + f.cyfra * 100000 + g.cyfra * 1000000
FROM Dziesiec a
JOIN Dziesiec b ON a.cyfra >=0
JOIN Dziesiec c ON b.cyfra >=0
JOIN Dziesiec d ON c.cyfra >=0
JOIN Dziesiec e ON d.cyfra >=0
JOIN Dziesiec f ON e.cyfra >=0
JOIN Dziesiec g ON f.cyfra >=0




SET STATISTICS TIME ON;
SELECT COUNT(*) 
FROM Dziesiec_milionow 
INNER JOIN GeoTabela 
ON (Dziesiec_milionow.liczba % 68 = GeoTabela.id_pietro);
SET STATISTICS TIME OFF;

SELECT COUNT(*) 
FROM Dziesiec_milionow 
INNER JOIN GeoPietro ON (Dziesiec_milionow.liczba % 68 = GeoPietro.id_pietro) 
INNER JOIN GeoEpoka ON GeoPietro.id_epoka =GeoEpoka.id_epoka
INNER JOIN GeoOkres ON GeoEpoka.id_okres =GeoOkres.id_okres
INNER JOIN GeoEra ON GeoOkres.id_era =GeoEra.id_era
INNER JOIN GeoEon ON GeoEra.id_eon =GeoEon.id_eon;


SELECT COUNT(*)
FROM Dziesiec_milionow 
WHERE Dziesiec_milionow.liczba % 68 = 
(SELECT id_pietro FROM GeoTabela WHERE Dziesiec_milionow.liczba % 68 = id_pietro);




SELECT COUNT(*) 
FROM Dziesiec_milionow 
WHERE EXISTS (
SELECT 1
 FROM GeoPietro 
 INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
 INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
 INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
 INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon);
 

 CREATE INDEX IndexGeoEon
ON GeoEon (id_eon);
 
 CREATE INDEX IndexGeoEra
ON GeoEra (id_era, id_eon);

CREATE INDEX IndexGeoOkres
ON GeoOkres (id_okres, id_era);

CREATE INDEX IndexGeoEpoka
ON GeoEpoka (id_epoka, id_okres);

CREATE INDEX IndexGeoPietro
ON GeoPietro (id_pietro, id_epoka);

CREATE INDEX IndexGeoTabela
ON GeoTabela (id_pietro, id_epoka, id_okres, id_era, id_eon);

DROP INDEX GeoEon.IndexGeoEon;
DROP INDEX GeoEra.IndexGeoEra;
DROP INDEX GeoOkres.IndexGeoOkres;
DROP INDEX GeoEpoka.IndexGeoEpoka;
DROP INDEX GeoPietro.IndexGeoPietro;
DROP INDEX GeoTabela.IndexGeoTabela;