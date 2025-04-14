--Expolaratory Data analysis

SELECT *
FROM housing_levy2;

SELECT MAX(price)
FROM housing_levy2;


SELECT MAX(price),MAX(bedrooms),MAX(bathrooms)
FROM housing_levy2;


SELECT zipcode,count(id) AS total_houses
FROM housing_levy2
GROUP BY zipcode
ORDER BY total_houses DESC;


SELECT MIN(date),MAX(date)
FROM housing_levy2;

SELECT `date`,count(id)
FROM housing_levy2
GROUP BY `date`;


SELECT bedrooms,bathrooms,count(id) AS total_houses
FROM housing_levy2
GROUP BY bedrooms,bathrooms
ORDER BY total_houses DESC;




SELECT sqft_living,floors,count(id) AS total_houses
FROM housing_levy2
GROUP BY sqft_living,floors
ORDER BY total_houses DESC;


SELECT MONTHNAME(`date`) AS `Month`,count(id) AS total_houses
FROM housing_levy2
GROUP BY `Month`
ORDER BY total_houses DESC;




SELECT `condition`,grade,price
FROM housing_levy2
ORDER BY 1,2,3;


SELECT `condition`,grade,price,bedrooms,bathrooms,COUNT(id) OVER(PARTITION BY bedrooms,bathrooms ORDER BY bedrooms,bathrooms) AS num_houses
FROM housing_levy2;



SELECT COUNT(*)
FROM housing_levy2
WHERE waterfront>0 or view>0;

SELECT floors,price,sqft_living,sqft_above,sqft_lot,sqft_above,sqft_basement
FROM housing_levy2
ORDER BY 1,2 DESC;


SELECT floors,price,sqft_basement
FROM housing_levy2
ORDER BY 1,2 DESC;



SELECT MAX(`condition`),MAX(grade)
FROM housing_levy2;


SELECT MIN(`condition`),MIN(grade)
FROM housing_levy2;



SELECT count(id) AS total_houses,`condition`,grade
FROM housing_levy2
GROUP BY `condition`,grade
HAVING `condition`>8 OR grade>=2.5;


SELECT MAX(price),MIN(price)
FROM housing_levy2;


SELECT yr_built,bedrooms,bathrooms,floors,COUNT(*) OVER (PARTITION BY bedrooms,bathrooms,floors,`condition`,grade ORDER BY bedrooms,bathrooms,floors)AS houses_built
FROM housing_levy2;


SELECT YEAR(date) AS yearlysales,AVG(price)
FROM housing_levy2
GROUP BY yearlysales;



