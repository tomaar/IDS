-- DROP TABLE "Specialista" CASCADE CONSTRAINTS;
-- DROP TABLE "Zakaznik" CASCADE CONSTRAINTS;
-- DROP TABLE "Oprava" CASCADE CONSTRAINTS;
-- DROP TABLE "Vozidlo" CASCADE CONSTRAINTS;
-- DROP TABLE "Material" CASCADE CONSTRAINTS;
-- DROP TABLE "Faktura" CASCADE CONSTRAINTS;
-- DROP TABLE "Vykonava_cinnost" CASCADE CONSTRAINTS;
-- DROP TABLE "Automechanik" CASCADE CONSTRAINTS;
-- DROP TABLE "RelCinnostiOpravy" CASCADE CONSTRAINTS;

CREATE TABLE "Automechanik" (
    "ID_mechanika" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Jmeno" VARCHAR(100),
    "Prijmeni" VARCHAR(100),
	"Rodne_cislo" VARCHAR(10),
    CONSTRAINT check_format CHECK (REGEXP_LIKE("Rodne_cislo", '^[0-9]{2}(0[1-9]|1[0-2]|5[0-9]|6[0-2])(0[1-9]|[1-2][0-9]|3[01])[0-9]{4}$'))
);

CREATE TABLE "Specialista" (
    "ID_specialistu" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Specializace" VARCHAR(100),
	FOREIGN KEY ("ID_specialistu") REFERENCES "Automechanik"("ID_mechanika")
);

CREATE TABLE "Zakaznik" (
    "ID_zakaznika" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Jmeno" VARCHAR(100),
    "Prijmeni" VARCHAR(100),
    "Telefon" INT
);

CREATE TABLE "Vykonava_cinnost" (
    "ID_cinnosti" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Nazev_cinnosti" VARCHAR(100),
    "cas" INT,
	"ID_mechanika" INT,
	FOREIGN KEY ("ID_mechanika") REFERENCES "Automechanik"("ID_mechanika")
);

-- Nazev vozidlo je zvolen kvuli kolizi klicoveho slova "auto"
CREATE TABLE "Vozidlo" (
    "ID_auta" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Znacka" VARCHAR(100),
    "Model" VARCHAR(100),
    "SPZ" VARCHAR(100)
);

CREATE TABLE "Oprava" (
	"ID_opravy" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Termin" DATE,
	"ID_auta" INT,
	"ID_zakaznika" INT,
    FOREIGN KEY ("ID_auta") REFERENCES "Vozidlo"("ID_auta"),
    FOREIGN KEY ("ID_zakaznika") REFERENCES "Zakaznik"("ID_zakaznika")
);

CREATE TABLE "Faktura" (
    "ID_faktury" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Datum_splatnosti" DATE,
    "Celkova_castka" VARCHAR(100),
    "Forma_uhrady" VARCHAR(100),
    "ID_opravy" INT,
    FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy")
);

CREATE TABLE "Material" (
    "ID_materialu" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Nazev" VARCHAR(100),
    "Porizovaci_cena" INT
);

CREATE TABLE "RelCinnostiOpravy" (
    "ID_opravy" INT,
    FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy"),
    "ID_cinnosti" INT,
    FOREIGN KEY ("ID_cinnosti") REFERENCES "Vykonava_cinnost"("ID_cinnosti"),
    PRIMARY KEY ("ID_opravy", "ID_cinnosti")
);

-- Doplneni konkretnich zaznamu
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Jan', 'Novak', '9307154197');
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Petr', 'Svoboda', '0854267403');
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Karel', 'Kral', '9501231234');

INSERT INTO "Specialista" ("Specializace")
VALUES ('Elektrika');
INSERT INTO "Specialista" ("Specializace")
VALUES ('Karoserie');

INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon")
VALUES ('Karel', 'Novy', 123456789);
INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon")
VALUES ('Eva', 'Svobodova', 987654321);
INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon")
VALUES ('Pavel', 'Kral', 123123123);

INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Skoda', 'Octavia', 'ABC123');
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Ford', 'Focus', 'XYZ987');
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Skoda', 'Fabia', 'DEF456');
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Skoda', 'Superb', 'GHI789');

INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena brzdovych desticek', 120, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena oleje', 60, 1);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Lakovani', 90, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena svetel', 30, 1);

INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-25', 'yyyy/mm/dd'), 1, 1);
INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-27', 'yyyy/mm/dd'), 2, 2);
INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-27', 'yyyy/mm/dd'), 3, 3);


INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (1, 1);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (2, 2);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (2, 3);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (3, 4);


INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-27', 'yyyy/mm/dd'), '3500', 'Prevodem', 1);
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '2500', 'Hotove', 2);
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '1500', 'Prevodem', 3);


INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Brzdove desticky', 300);
INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Olej', 200);



-- najde vsechny vozy Skoda, ktere jsou v databazi
SELECT * FROM "Vozidlo"
WHERE "Znacka" = 'Skoda';


-- najde vsechny vozy Skoda, ktere byly opravovany
SELECT * FROM "Vozidlo"
NATURAL JOIN "Oprava"
WHERE "Znacka" = 'Skoda';


-- najde vsechny zakazniky, kteri maji auto znacky Skoda
SELECT "Jmeno", "Prijmeni" FROM "Zakaznik"
NATURAL JOIN "Oprava"
NATURAL JOIN "Vozidlo"
WHERE "Znacka" = 'Skoda';


-- najde vsechny cinnosti provedene behem opravy s id 2
SELECT "Nazev_cinnosti" FROM "Vykonava_cinnost"
NATURAL JOIN "RelCinnostiOpravy"
WHERE "ID_opravy" = 2;


-- spocte opravy podle znacky auta
SELECT v."Znacka", COUNT(o."ID_opravy") FROM "Oprava" o
JOIN "Vozidlo" v ON o."ID_auta" = v."ID_auta"
GROUP BY v."Znacka";


-- najde vsechny mechaniky, vypise jmeno a pocet jimy provedenych cinnosti
SELECT a."ID_mechanika", a."Jmeno", a."Prijmeni", COUNT("ID_opravy") FROM "Automechanik" a
LEFT JOIN "Vykonava_cinnost" vc ON a."ID_mechanika" = vc."ID_mechanika"
LEFT JOIN "RelCinnostiOpravy" rc ON vc."ID_cinnosti" = rc."ID_cinnosti"
GROUP BY a."ID_mechanika", a."Jmeno", a."Prijmeni";


-- najde vsechna auta, ktera byla opravovana
SELECT * FROM "Vozidlo" v
WHERE EXISTS (
    SELECT 1
    FROM "Oprava" o
    WHERE o."ID_auta" = v."ID_auta"
);


-- najde vsechny zakazniky, kteri platili prevodem
SELECT * FROM "Zakaznik"
WHERE "ID_zakaznika" IN (
    SELECT DISTINCT "ID_zakaznika" FROM "Oprava"
    NATURAL JOIN "Faktura"
    WHERE "Forma_uhrady" = 'Prevodem'
);

