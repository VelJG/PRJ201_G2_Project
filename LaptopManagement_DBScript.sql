USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'LaptopManagement')
BEGIN
	ALTER DATABASE [LaptopManagement] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [LaptopManagement] SET ONLINE;
	DROP DATABASE [LaptopManagement];
END

CREATE DATABASE LaptopManagement
GO
USE LaptopManagement
GO

CREATE TABLE [Account](
	id INT IDENTITY(1,1) PRIMARY KEY,
	email VARCHAR(50) NOT NULL UNIQUE,
	password NVARCHAR(256) NOT NULL, 
	fullName NVARCHAR(50) NOT NULL,
	role VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN', 'USER'))
);
GO

CREATE TABLE [Laptop](
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(255) NOT NULL,
	brand NVARCHAR(50) NOT NULL,
	model NVARCHAR(255) NOT NULL,
	price FLOAT NOT NULL,
	[description] NVARCHAR(255)
);
GO

CREATE TABLE [OrderHeader](
    id INT IDENTITY(1,1) PRIMARY KEY,
    accountId INT NOT NULL,
    orderDate DATETIME NOT NULL,
    totalPrice FLOAT,
    [status] NVARCHAR(255),
    FOREIGN KEY (accountId) REFERENCES Account(id)
);
GO

CREATE TABLE [OrderDetail](
    id INT IDENTITY(1,1) PRIMARY KEY,
    orderHeaderId INT NOT NULL,
    laptopId INT NOT NULL,
    quantity INT NOT NULL,
    price FLOAT,
    FOREIGN KEY (orderHeaderId) REFERENCES OrderHeader(id),
    FOREIGN KEY (laptopId) REFERENCES Laptop(id)
);
GO

INSERT INTO Account (email, password, fullName, role) VALUES
('admin@gmail.com', '6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B', N'Administrator', 'ADMIN'),
('user@gmail.com', '6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B', N'User', 'USER'),
('john@gmail.com', '6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B', N'John Smith', 'USER')
GO

