DROP TABLE "Specialista" CASCADE CONSTRAINTS;
DROP TABLE "Zakaznik" CASCADE CONSTRAINTS;
DROP TABLE "Oprava" CASCADE CONSTRAINTS;
DROP TABLE "Vozidlo" CASCADE CONSTRAINTS;
DROP TABLE "Material" CASCADE CONSTRAINTS;
DROP TABLE "Faktura" CASCADE CONSTRAINTS;
DROP TABLE "Vykonava_cinnost" CASCADE CONSTRAINTS;
DROP TABLE "Automechanik" CASCADE CONSTRAINTS;
DROP TABLE "RelCinnostiOpravy" CASCADE CONSTRAINTS;
DROP MATERIALIZED VIEW "pocet_oprav";

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
INSERT INTO "Vozidlo" ("Znacka", "Model", "SPZ")
VALUES ('Volkswagen', 'Golf', 'JKL321');

INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena brzdovych desticek', 120, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena oleje', 60, 1);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Lakovani', 90, 2);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena svetel', 30, 1);
INSERT INTO "Vykonava_cinnost" ("Nazev_cinnosti", "cas", "ID_mechanika")
VALUES ('Vymena brzdovych desticek', 120, 3);

INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-25', 'yyyy/mm/dd'), 1, 1);
INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-27', 'yyyy/mm/dd'), 2, 2);
INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-27', 'yyyy/mm/dd'), 3, 3);
INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
VALUES (TO_DATE('2024-03-27', 'yyyy/mm/dd'), 1, 3);


INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (1, 1);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (2, 2);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (2, 3);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (3, 4);
INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
VALUES (4, 5);


INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-26', 'yyyy/mm/dd'), '3500', 'Prevodem', 1);
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '2500', 'Hotove', 2);
INSERT INTO "Faktura" ("Datum_splatnosti", "Celkova_castka", "Forma_uhrady", "ID_opravy")
VALUES (TO_DATE('2024-04-25', 'yyyy/mm/dd'), '1500', 'Prevodem', 3);


INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Brzdove desticky', 300);
INSERT INTO "Material" ("Nazev", "Porizovaci_cena")
VALUES ('Olej', 200);

-- Trigger na odstraneni zaznamu z tabulky Specialista, pokud se odstranuje zaznam z tabulky Automechanik, se stejnym ID
CREATE TRIGGER odstraneni_specialisty
    BEFORE DELETE ON "Automechanik"
    FOR EACH ROW
DECLARE
    id_specialisty "Automechanik"."ID_mechanika"%TYPE;
BEGIN
    id_specialisty := :OLD."ID_mechanika";

    DELETE FROM "Specialista" WHERE "ID_specialistu" = id_specialisty;
END;
/

-- Trigger na odstraneni zaznamu z tabulky Oprava, pokud se odstranuje zaznam z tabulky Faktura, se stejnym ID
CREATE TRIGGER odstraneni_opravy
    BEFORE DELETE ON "Faktura"
    FOR EACH ROW
DECLARE
    id_opravy "Oprava"."ID_opravy"%TYPE;
BEGIN
    id_opravy := :OLD."ID_opravy";
    
    DELETE FROM "Oprava" WHERE "ID_opravy" = id_opravy;
END;
/

-- Procedura na vytvoreni opravy, prijma potrebne informace, cinnosti prijma ve forme listu
CREATE OR REPLACE PROCEDURE vytvoreni_opravy(
    p_termin DATE,
    p_id_auta INT,
    p_id_zakaznika INT,
    p_cinnosti SYS.ODCINUMBERLIST
) AS
    v_oprava_id INT;
BEGIN
    INSERT INTO "Oprava" ("Termin", "ID_auta", "ID_zakaznika")
    VALUES (p_termin, p_id_auta, p_id_zakaznika)
    RETURNING "ID_opravy" INTO v_oprava_id;

    FOR i IN 1..p_cinnosti.COUNT LOOP
        INSERT INTO "RelCinnostiOpravy" ("ID_opravy", "ID_cinnosti")
        VALUES (v_oprava_id, p_cinnosti(i));
    END LOOP;

    COMMIT;
