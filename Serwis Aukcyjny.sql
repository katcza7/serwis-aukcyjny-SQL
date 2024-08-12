DROP TABLE IF EXISTS Uzytkownicy;

CREATE TABLE Uzytkownicy
(
   login_u      VARCHAR(8) NOT NULL PRIMARY KEY,
   imie         VARCHAR(30)NOT NULL CHECK (imie LIKE '[A-Z]%'), 
   nazwisko     VARCHAR(30) NOT NULL CHECK (nazwisko LIKE '[A-Z]%'),
   AdresZam     VARCHAR(100) NOT NULL,
   e_mail       VARCHAR(30) NOT NULL,
   Nr_konta     VARCHAR NULL,
   AdresDost    VARCHAR(100) NULL,
   Nr_tel       INT NULL,

   CONSTRAINT unikalne UNIQUE (login_u),

);
DROP TABLE IF EXISTS Dostawy;

CREATE TABLE Dostawy
(
    idDost      INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nazwaDost   VARCHAR(10) NOT NULL,
    firma       VARCHAR(10) NOT NULL,
    cena_dost   FLOAT NOT NULL,

    CONSTRAINT unikalne UNIQUE (idDost)
);

DROP TABLE IF EXISTS Przedmioty;

CREATE TABLE Przedmioty
(
    numer       INT NOT NULL  PRIMARY KEY,
    login_u     VARCHAR(8) REFERENCES Uzytkownicy(login_u),
    dostawa     INT REFERENCES Dostawy(idDost), 
    nazwa       VARCHAR(10) NOT NULL,
    kategoria   VARCHAR(20) NOT NULL,
    cena        FLOAT NOT NULL,
    opis        VARCHAR(100) NULL,
    CenaZakupu  FLOAT NULL,

    CONSTRAINT unikalne UNIQUE (numer)
);

DROP TABLE IF EXISTS Licytacje;
CREATE TABLE Licytacje
(
    id          INT NOT NULL PRIMARY KEY,
    przedmiot   INT NOT NULL REFERENCES Przedmioty(numer),
    loginZwyc   VARCHAR(8) NULL REFERENCES Uzytkownicy(login_u),
    status_lic  VARCHAR(30) NOT NULL,
    dataRozp    DATE NOT NULL,
    dataZakon   DATE NOT NULL,

    CONSTRAINT jaki_status CHECK (status_lic IN ('w trakcie','zakonczona kupnem', 'zakoczona bez kupna')),
    CONSTRAINT unikalne UNIQUE (id)
);
DROP TABLE IF EXISTS ZlozoneOferty;
CREATE TABLE ZlozoneOferty
(
    id_lic          INT NOT NULL REFERENCES Licytacje(id),
    uzytkownik      VARCHAR(8) NOT NULL REFERENCES Uzytkownicy(login_u),
    data_oferty     DATE NOT NULL,
    godzina         TIME NOT NULL,
    kwota           FLOAT NOT NULL
   
);

INSERT INTO Uzytkownicy  VALUES
('userone', 'Andrzej', 'Kowalski', 'Botaniczna 33 Poznan', 'patryk.kowalski@gmail.com', NULL, NULL, NULL),
('izkaaa', 'Izabela', 'Nowacka', 'Wichrowe Wzgórze 33 Warszawa', 'izkaaa333@gmail.com', '31 0000 1223 7891 0000 0000 0000', NULL, '123456789'),
('tombur','Tomasz', 'Bursztyn','Dluga 12 Wroclaw','bursztynek123@wp.pl', '13 0000 6784 8736 2211 0000 0000', 'Dluga 12 Wroclaw', '987654321'),
('wer123','Weronika','Kowalska','Krotka 45 Pogorzelica','wer123@wp.pl', NULL, NULL, NULL);

INSERT INTO Dostawy VALUES
(1,'paczkomat','InPost', 12.99),
(2,'kurier', 'DPD', 15.78),
(3,'przesylka pocztowa', 'poczta Polska', 10.31);

INSERT INTO Przedmioty VALUES
(1,'userone', 0, 'he³m Szturmowca seria First Order','zabawka', 100.00, 'he³m mocowany na rzepy, usztywnione wnêtrze', NULL),
(2,'tombur', 2, 'bursztyny', 'ozdoba', 130.88, NULL, NULL),
(3,'userone', 0, 'Kolekcja filmów Star Wars na kasetach', 'filmy', 400.34, 'pierwsze wydanie z komentarzami G.Lucasa', 450.00),
(4,'userone',1,'kapelusz Indiana Jones', 'ozdoba', 389.32, 'reczne wykonanie', 500.00);

INSERT INTO Licytacje VALUES
(0, 1, NULL, 'zakoczona bez kupna', '2023-04-30', '2023-06-30'),
(1, 2, 'izkaa', 'zakonczona z kupnem', '2023-01-20', '2023-03-30'),
(2, 3, NULL, 'w trakcie', '2023-03-15', '2023-06-15'), 
(3, 4, 'wer123', 'zakoczona z kupnem', '2023-02-12', '2023-04-09');

INSERT INTO ZlozoneOferty VALUES
(2,'tombur', '2023-03-30', '08:47:32', 401.00),
(2, 'izkaa', '2023-04-02', '9:03:02', 402.00), 
(1, 'userone', '2023-03-02',' 14:28:39', 131.00),
(2, 'tombur', '2023-04-15', '22:41:38', 500.00),
(1, 'izkaa', '2023-03-29', '12:14:45', 135.00),
(3, 'tombur', '2023-03-17', '20:19:17', 400.00),
(3, 'wer123', '2023-04-01', '14:14:19', 500.00);

GO


SELECT * FROM dbo.Uzytkownicy
SELECT * FROM dbo.Przedmioty
SELECT * FROM dbo.Dostawy
SELECT * FROM dbo.Licytacje
SELECT * FROM dbo.ZlozoneOferty

SELECT *
FROM   INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE  TABLE_NAME IN ('Licytacje');

SELECT MAX(kwota) FROM ZlozoneOferty
