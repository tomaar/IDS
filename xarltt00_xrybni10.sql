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

-- Nazev vozidlo je zvolen kvuli kolizi klicoveho slova "auto"
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


-- Pridani cizich klicu az po vytvoreni tabulek, z duvodu reference na zatim neexistujici tabulku
ALTER TABLE "Zakaznik" ADD FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy");
ALTER TABLE "Zakaznik" ADD FOREIGN KEY ("ID_auta") REFERENCES "Vozidlo"("ID_auta");

ALTER TABLE "Vozidlo" ADD FOREIGN KEY ("ID_opravy") REFERENCES "Oprava"("ID_opravy");
ALTER TABLE "Vozidlo" ADD FOREIGN KEY ("ID_zakaznika") REFERENCES "Zakaznik"("ID_zakaznika");

ALTER TABLE "Oprava" ADD FOREIGN KEY ("ID_auta") REFERENCES "Vozidlo"("ID_auta");
ALTER TABLE "Oprava" ADD FOREIGN KEY ("ID_zakaznika") REFERENCES "Zakaznik"("ID_zakaznika");


-- Doplneni konkretnich zaznamu
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Jan', 'Novak', '9307154197');
INSERT INTO "Automechanik" ("Jmeno", "Prijmeni", "Rodne_cislo")
VALUES ('Petr', 'Svoboda', '0854267403');

INSERT INTO "Specialista" ("Specializace")
VALUES ('Elektrika');
INSERT INTO "Specialista" ("Specializace")
VALUES ('Karoserie');

INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon", "ID_opravy", "ID_auta")
VALUES ('Karel', 'Novy', 123456789, NULL, NULL);
INSERT INTO "Zakaznik" ("Jmeno", "Prijmeni", "Telefon", "ID_opravy", "ID_auta")
VALUES ('Eva', 'Svobodova', 987654321, NULL, NULL);

INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('Vymena brzdovych desticek', 120, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_cinnosti")
VALUES ('Vymena oleje', 60, 1);

INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ", "ID_opravy", "ID_zakaznika")
VALUES ('Skoda', 'Octavia', 'ABC123', NULL, NULL);
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ", "ID_opravy", "ID_zakaznika")
VALUES ('Ford', 'Focus', 'XYZ987', NULL, NULL);

INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (1, TO_DATE('2024-03-25', 'yyyy/mm/dd'), NULL, NULL);
INSERT INTO "Oprava" ("ID_opravy", "Termin", "ID_auta", "ID_zakaznika")
VALUES (2, TO_DATE('2024-03-27', 'yyyy/mm/dd'), NULL, NULL);

INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-27', 'yyyy/mm/dd'), '3500', 'P?evodem');
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '2500', 'Hotov?');

INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Brzdove desticky', 300);
INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Olej', 200);

UPDATE "Zakaznik"
SET "ID_opravy" = 1, "ID_auta" = 1
WHERE "ID_zakaznika" = 1;
UPDATE "Zakaznik"
SET "ID_opravy" = 2, "ID_auta" = 2
WHERE "ID_zakaznika" = 2;
UPDATE "Vozidlo"
SET "ID_opravy" = 1, "ID_zakaznika" = 1
WHERE "ID_auta" = 1;
UPDATE "Vozidlo"
SET "ID_opravy" = 2, "ID_zakaznika" = 2
WHERE "ID_auta" = 2;
UPDATE "Oprava"
SET "ID_auta" = 1, "ID_zakaznika" = 1
WHERE "ID_opravy" = 1;
UPDATE "Oprava"
SET "ID_auta" = 2, "ID_zakaznika" = 2
WHERE "ID_opravy" = 2;