END;
/

-- Procedura ktera odstranuje zaznam z tabulky Zakaznik, ale pred jeho odstranenim kontroluje, zda nema zakaznik nejake nedokoncene opravy
CREATE OR REPLACE PROCEDURE odstraneni_zakaznika(
    p_customer_id INT
) AS
    v_repair_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_repair_count
    FROM "Oprava"
    WHERE "ID_zakaznika" = p_customer_id;

    IF v_repair_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nelze odstranit zákazníka, který má nedokončené opravy.');
    ELSE
        DELETE FROM "Zakaznik" WHERE "ID_zakaznika" = p_customer_id;
        COMMIT;
    END IF;
END;
/

-- zobrazeni prav uzivatelu
SELECT grantee, table_name, privilege
FROM all_tab_privs
WHERE table_name = 'Specialista';


-- spocte pocet aut podle zeme puvodu
WITH auta AS (
    SELECT 
        "ID_auta", 
        "Znacka", 
        "SPZ",
        CASE
            WHEN "Znacka" = 'Skoda' THEN 'CZ'
            WHEN "Znacka" = 'Ford' THEN 'US'
            WHEN "Znacka" = 'Volkswagen' THEN 'DE'
            ELSE 'Jine'
        END AS "Zeme_puvodu"
    FROM
        "Vozidlo"
)
SELECT "Zeme_puvodu", COUNT("Zeme_puvodu")
FROM auta
GROUP BY "Zeme_puvodu";


-- ukazkove provedeni SELECT dotazu
EXPLAIN PLAN FOR
SELECT v."Znacka", v."Model", COUNT(o."ID_opravy") AS Pocet_oprav
FROM "Vozidlo" v
JOIN "Oprava" o ON v."ID_auta" = o."ID_auta"
GROUP BY v."Znacka", v."Model";
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

-- pred optimalizaci
EXPLAIN PLAN FOR
SELECT v."Znacka", v."Model", COUNT(o."ID_opravy") AS Pocet_oprav
FROM "Vozidlo" v
JOIN "Oprava" o ON v."ID_auta" = o."ID_auta"
GROUP BY v."Znacka", v."Model";
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

-- vytvoreni indexu
CREATE INDEX idx_oprava_id_auta ON "Oprava" ("ID_auta");

-- po optimalizaci
EXPLAIN PLAN FOR
SELECT v."Znacka", v."Model", COUNT(o."ID_opravy") AS Pocet_oprav
FROM "Vozidlo" v
JOIN "Oprava" o ON v."ID_auta" = o."ID_auta"
GROUP BY v."Znacka", v."Model";
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

CREATE MATERIALIZED VIEW "pocet_oprav" AS
SELECT v."Znacka", v."Model", COUNT(o."ID_opravy") AS Pocet_oprav
FROM "Vozidlo" v
JOIN "Oprava" o ON v."ID_auta" = o."ID_auta"
GROUP BY v."Znacka", v."Model";
SELECT * FROM "pocet_oprav";


-- udeleni prav uzivateli
GRANT ALL ON "Specialista" TO xrybni10;
GRANT ALL ON "Zakaznik" TO xrybni10;
GRANT ALL ON "Oprava" TO xrybni10;
GRANT ALL ON "Vozidlo" TO xrybni10;
GRANT ALL ON "Material" TO xrybni10;
GRANT ALL ON "Faktura" TO xrybni10;
GRANT ALL ON "Vykonava_cinnost" TO xrybni10;
GRANT ALL ON "Automechanik" TO xrybni10;
GRANT ALL ON "RelCinnostiOpravy" TO xrybni10;
GRANT EXECUTE ON vytvoreni_opravy TO xrybni10;
GRANT EXECUTE ON odstraneni_zakaznika TO xrybni10;
GRANT ALL ON "pocet_oprav" TO xrybni10;
-- todo: view + procedures