CREATE TABLE temp_table (
  SNo int DEFAULT NULL,
  Name_coin varchar(255) DEFAULT NULL,
  Symbol varchar(255) DEFAULT NULL,
  Date_Time varchar(255) DEFAULT NULL,
  High float DEFAULT NULL,
  Low float DEFAULT NULL,
  Market_Open float DEFAULT NULL,
  Market_Close float DEFAULT NULL,
  Volume int DEFAULT NULL,
  Market_cap float DEFAULT NULL
);

--Create Dim_date Table
CREATE TABLE Dim_Date (
Date_id int not null auto_increment,
Date_Time varchar(255),
Primary key(Date_id)
);


--Create Market table
CREATE TABLE Market (
Market_id int not null auto_increment,
Market_High float,
Market_Low float,
Market_Open float,
Market_Close float,
Market_Volume int,
Market_Cap float,
Primary key(Market_id)
);
--Create Dim_coin table
CREATE TABLE Dim_Coin (
Coin_id int not null auto_increment,
Coin_Name varchar(255),
Symbol varchar(255),
Primary key(Coin_id)
);

--Create fact table

CREATE table Fact_Table(
Fact_id int not null auto_increment,
Market_Volume int,
Market_Cap float,
Market_High float,
Primary key(Fact_id),
Coin_id int,
Market_id int,
Date_id int,
FOREIGN KEY(Coin_id) REFERENCES Dim_Coin (Coin_id) ON DELETE SET NULL,
FOREIGN KEY(Market_id) REFERENCES Market (Market_id) ON DELETE SET NULL,
FOREIGN KEY(Date_id) REFERENCES Dim_Date (Date_id) ON DELETE SET NULL
);


INSERT IGNORE INTO Dim_Coin ( Coin_name, Symbol)
SELECT DISTINCT Name_Coin, Symbol 
FROM temp_table;


INSERT IGNORE INTO Dim_Market( Market_High, Market_Low, Market_Open, Market_Close)
SELECT DISTINCT High, Low, Market_Open, Market_Close
FROM temp_tablet ;


INSERT IGNORE INTO Dim_Date( Date_Time)
SELECT DISTINCT Date_Time
FROM temp_table;


INSERT IGNORE INTO Fact_table(Market_Volume, Market_Cap , Market_High, Coin_id, Market_id, Date_id)
SELECT DISTINCT m.Market_Volume, m.Market_Cap , m.Market_High, c.Coin_id, m.Market_id, d.Date_id
FROM temp_table t
JOIN Market m ON m.Market_High=t.High
JOIN Dim_Coin c ON c.Coin_Name=t.Name_Coin
JOIN Dim_Date d ON d.Date_Time=t.Date_Time;



