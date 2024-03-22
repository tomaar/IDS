

CREATE TABLE Automechanik (
    ID_mechanika INT PRIMARY KEY IDENTITY,
    Jmeno VARCHAR(100),
    Prijmeni VARCHAR(100),
	Rodne_cislo INT
);

CREATE TABLE Specialista (
    Specializacec VARCHAR(100),
	ID_specialistu INT,
	FOREIGN KEY (ID_specialistu) REFERENCES Automechanik(ID_mechanika),
);

CREATE TABLE Zakaznik (
    ID_zakaznika INT PRIMARY KEY IDENTITY,
    Jmeno VARCHAR(100),
    Prijmeni VARCHAR(100),
    Telefon INT,
	ID_opravy INT,
	ID_auta INT
);

CREATE TABLE Vykonava_cinnost (
    Cislo_zakazky INT PRIMARY KEY IDENTITY,
    Nazev_cinnosti VARCHAR(100),
    cas INT,
	ID_cinnosti INT,
	FOREIGN KEY (ID_cinnosti) REFERENCES Automechanik(ID_mechanika)
);

-- Název vozidlo je zvolen kvùli kolizi klíèového slova "auto"
CREATE TABLE Vozidlo (
    ID_auta INT PRIMARY KEY IDENTITY,
    Znacka VARCHAR(100),
    Model VARCHAR(100),
    SPZ VARCHAR(100),
	ID_opravy INT,
	ID_zakaznika INT
);

CREATE TABLE Oprava (
	ID_opravy INT PRIMARY KEY,
	FOREIGN KEY (ID_opravy) REFERENCES Vykonava_cinnost(Cislo_zakazky),
    Termin VARCHAR(100),
	ID_auta INT,
	ID_zakaznika INT
);

CREATE TABLE Faktura (
    ID_faktury INT PRIMARY KEY IDENTITY,
    Datum_splatnosti VARCHAR(100),
    Celkova_castka VARCHAR(100),
    Forma_uhrady VARCHAR(100)
);

CREATE TABLE Material (
    ID_materialu INT PRIMARY KEY IDENTITY,
    Nazev VARCHAR(100),
    Porizovaci_cena INT
);

-- Pøidání cizích klíèù až po vytvoøení tabulek, z dùvodu reference na zatím neexistující tabulku
ALTER TABLE Zakaznik ADD FOREIGN KEY (ID_opravy) REFERENCES Oprava(ID_opravy);
ALTER TABLE Zakaznik ADD FOREIGN KEY (ID_auta) REFERENCES Vozidlo(ID_auta);

ALTER TABLE Vozidlo ADD FOREIGN KEY (ID_opravy) REFERENCES Oprava(ID_opravy);
ALTER TABLE Vozidlo ADD FOREIGN KEY (ID_zakaznika) REFERENCES Zakaznik(ID_zakaznika);

ALTER TABLE Oprava ADD FOREIGN KEY (ID_auta) REFERENCES Vozidlo(ID_auta);
ALTER TABLE Oprava ADD FOREIGN KEY (ID_zakaznika) REFERENCES Zakaznik(ID_zakaznika);


-- Doplnìní konkrétních záznamù
INSERT INTO Automechanik (Jmeno, Prijmeni, Rodne_cislo)
VALUES ('Jan', 'Novák', 123456789),
       ('Petr', 'Svoboda', 987654321);

INSERT INTO Specialista (Specializacec, ID_specialistu)
VALUES ('Elektrika', 1),
       ('Karoserie', 2);

INSERT INTO Zakaznik (Jmeno, Prijmeni, Telefon, ID_opravy, ID_auta)
VALUES ('Karel', 'Nový', 123456789, 1, 1),
       ('Eva', 'Svobodová', 987654321, 2, 2);

INSERT INTO Vykonava_cinnost (Nazev_cinnosti, cas, ID_cinnosti)
VALUES ('Výmìna oleje', 60, 1),
       ('Výmìna brzdových destièek', 120, 2);

INSERT INTO Vozidlo (Znacka, Model, SPZ, ID_opravy, ID_zakaznika)
VALUES ('Škoda', 'Octavia', 'ABC123', 1, 1),
       ('Ford', 'Focus', 'XYZ987', 2, 2);

INSERT INTO Oprava (ID_opravy, Termin, ID_auta, ID_zakaznika)
VALUES (1, '2024-03-25', 1, 1),
       (2, '2024-03-27', 2, 2);

INSERT INTO Faktura (Datum_splatnosti, Celkova_castka, Forma_uhrady)
VALUES ('2024-04-25', '2500', 'Hotovì'),
       ('2024-04-27', '3500', 'Pøevodem');

INSERT INTO Material (Nazev, Porizovaci_cena)
VALUES ('Olej', 200),
       ('Brzdové destièky', 300);
