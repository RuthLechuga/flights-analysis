#Se crea la base de datos
CREATE DATABASE flights;
USE flights;

#Se usa una tabla temporal para import los set de datos en una misma tabla
CREATE TABLE temporal (
  `Year` int DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `DayofMonth` int DEFAULT NULL,
  `DayOfWeek` int DEFAULT NULL,
  `DepTime` varchar(50) DEFAULT NULL,
  `CRSDepTime` varchar(50) DEFAULT NULL,
  `ArrTime` varchar(50) DEFAULT NULL,
  `CRSArrTime` varchar(50) DEFAULT NULL,
  `UniqueCarrier` varchar(50) DEFAULT NULL,
  `FlightNum` varchar(50) DEFAULT NULL,
  `TailNum` varchar(50) DEFAULT NULL,
  `ActualElapsedTime` varchar(50) DEFAULT NULL,
  `CRSElapsedTime` varchar(50) DEFAULT NULL,
  `AirTime` varchar(50) DEFAULT NULL,
  `ArrDelay` varchar(50) DEFAULT NULL,
  `DepDelay` varchar(50) DEFAULT NULL,
  `Origin` varchar(50) DEFAULT NULL,
  `Dest` varchar(50) DEFAULT NULL,
  `Distance` varchar(50) DEFAULT NULL,
  `TaxiIn` varchar(50) DEFAULT NULL,
  `TaxiOut` varchar(50) DEFAULT NULL,
  `Cancelled` varchar(50) DEFAULT NULL,
  `CancellationCode` varchar(50) DEFAULT NULL,
  `Diverted` varchar(50) DEFAULT NULL,
  `CarrierDelay` varchar(50) DEFAULT NULL,
  `WeatherDelay` varchar(50) DEFAULT NULL,
  `NASDelay` varchar(50) DEFAULT NULL,
  `SecurityDelay` varchar(50) DEFAULT NULL,
  `LateAircraftDelay` varchar(50) DEFAULT NULL
);

#Se crea la tabla que contendra la información limpia
#DROP TABLE information
CREATE TABLE information (
  `Year` int DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `DayofMonth` int DEFAULT NULL,
  `DayOfWeek` int DEFAULT NULL,
  `DepTime` int DEFAULT NULL,
  `DepTimeHour` int DEFAULT NULL,
  `DepTimeMinutes` int DEFAULT NULL,
  `CRSDepTime` int DEFAULT NULL,
  `CRSDepTimeHour` int DEFAULT NULL,
  `CRSDepTimeMinutes` int DEFAULT NULL,
  `ArrTime` int DEFAULT NULL,
  `ArrTimeHour` int DEFAULT NULL,
  `ArrTimeMinutes` int DEFAULT NULL,
  `CRSArrTime` int DEFAULT NULL,
  `CRSArrTimeHour` int DEFAULT NULL,
  `CRSArrTimeMinutes` int DEFAULT NULL,
  `UniqueCarrier` varchar(5) DEFAULT NULL,
  `FlightNum` int DEFAULT NULL,
  `TailNum` varchar(10) DEFAULT NULL,
  `ActualElapsedTime` int DEFAULT NULL,
  `CRSElapsedTime` int DEFAULT NULL,
  `AirTime` int DEFAULT NULL,
  `ArrDelay` int DEFAULT NULL,
  `DepDelay` int DEFAULT NULL,
  `Origin` varchar(5) DEFAULT NULL,
  `Dest` varchar(5) DEFAULT NULL,
  `Distance` int DEFAULT NULL,
  `TaxiIn` int DEFAULT NULL,
  `TaxiOut` int DEFAULT NULL,
  `Cancelled` binary DEFAULT NULL,
  `CancellationCode` varchar(10) DEFAULT NULL,
  `Diverted` binary DEFAULT NULL,
  `CarrierDelay` int DEFAULT NULL,
  `WeatherDelay` int DEFAULT NULL,
  `NASDelay` int DEFAULT NULL,
  `SecurityDelay` int DEFAULT NULL,
  `LateAircraftDelay` int DEFAULT NULL
);
SELECT COUNT(*) FROM temporal;

