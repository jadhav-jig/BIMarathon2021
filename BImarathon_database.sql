CREATE database BI_Marathon;
 
Use BI_Marathon;
 
CREATE TABLE temp_table (
  SNo int not null auto_increment,
  Name_coin varchar(255),
  Symbol varchar(255),
  Date_Time varchar(255),
  High float,
  Low float,
  Market_Open float ,
  Market_Close float,
  Volume int,
  Market_cap float,
  Primary key (SNo)
  );


-- Create Market table
CREATE TABLE Market (

Market_id int not null auto_increment,
Market_High float,
Market_Low float,
Market_Open float,
Market_Close float,
Primary key(Market_id)
);

-- Create Dim_coin table
CREATE TABLE Dim_Coin (
Coin_id int not null auto_increment,
Coin_Name varchar(255),
Symbol varchar(255),
Primary key(Coin_id)
);

-- Create fact table

CREATE table Fact_Table(
Fact_id int not null auto_increment,
Market_Volume int,
Market_Cap float,
Market_High float,
Coin_id int,
Market_id int,
Primary key(Fact_id),
FOREIGN KEY(Coin_id) REFERENCES Dim_Coin (Coin_id) ON DELETE SET NULL,
FOREIGN KEY(Market_id) REFERENCES Market (Market_id) ON DELETE SET NULL
);

INSERT IGNORE INTO Dim_Coin ( Coin_name, Symbol)
SELECT DISTINCT Name_Coin, Symbol 
FROM temp_table;

INSERT IGNORE INTO Market( Market_High, Market_Low, Market_Open, Market_Close)
SELECT DISTINCT High, Low, Market_Open, Market_Close
FROM temp_table;




INSERT IGNORE INTO Fact_table(Market_Volume, Market_Cap, Market_High , Coin_id, Market_id)

SELECT DISTINCT t.Volume, t.Market_Cap , t.high, c.Coin_id, m.Market_id
FROM temp_table t
JOIN Market m ON m.Market_High=t.High
JOIN Dim_Coin c ON c.Coin_Name=t.Name_Coin;

Truncate table fact_table;

select * from fact_table;

