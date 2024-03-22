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
	"Rodne_cislo" INT
);

CREATE TABLE "Specialista" (
    "Specializace" VARCHAR(100),
	"ID_specialistu" INT,
	FOREIGN KEY ("ID_specialistu") REFERENCES "Automechanik"("ID_mechanika")
);

CREATE TABLE "Zakaznik" (
    "ID_zakaznika" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Jmeno" VARCHAR(100),
    "Prijmeni" VARCHAR(100),
    "Telefon" INT,
	"ID_opravy" INT,
	"ID_auta" INT
);

CREATE TABLE "Vykonava_cinnost" (
    "Cislo_zakazky" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Nazev_cinnosti" VARCHAR(100),
    "cas" INT,
	"ID_cinnosti" INT,
	FOREIGN KEY ("ID_cinnosti") REFERENCES "Automechanik"("ID_mechanika")
);

-- N?zev vozidlo je zvolen kv?li kolizi kl??ov?ho slova "auto"
CREATE TABLE "Vozidlo" (
    "ID_auta" INT GENERATED AS IDENTITY PRIMARY KEY,
    "Znacka" VARCHAR(100),
    "Model" VARCHAR(100),
    "SPZ" VARCHAR(100),
	"ID_opravy" INT,
	"ID_zakaznika" INT
);

CREATE TABLE "Oprava" (
	"ID_opravy" INT PRIMARY KEY,
	FOREIGN KEY ("ID_opravy") REFERENCES "Vykonava_cinnost"("Cislo_zakazky"),
    "Termin" DATE,
	"ID_auta" INT,
	"ID_zakaznika" INT
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


-- P?id?n? ciz?ch kl??? a? po vytvo?en? tabulek, z d?vodu reference na zat?m neexistuj?c? tabulku
ALTER TABLE "Zakaznik" ADD FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy");
ALTER TABLE "Zakaznik" ADD FOREIGN KEY ("ID_auta") REFERENCES "Vozidlo"("ID_auta");

ALTER TABLE "Vozidlo" ADD FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy");
ALTER TABLE "Vozidlo" ADD FOREIGN KEY ("ID_zakaznika") REFERENCES "Zakaznik"("ID_zakaznika");

ALTER TABLE "Oprava" ADD FOREIGN KEY ("ID_auta") REFERENCES "Vozidlo"("ID_auta");
ALTER TABLE "Oprava" ADD FOREIGN KEY ("ID_zakaznika") REFERENCES "Zakaznik"("ID_zakaznika");


-- Dopln?n? konkr?tn?ch z?znam?
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Jan', 'Nov?k', 123456789);
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Petr', 'Svoboda', 987654321);

INSERT INTO "Specialista" ("Specializace", "ID_specialistu")
VALUES ('Elektrika', 1);
INSERT INTO "Specialista" ("Specializace", "ID_specialistu")
VALUES ('Karoserie', 2);

INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon", "ID_opravy", "ID_auta")
VALUES ('Karel', 'Nov?', 123456789, 1, 1);
INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon", "ID_opravy", "ID_auta")
VALUES ('Eva', 'Svobodov?', 987654321, 2, 2);

INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('V?m?na brzdov?ch desti?ek', 120, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('V?m?na oleje', 60, 1);

INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ", "ID_opravy", "ID_zakaznika")
VALUES ('?koda', 'Octavia', 'ABC123', 1, 1);
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ", "ID_opravy", "ID_zakaznika")
VALUES ('Ford', 'Focus', 'XYZ987', 2, 2);

INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (1, TO_DATE('2024-03-25', 'yyyy/mm/dd'), 1, 1);
INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (2, TO_DATE('2024-03-27', 'yyyy/mm/dd'), 2, 2);

INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-27', 'yyyy/mm/dd'), '3500', 'P?evodem');
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '2500', 'Hotov?');

INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Brzdov? desti?ky', 300);
INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Olej', 200);