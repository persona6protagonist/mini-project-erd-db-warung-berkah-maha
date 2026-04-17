CREATE DATABASE DB_WarungBerkah;
USE DB_WarungBerkah;
CREATE TABLE Supplier (
    ID_Supplier VARCHAR(10) PRIMARY KEY,
    Nama_Supplier VARCHAR(100) NOT NULL,
    Nomor_Kontak VARCHAR(20),
    Tahun_Mulai_Kontrak INT
);
CREATE TABLE Cabang (
    ID_Cabang VARCHAR(10) PRIMARY KEY,
    Alamat_Cabang VARCHAR(100),
    ID_Supplier VARCHAR(10),
    FOREIGN KEY (ID_Supplier) REFERENCES Supplier(ID_Supplier)
);
CREATE TABLE Faktur (
    ID_Faktur VARCHAR(10) PRIMARY KEY,
    Tanggal_Pesan DATE,
    Tanggal_Terima DATE,
    Lama_Proses INT GENERATED ALWAYS AS (DATEDIFF(Tanggal_Terima, Tanggal_Pesan)) STORED,
    ID_Supplier VARCHAR(10),
    FOREIGN KEY (ID_Supplier) REFERENCES Supplier(ID_Supplier)
);
CREATE TABLE Barang (
    ID_Barang VARCHAR(10) PRIMARY KEY,
    Nama_Barang VARCHAR(100),
    Harga_Beli INT,
    Harga_Jual INT,
    Margin INT GENERATED ALWAYS AS (Harga_Jual - Harga_Beli) STORED,
    ID_Faktur VARCHAR(10),
    FOREIGN KEY (ID_Faktur) REFERENCES Faktur(ID_Faktur)
);
SELECT * FROM Supplier;
SELECT * FROM Cabang;
SELECT * FROM Faktur;
SELECT * FROM Barang;
INSERT INTO Supplier Values
('SUP01', 'PT Sumber Jaya Makmur', '123', 2018),
('SUP02', 'PT Snack Jaya', '456', 2020);
INSERT INTO Cabang VALUES
('CB01', 'Sukabumi', 'SUP01'),
('CB02', 'Solo', 'SUP01'),
('CB03', 'Cirebon', 'SUP01'),
('CB04', 'Depok', 'SUP02'),
('CB05', 'Bekasi', 'SUP02');
INSERT INTO Faktur (ID_Faktur, Tanggal_Pesan, Tanggal_Terima, ID_Supplier) VALUES
('FK01', '2026-01-10', '2026-01-15', 'SUP01'),
('FK02', '2026-02-15', '2026-02-17', 'SUP01'),
('FK03', '2026-03-01', '2026-03-02', 'SUP02');
INSERT INTO Barang (ID_Barang, Nama_Barang, Harga_Beli, Harga_Jual, ID_Faktur) VALUES
('BR01', 'Beras Premium', 10000, 12000, 'FK01'),
('BR02', 'Minyak Goreng', 14000, 16500, 'FK01'),
('BR03', 'Sabun Mandi', 3000, 4500, 'FK02'),
('BR04', 'Keripik Kentang', 8000, 11000, 'FK03');
SELECT 
    s.Nama_Supplier,
    c.Alamat_Cabang,
    f.ID_Faktur,
    f.Tanggal_Pesan,
    f.Tanggal_Terima,
    f.Lama_Proses,
    b.Nama_Barang,
    b.Harga_Beli,
    b.Harga_Jual,
    b.Margin
FROM Supplier s
JOIN Cabang c ON s.ID_Supplier = c.ID_Supplier
JOIN Faktur f ON s.ID_Supplier = f.ID_Supplier
JOIN Barang b ON f.ID_Faktur = b.ID_Faktur;


