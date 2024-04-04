DROP TABLE "Specialista" CASCADE CONSTRAINTS;
DROP TABLE "Zakaznik" CASCADE CONSTRAINTS;
DROP TABLE "Oprava" CASCADE CONSTRAINTS;
DROP TABLE "Vozidlo" CASCADE CONSTRAINTS;
DROP TABLE "Material" CASCADE CONSTRAINTS;
DROP TABLE "Faktura" CASCADE CONSTRAINTS;
DROP TABLE "Vykonava_cinnost" CASCADE CONSTRAINTS;
DROP TABLE "Automechanik" CASCADE CONSTRAINTS;

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
    "Cislo_zakazky" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Nazev_cinnosti" VARCHAR(100),
    "cas" INT,
	"ID_cinnosti" INT,
	FOREIGN KEY ("ID_cinnosti") REFERENCES "Automechanik"("ID_mechanika")
);

-- Nazev vozidlo je zvolen kvuli kolizi klicoveho slova "auto"
CREATE TABLE "Vozidlo" (
    "ID_auta" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Znacka" VARCHAR(100),
    "Model" VARCHAR(100),
    "SPZ" VARCHAR(100)
);

CREATE TABLE "Oprava" (
	"ID_opravy" INT PRIMARY KEY,
	FOREIGN KEY ("ID_opravy") REFERENCES "Vykonava_cinnost"("Cislo_zakazky"),
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
    "Forma_uhrady" VARCHAR(100)
);

CREATE TABLE "Material" (
    "ID_materialu" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Nazev" VARCHAR(100),
    "Porizovaci_cena" INT
);


-- Doplneni konkretnich zaznamu
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Jan', 'Novak', '9307154197');
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Petr', 'Svoboda', '0854267403');

INSERT INTO "Specialista" ("Specializace")
VALUES ('Elektrika');
INSERT INTO "Specialista" ("Specializace")
VALUES ('Karoserie');

INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon")
VALUES ('Karel', 'Novy', 123456789);
INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon")
VALUES ('Eva', 'Svobodova', 987654321);

INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('Vymena brzdovych desticek', 120, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('Vymena oleje', 60, 1);

INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Skoda', 'Octavia', 'ABC123');
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Ford', 'Focus', 'XYZ987');

INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (1, TO_DATE('2024-03-25', 'yyyy/mm/dd'), 1, 1);
INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (2, TO_DATE('2024-03-27', 'yyyy/mm/dd'), 2, 2);

INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-27', 'yyyy/mm/dd'), '3500', 'P?evodem');
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '2500', 'Hotov?');

INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Brzdove desticky', 300);
INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Olej', 200);