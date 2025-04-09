SELECT * FROM portfolio_project.`video game dataset`;

--Title that sold the most
--which year had the highest sales? Has the industry grown
--Do any consoles seem to specialize in a particulat gene
--what title are popular in one region but flop in another




SELECT title,console,genre,total_sales
From `video game dataset`
Order by 1,2;

--Looking at the title that sold the most

SELECT title,SUM(CONVERT(total_sales, CHAR)) as totaltitlesold
From `video game dataset`
GROUP BY title
Order by totaltitlesold DESC;


---Which year has the highest sales

SELECT SUBSTRING(release_date,7) AS year, SUM(CONVERT(total_sales, CHAR)) AS totalyearlysales
From `video game dataset`
GROUP BY year
ORDER BY totalyearlysales DESC;

--Do any consoles seem to specialize in a particular genre

SELECT DISTINCT console,genre,count(genre) over (Partition by console,genre) as totalgenrecount
From `video game dataset`
ORDER BY totalgenrecount desc;


--what titles are popular in one region but flop in another

SELECT DISTINCT(title),na_sales,jp_sales,pal_sales,other_sales
From `video game dataset`
Order by 2 DESC,3,4,5;





--CREATE VIEW FOR VISUALIZATION

CREATE VIEW titlesold_the_most AS
SELECT title,console,genre,total_sales
From `video game dataset`
Order by 1,2;


CREATE VIEW yearmostsold AS
SELECT SUBSTRING(release_date,7) AS year, SUM(CONVERT(total_sales, CHAR)) AS totalyearlysales
From `video game dataset`
GROUP BY year
ORDER BY totalyearlysales DESC;

CREATE VIEW titlevsregionsales AS
SELECT DISTINCT(title),na_sales,jp_sales,pal_sales,other_sales
From `video game dataset`;


CREATE VIEW Consolevsgenre AS
SELECT DISTINCT console,genre,count(genre) over (Partition by console,genre) as totalgenrecount
From `video game dataset`
ORDER BY totalgenrecount desc;
