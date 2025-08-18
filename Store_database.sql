CREATE DATABASE IF NOT EXISTS Chinook;
USE Chinook;

CREATE TABLE artists (
    ArtistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);

CREATE TABLE albums (
    AlbumId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES artists(ArtistId)
);

CREATE TABLE tracks (
    TrackId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    AlbumId INT,
    Genre VARCHAR(50),
    UnitPrice DECIMAL(5,2),
    FOREIGN KEY (AlbumId) REFERENCES albums(AlbumId)
);

CREATE TABLE customers (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE invoices (
    InvoiceId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    InvoiceDate DATE,
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES customers(CustomerId)
);

CREATE TABLE invoice_items (
    InvoiceLineId INT PRIMARY KEY AUTO_INCREMENT,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(5,2),
    Quantity INT,
    FOREIGN KEY (InvoiceId) REFERENCES invoices(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES tracks(TrackId)
);