#Se limpia la información
INSERT INTO information
SELECT t.`Year`,
	t.`Month`,
	t.`DayofMonth`,
	t.`DayOfWeek`,
	CASE 
		WHEN t.DepTime = 'NA'  THEN NULL
		ELSE t.DepTime
	END DepTime,
	CASE 
		WHEN t.DepTime = 'NA'  THEN NULL
		WHEN (t.DepTime DIV 100) = 24 THEN 0 
		ELSE (t.DepTime DIV 100)
	END DepTimeHour,
	CASE 
		WHEN t.DepTime = 'NA'  THEN NULL
		ELSE (t.DepTime MOD 100)
	END DepTimeMinutes,
	t.CRSDepTime,
	CASE 
		WHEN t.CRSDepTime = 'NA'  THEN NULL
		WHEN (t.CRSDepTime DIV 100) = 24 THEN 0 
		ELSE (t.CRSDepTime DIV 100)
	END CRSDepTimeHour,
	CASE 
		WHEN t.CRSDepTime = 'NA'  THEN NULL
		ELSE (t.CRSDepTime MOD 100)
	END CRSDepTimeMinutes,
	CASE 
		WHEN t.ArrTime  = 'NA'  THEN NULL
		ELSE t.ArrTime
	END ArrTime,
	CASE 
		WHEN t.ArrTime = 'NA'  THEN NULL
		WHEN (t.ArrTime DIV 100) = 24 THEN 0 
		ELSE (t.ArrTime DIV 100)
	END ArrTimeHour,
	CASE 
		WHEN t.ArrTime = 'NA'  THEN NULL
		ELSE (t.ArrTime MOD 100)
	END ArrTimeMinutes,
	t.CRSArrTime,
	CASE 
		WHEN t.CRSArrTime = 'NA'  THEN NULL
		WHEN (t.CRSArrTime DIV 100) = 24 THEN 0 
		ELSE (t.CRSArrTime DIV 100)
	END CRSArrTimeHour,
	CASE 
		WHEN t.CRSArrTime = 'NA'  THEN NULL
		ELSE (t.CRSArrTime MOD 100)
	END CRSArrTimeMinutes,
	t.UniqueCarrier,
	t.FlightNum,
	t.TailNum,
	CASE 
		WHEN t.ActualElapsedTime  = 'NA'  THEN NULL
		ELSE CAST(t.ActualElapsedTime AS SIGNED)
	END ActualElapsedTime,
	CASE 
		WHEN t.CRSElapsedTime  = 'NA'  THEN NULL
		ELSE CAST(t.CRSElapsedTime AS SIGNED)
	END CRSElapsedTime,
	CASE 
		WHEN t.AirTime  = 'NA'  THEN NULL
		ELSE CAST(t.AirTime AS SIGNED)
	END AirTime,
	CASE 
		WHEN t.ArrDelay  = 'NA'  THEN NULL
		WHEN CAST(t.ArrDelay AS SIGNED) < 0 THEN 0
		ELSE CAST(t.ArrDelay AS SIGNED)
	END ArrDelay,
	CASE 
		WHEN t.DepDelay  = 'NA'  THEN NULL
		WHEN CAST(t.DepDelay AS SIGNED) < 0 THEN 0
		ELSE CAST(t.DepDelay AS SIGNED)
	END DepDelay,
	t.Origin,
	t.Dest,
	t.Distance,
	CASE 
		WHEN t.TaxiIn = 'NA'  THEN NULL
		ELSE CAST(t.TaxiIn AS SIGNED)
	END TaxiIn,
	CASE 
		WHEN t.TaxiOut = 'NA'  THEN NULL
		ELSE CAST(t.TaxiOut AS SIGNED)
	END TaxiOut,
	CASE 
		WHEN t.Cancelled = 'NA'  THEN NULL
		ELSE CAST(t.Cancelled AS BINARY)
	END Cancelled,
	CASE 
		WHEN t.CancellationCode  = 'NA'  THEN NULL
		ELSE t.CancellationCode
	END CancellationCode,
	CASE 
		WHEN t.Diverted = 'NA'  THEN NULL
		ELSE CAST(t.Diverted AS BINARY)
	END Diverted,
	CASE 
		WHEN t.CarrierDelay = 'NA'  THEN NULL
		ELSE CAST(t.CarrierDelay AS SIGNED)
	END CarrierDelay,
	CASE 
		WHEN t.WeatherDelay = 'NA'  THEN NULL
		ELSE CAST(t.WeatherDelay AS SIGNED)
	END WeatherDelay,
	CASE 
		WHEN t.NASDelay = 'NA'  THEN NULL
		ELSE CAST(t.NASDelay AS SIGNED)
	END NASDelay,
	CASE 
		WHEN t.SecurityDelay = 'NA'  THEN NULL
		ELSE CAST(t.SecurityDelay AS SIGNED)
	END SecurityDelay,
	CASE 
		WHEN t.LateAircraftDelay = 'NA'  THEN NULL
		ELSE CAST(t.LateAircraftDelay AS SIGNED)
	END LateAircraftDelay
