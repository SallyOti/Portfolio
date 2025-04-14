-- Data cleaning

SELECT * FROM housinglevy.`housing dataset`;

--1. Remove duplicates
--2. standardize data
--3. Null values or blank values
--4. remove any columns or rows



CREATE TABLE Housing_levy
LIKE `housing dataset`;

SELECT *
FROM Housing_levy;

INSERT INTO Housing_levy
SELECT * FROM `housing dataset`;


--Remove duplicate

SELECT *,ROW_NUMBER() OVER(PARTITION BY id,lat,zipcode,`long`) AS row_num
FROM housing_levy;


WITH duplicate_CTE AS 
(SELECT *,ROW_NUMBER() OVER(PARTITION BY id,lat,zipcode,`long`) AS row_num
FROM housing_levy)

SELECT *
FROM duplicate_CTE
WHERE row_num>1;


SELECT *
FROM housing_levy
WHERE id="1000102";


WITH duplicate_CTE AS 
(SELECT *,ROW_NUMBER() OVER(PARTITION BY id,lat,zipcode,`long`) AS row_num
FROM housing_levy)





CREATE TABLE `housing_levy2` (
  `id` bigint DEFAULT NULL,
  `date` text,
  `price` int DEFAULT NULL,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` double DEFAULT NULL,
  `sqft_living` int DEFAULT NULL,
  `sqft_lot` int DEFAULT NULL,
  `floors` int DEFAULT NULL,
  `waterfront` int DEFAULT NULL,
  `view` int DEFAULT NULL,
  `condition` int DEFAULT NULL,
  `grade` int DEFAULT NULL,
  `sqft_above` int DEFAULT NULL,
  `sqft_basement` int DEFAULT NULL,
  `yr_built` int DEFAULT NULL,
  `yr_renovated` int DEFAULT NULL,
  `zipcode` int DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `long` double DEFAULT NULL,
  `sqft_living15` int DEFAULT NULL,
  `sqft_lot15` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM Housing_levy2;

INSERT INTO Housing_levy2
SELECT *,ROW_NUMBER() OVER(PARTITION BY id,lat,zipcode,`long`) AS row_num
FROM housing_levy;



DELETE
FROM Housing_levy2
WHERE row_num>1;

SELECT *
FROM Housing_levy2;



--Standardizing data

SELECT `date`,DATE(`date`) AS dateformat
FROM Housing_levy2;


UPDATE Housing_levy2
SET `date`= DATE(`date`);


ALTER TABLE Housing_levy2
MODIFY COLUMN `date` DATE;


--NULL VALUES -(The dataset has no null or blank values)


SELECT t1.price,t1.bedrooms,t1.bathrooms,t1.date,t1.id,t2.id
FROM Housing_levy2 as t1
JOIN Housing_levy2 AS t2 ON t1.id=t2.id
AND t1.zipcode=t2.zipcode;



ALTER TABLE housing_levy2
DROP COLUMN row_num;