INSERT INTO [Laptop] (name, brand, model, price, description) VALUES 
('Vivobook 15', 'Asus', 'X1504ZA-NJ517W', 13990000, 'DDR4, 16GB, Intel Core i5-1235U (1.3 GHz, 12M Cache, up to 4.4 GHz, 10 lõi), 15.6 inches'),
('Nitro V', 'Acer', 'ANV15-51-58AN', 16690000, 'DDR5, 16GB, Intel Core i5-13420H (8 lõi / 12 luồng, up to 4.60 GHz, 12 MB Intel Smart Cache), 15.6 inches'),
('Macbook Air M2', 'Apple', 'Air M2', 23490000, 'NULL, 16GB, Apple M2 8 nhân, 13.6 inches'),
('Macbook Air M1', 'Apple', 'Air M1', 17090000, 'LPDDR4, 8GB, Apple M2 8 nhân, 13.3 inches'),
('Aspire Lite 16', 'Acer', 'AL16-51P-55N7', 13490000, 'DDR5, 16GB, Intel Core i5-1235U (10 lõi / 12 luồng, 3.3 GHz 4.4 GHz 12MB Intel Smart Cache), 16 inches'),
('LOQ', 'Lenovo', '15IAX9', 20990000, 'DDR5, 12GB, Intel Core i5-12450HX (8 lõi (4P + 4E) / 12 luồng, P-core up to 4.4GHz, E-core up to 3.1GHz, 12MB), 15.6 inches'),
('Vivobook', 'Asus', 'K3605ZF-RP634W', 17490000, 'DDR4, 16GB, Intel Core i5-12500H 2.5 GHz (18M Cache, up to 4.5 GHz, 4P+8E cores), 16 inches'),
('Modern 14', 'MSI', 'C12MO-660VN', 11690000, 'DDR4, 16GB, Intel Core i5-1235U (10 lõi / 12 luồng, Up to 4.4GHz), 14 inches'),
('Nitro 5 Tiger', 'Acer', 'AN515-58-52SP', 18990000, 'DDR4, 8GB, Intel Core i5-12500H (upto 4.5 GHz, 18MB), 12 nhân, 16 luồng, 15.6 inches'),
('Inspiron 15 3520', 'Dell', '6R6NK', 13490000, 'DDR4, 8GB, Intel Core i5-1235U (10 lõi / 12 luồng, 1.30 GHz to 4.40 GHz, 12 MB), 15.6 inches'),
('Laptop HP 15S-FQ5231TU', 'HP', '8U241PA', 9690000, 'DDR4, 8GB, Core i3 1215U 1.2GHz, Turbo tối đa 4.4ghz (6 nhân, 8 luồng), 15.6 inches'),
('Aspire Lite Gen 2', 'Acer', 'AL14-52M-32KV', 9990000, 'DDR5, 8GB, Intel Core i3-1305U (5 lõi / 6 luồng, 3.3 GHz, 4.5 GHz, 10 MB Intel Smart Cache), 14 inches'),
('Zenbook 14 OLED', 'Asus', 'UX3405MA-PP151W', 26490000, 'LPDDR5X, 16GB, Intel Core Ultra 5 125H 1.2 GHz (18MB Cache, tối đa 4.5 GHz, 14 nhân, 18 luồng); Intel® AI Boost NPU, 14 inches'),
('Modern 15', 'MSI', 'B7M-238VN', 12990000, 'DDR4, 16GB, AMD Ryzen 7 7730U (2.0 GHz up to 4.3 GHz, 8 lõi / 16 luồng, 24 MB), 15.6 inches'),
('TUF Gaming A15', 'Asus', 'FA506NFR-HN006W', 17990000, 'DDR5, 16GB, AMD Ryzen 7 7435HS 3.1 - 4.5 GHz, 15.6 inches'),
('TUF Gaming F15', 'Asus', 'FX507ZC4-HN095W', 20490000, 'DDR4, 16GB,  Intel Core i5-12500H 2.5 GHz (18M Cache, up to 4.5 GHz, 12 lõi: 4 P-cores và 8 E-cores), 15.6 inches'),
('Aspire Lite 16', 'Acer', 'AL16-51P-72S2', 15990000, 'DDR5, 16GB, Intel Core i7-1255U (10 lõi / 12 luồng, 3.5 GHz, turbo boost 4.7 GHz, 12 MB Intel Smart Cache), 16 inches'),
('Pavilion 15-EG2083TU', 'HP','7C0W9PA', 15490000, 'DDR4, 8GB, Intel Core i5-1240P thế hệ thứ 12, 15.6 inches'),
('ThinkPad E14 GEN 5', 'Lenovo','21JK006BVN', 19790000, 'DDR4, 16GB, Intel Core i5-1335U, 10C (2P + 8E) / 12T, P-core 1.3 / 4.6GHz, E-core 0.9 / 3.4GHz, 12MB, 14 inches'),
('Aspire 7 Gaming', 'Acer','A715-76G-5806', 18990000, 'DDR4, 16GB, Intel Core i5 - 12450H (8 lõi / 12 luồng, 2.00 GHz, Turbo Boost 4.4 GHz, 12 MB), 15.6 inches'),
('Ideapad 1', 'Lenovo','14ALC7', 10990000, 'DDR4, 16GB, AMD Ryzen 5 5625U (6 lõi / 12 luồng, 2.3 / 4.3GHz, 3MB L2 / 16MB L3), 14 inches'),
('Nitro V 15 ProPanel', 'Acer','ANV15-41-R7AP', 19490000, 'DDR5, 16GB, AMD Ryzen 5 7535HS (6 lõi, 12 luồng, 3.3GHz, 4.55GHz, 3MB L2 cache, 16MB L3 cache), 15.6 inches'),
('Aspire 3', 'Acer','A315-59-381E', 9490000, 'DDR4, 8GB, Intel Core i3 - 1215U (1.2 GHz - 4.4GHz / 10MB / 6 nhân / 8 luồng), 15.6 inches'),
('Nitro 5 Tiger', 'Acer','AN515-58-50D2', 20490000, 'DDR5, 16GB, Intel Core i5-12500H (12 lõi / 16 luồng, 4.5 GHz, 18 MB Intel Smart Cache), 15.6 inches'),
('Swift Go 14 AI', 'Acer','SFG14-73-53X7', 22990000, 'LPDDR5X, 16GB, Intel Core Ultra 5-125H (3.6 GHz - 4.5 GHz / 18MB / 14 nhân, 18 luồng), 14 inches'),
('Zenbook 14 OLED', 'Asus','UX3405MA-PP152W', 31490000, 'LPDDR5X, 32GB, Intel Core Ultra 7 155H, 14 inches'),
('Aspire 5 Spin 14', 'Acer','A5SP14-51MTN-78JH', 16990000, 'LPDDR5, 16GB, Intel Core i7-1355U (3.7 Ghz, up to 5.0 GHz, 24MB cache), 14 inches'),
('Katana 15', 'MSI','B13VFK-676VN', 26690000, 'DDR5, 16GB, Intel Core i7-13620H (3.6GHz~4.9GHz, 10 lõi / 16 luồng), 15.6 inches'),
('IdeaPad Slim 3', 'Lenovo','15ABR8', 12990000, 'DDR4, 16GB, AMD Ryzen 5 7430U (6C / 12T, 2.3 / 4.3GHz, 3MB L2 / 16MB L3), 15.6 inches'),
('ROG Strix G16', 'Asus','G614JU-N3135W', 32990000, 'DDR5, 16GB, Intel Core i7-13650HX (2.6 GHz 24M Cache, up to 4.9 GHz, 14 lõi: 6 P-cores and 8 E-cores), 16 inches');
GO

INSERT INTO [OrderHeader] (accountId, orderDate, totalPrice) VALUES
(1, '2025-01-22', 50000000),
(2, '2025-02-23', 40000000),
(1, '2025-03-03', 34000000),
(3, '2025-03-05', 60000000);
GO

INSERT INTO [OrderDetail] (orderHeaderId, laptopId, quantity, price) VALUES
(1, 1, 1, 13490000),
(1, 2, 2, 13490000),
(2, 1, 1, 13490000),
(2, 2, 1, 13490000),
(3, 1, 2, 13490000),
(3, 2, 1, 13490000),
(4, 1, 3, 13490000);
GO