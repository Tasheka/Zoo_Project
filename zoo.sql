/*SELECT basics*/

/* #1.Introducing the world table of countries*/
SELECT population FROM world
  WHERE name = 'Germany'

/* #2.Scandinavia*/
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

/* #3.Just the right size */
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

/*SELECT from WORLD*/

/* #1.Introduction*/
SELECT name, continent, population FROM world

/* #2.Large Countries*/
SELECT name
  FROM world
 WHERE population > 200000000

/* #3.Per capita GDP*/
SELECT name, gdp/population
FROM world
WHERE population > 200000000

/* #4.South America in Millions*/
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'

/* #5.France, Germany, Italy*/
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')

/* #6.United*/
SELECT name
FROM world
WHERE name LIKE '%United%'

/* #7.Two ways to be big*/
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000

/* #8.One or the other (but nnot both)*/
SELECT name, population, area
FROM world
WHERE ((area > 3000000) AND NOT (population > 250000000)) OR
((population > 250000000) AND NOT (area > 3000000))

/* #9.Rounding*/
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2)
FROM  world
WHERE continent LIKE 'South America'

/* #10.Trillion dollar economies*/
SELECT name, ROUND(gdp/population,-3)
FROM world
WHERE gdp > 1000000000000

/* #11.Name and capital have the same length*/
SELECT name, capital
  FROM world
 WHERE LEN(name) = LEN(capital)

/* #12.Matching name and capital*/
SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name<>capital

/* #13.All the vowels*/
SELECT name
FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' 
AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'

/*SELECT from Nobel*/

/* #1.Winners from 1950*/
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

/* #2.1962 Literature*/
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

/* #3.Albert Einstein*/
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

/* #4.Recent Peace Prizes*/
SELECT winner
FROM nobel
WHERE yr > 1999 AND subject = 'Peace'

/* #5.Literature in the 1980's*/
SELECT *
FROM nobel
WHERE subject = 'Literature' AND yr > 1979 AND yr < 1990

/* #6.Only Presidents*/
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter',
 'Barack Obama')

/* #7.John*/
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

/* #8.Chemistry and Physics from different years*/
SELECT *
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry'
 AND yr = 1984)

/* #9.Exclude Chemists and Medics*/
SELECT *
FROM nobel
WHERE yr = 1980 AND NOT subject = 'Chemistry' AND NOT subject = 'Medicine'

/* #10.Early Medicine, Late Literature*/
SELECT *
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
 OR (subject = 'Literature' AND yr > 2003) 

/* #11.Umlaut*/
SELECT * 
FROM nobel
WHERE winner = 'Peter Grünberg'

/* #12.Apostrophe*/
SELECT * 
FROM nobel
WHERE winner = 'Eugene O''Neill'

/* #13.Knights of the Realm*/
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner

/* #14.Chemistry and Physics last*/
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject,winner