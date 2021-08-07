-- cte

WITH randoms AS (
SELECT m.Market_id, AVG(m.Market_High)-m.Market_open as average_difference
FROM Fact_Table f join market m on f.market_id=m.market_id
group by m.market_id
)

SELECT m.market_close, r.market_id, r.average_difference, market_high
FROM market m
JOIN randoms r
ON m.Market_id = r.Market_id;


-- recursive cte



-- pivot with case when


-- self join

-- window fxn

-- calculate running total

SELECT Market_id, Coin_id, Sum(Market_volume)
  OVER (PARTITION BY market_id, coin_id 
        ORDER BY Date_Time)
  AS total_run
FROM Fact_table
where coin_id=2;

-- calculate delta values
SELECT Fact_id, Market_cap , Date_time,
Market_Volume, LAG(Market_Volume)
OVER (ORDER BY Date_time ) AS previous_day 

FROM Fact_table
WHERE coin_id = 2
ORDER BY Date_Time;

-- except vs not 

SELECT market_id, Market_Open, Market_high FROM Market
where market_id not in 
(SELECT market_id FROM fact_table WHERE market_volume > 100000);


-- date time manipulation