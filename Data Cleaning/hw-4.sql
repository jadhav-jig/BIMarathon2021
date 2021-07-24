-- duplicates 

SELECT coin_name, COUNT(*) AS CNT 
FROM dim_coin
GROUP BY coin_name
HAVING COUNT(*) > 1;

-- greatest

SELECT 
Fact_id, 
Market_Volume,
Market_Cap,
GREATEST(150, Market_high) as Market_High,
Coin_id
FROM Fact_Table;

-- distinct

select DISTINCT Market_Volume 
from fact_table
order by Market_Volume;

-- case

SELECT Fact_id,Market_Volume,
CASE WHEN Market_Volume > AVG(Market_Volume) THEN 'Bitcoin is trending today'
WHEN Market_Volume < AVG(Market_Volume) THEN 'Bitcoin is not trending today'
ELSE 'Bitcoin has average interest today'
END AS Market_Reaction
FROM Fact_Table
Group by Fact_id;


-- ADD NULL VALUES TO DIM COIN
INSERT INTO dim_coin
VALUES ("4",NULL,NULL);

-- add data for nullif

insert into dim_coin (coin_name, symbol)
values("DOLLAR", "USD");

-- NULLIF

SELECT Coin_id, 
NULLIF( Coin_Name, 'Dollar') as Coin_Name,
NULLIF(Symbol, 'USD') as symbol
From Dim_Coin;

-- COALESCE
select Coin_Name,
coalesce( coin_name, "New coin" ) as coin_name,
coalesce (symbol, "new symbol") as symbol
from Dim_coin;