FROM temporal t;

SELECT * FROM flights.information LIMIT 100;
SELECT * FROM flights.information WHERE CancellationCode IS NOT NULL;

#------------------------------------------------------------------------------------------------------------------------
#¿Mejor hora del día para valor y minimizar las demoras?
#Se filtran los vuelos que no son cancelados => f.Cancelled = 0
#Se filtra por los vuelos que los tiempos de retraso de salida y llegado son 0 => f.ArrDelay = 0 and f.DepDelay = 0
#Se realiza un group by por los datos de interes

#Mejoras horas 2000
SELECT f.DepTimeHour, count(*) FlightsOnTime
FROM flights.information f
WHERE f.Cancelled = 0
	and f.ArrDelay = 0
	and f.DepDelay = 0
	and f.year = 2000
GROUP BY f.DepTimeHour
ORDER BY count(*) DESC;
	
#Mejoras horas 2001
SELECT f.DepTimeHour, count(*) FlightsOnTime
FROM flights.information f
WHERE f.Cancelled = 0
	and f.ArrDelay = 0
	and f.DepDelay = 0
	and f.year = 2001
GROUP BY f.DepTimeHour
ORDER BY count(*) DESC;

#Mejoras horas 2002
SELECT f.DepTimeHour, count(*) FlightsOnTime
FROM flights.information f
WHERE f.Cancelled = 0
	and f.ArrDelay = 0
	and f.DepDelay = 0
	and f.year = 2002
GROUP BY f.DepTimeHour
ORDER BY count(*) DESC;

#Mejoras horas en general
#Se ve la cantidad de vuelos en general a esa hora, la cantidad de vuelos que salen y llegan a tiempo, el porcentaje de vuelos a tiempo
SELECT on_time.TimeHour TimeHour
	, on_time.FlightsOnTime FlightsOnTime
	, total.FlightTotal FlightTotal
	, (on_time.FlightsOnTime/total.FlightTotal)*100 PercentageOnTime
FROM
(SELECT f.DepTimeHour TimeHour, count(*) FlightsOnTime
FROM flights.information f
WHERE f.Cancelled = 0
	and f.ArrDelay = 0
	and f.DepDelay = 0
GROUP BY f.DepTimeHour) on_time 
join (SELECT f.DepTimeHour TimeHour, count(*) FlightTotal
FROM flights.information f
WHERE f.Cancelled = 0
GROUP BY f.DepTimeHour) total on on_time.TimeHour = total.TimeHour
ORDER BY on_time.FlightsOnTime/total.FlightTotal DESC

#------------------------------------------------------------------------------------------------------------------------
#¿Los aviones viejos sufren más demora?

#------------------------------------------------------------------------------------------------------------------------
#¿Cómo cambia el número de personas volando entre las distintas localidades a lo largo del tiempo?
SELECT to_from_locations.Origin
	, to_from_locations.Destination
	, total_2000.Total Total2000
	, total_2001.Total Total2001
	, total_2002.Total Total2002
FROM (SELECT DISTINCT  f.Origin Origin, f.Dest Destination
FROM flights.information f) to_from_locations
LEFT JOIN (SELECT f.Origin Origin, f.Dest Destination, count(*) Total
FROM flights.information f
WHERE f.year = 2000
GROUP BY f.Origin, f.Dest) total_2000 on to_from_locations.Origin = total_2000.Origin and to_from_locations.Destination = total_2000.Destination
LEFT JOIN (SELECT f.Origin Origin, f.Dest Destination, count(*) Total
FROM flights.information f
WHERE f.year = 2001
GROUP BY f.Origin, f.Dest) total_2001 on to_from_locations.Origin = total_2001.Origin and to_from_locations.Destination = total_2001.Destination
LEFT JOIN (SELECT f.Origin Origin, f.Dest Destination, count(*) Total
FROM flights.information f
WHERE f.year = 2002
GROUP BY f.Origin, f.Dest) total_2002 on to_from_locations.Origin = total_2002.Origin and to_from_locations.Destination = total_2002.Destination
ORDER BY total_2002.Total DESC
	
#------------------------------------------------------------------------------------------------------------------------
#¿El análisis del clima puede predecir las demoras?

#------------------------------------------------------------------------------------------------------------------------
#¿Puede alguna falla o demora en una aeropuerto causar fallas en los demás? ¿Cuáles son los aeropuertos más críticos en ese sentido?




