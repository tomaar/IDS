

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

-- N�zev vozidlo je zvolen kv�li kolizi kl��ov�ho slova "auto"
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

-- P�id�n� ciz�ch kl��� a� po vytvo�en� tabulek, z d�vodu reference na zat�m neexistuj�c� tabulku
ALTER TABLE Zakaznik ADD FOREIGN KEY (ID_opravy) REFERENCES Oprava(ID_opravy);
ALTER TABLE Zakaznik ADD FOREIGN KEY (ID_auta) REFERENCES Vozidlo(ID_auta);

ALTER TABLE Vozidlo ADD FOREIGN KEY (ID_opravy) REFERENCES Oprava(ID_opravy);
ALTER TABLE Vozidlo ADD FOREIGN KEY (ID_zakaznika) REFERENCES Zakaznik(ID_zakaznika);

ALTER TABLE Oprava ADD FOREIGN KEY (ID_auta) REFERENCES Vozidlo(ID_auta);
ALTER TABLE Oprava ADD FOREIGN KEY (ID_zakaznika) REFERENCES Zakaznik(ID_zakaznika);


-- Dopln�n� konkr�tn�ch z�znam�
INSERT INTO Automechanik (Jmeno, Prijmeni, Rodne_cislo)
VALUES ('Jan', 'Nov�k', 123456789),
       ('Petr', 'Svoboda', 987654321);

INSERT INTO Specialista (Specializacec, ID_specialistu)
VALUES ('Elektrika', 1),
       ('Karoserie', 2);

INSERT INTO Zakaznik (Jmeno, Prijmeni, Telefon, ID_opravy, ID_auta)
VALUES ('Karel', 'Nov�', 123456789, 1, 1),
       ('Eva', 'Svobodov�', 987654321, 2, 2);

INSERT INTO Vykonava_cinnost (Nazev_cinnosti, cas, ID_cinnosti)
VALUES ('V�m�na oleje', 60, 1),
       ('V�m�na brzdov�ch desti�ek', 120, 2);

INSERT INTO Vozidlo (Znacka, Model, SPZ, ID_opravy, ID_zakaznika)
VALUES ('�koda', 'Octavia', 'ABC123', 1, 1),
       ('Ford', 'Focus', 'XYZ987', 2, 2);

INSERT INTO Oprava (ID_opravy, Termin, ID_auta, ID_zakaznika)
VALUES (1, '2024-03-25', 1, 1),
       (2, '2024-03-27', 2, 2);

INSERT INTO Faktura (Datum_splatnosti, Celkova_castka, Forma_uhrady)
VALUES ('2024-04-25', '2500', 'Hotov�'),
       ('2024-04-27', '3500', 'P�evodem');

INSERT INTO Material (Nazev, Porizovaci_cena)
VALUES ('Olej', 200),
       ('Brzdov� desti�ky', 300);
