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

/*SELECT in SELECT*/

/* #1.Bigger than Russia*/
SELECT name FROM world
WHERE population >(SELECT population FROM world 
WHERE name='Russia')

/* #2.Richer than UK*/
SELECT name 
FROM world
WHERE continent = 'Europe' AND gdp/population > 38555.0739

/* #3.Neighbours of Argentina and Austalia*/
SELECT name, continent
FROM world
WHERE continent = 'South America' or continent = 'Oceania' ORDER BY name

/* #4.Bretween Canada and Poland*/
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
 AND population < (SELECT population FROM world WHERE name = 'Poland')

/* #5.Percentages of Germany*/
SELECT name, CONCAT(CAST(ROUND((population/(SELECT population FROM world WHERE name='Germany'))*100,0) AS INT),'%')
FROM world
WHERE continent = 'Europe'

/* #6.Bigger than every country in Europe*/
SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent='Europe')

/* #7.Largest in each continent*/
SELECT continent, name, area 
FROM world x
WHERE area >= ALL(SELECT area 
FROM world y
WHERE y.continent=x.continent AND area>0)

/* #8.First country of each continent (alphabetically)*/
SELECT continent, name
FROM world x
WHERE name <= ALL (SELECT name FROM world y WHERE x.continent=y.continent)

/* #9.Difficult Questions That Utilize Techniques Not Covered In Prior Sections*/
SELECT name, continent, population
FROM world
WHERE continent IN (SELECT continent FROM world x WHERE 25000000 >= ALL (SELECT population FROM world y WHERE x.continent = y.continent))

/* #10.Difficult Questions That Utilize Techniques Not Covered In Prior Sections*/
SELECT name, continent
FROM world x
WHERE population > ALL (SELECT population*3 FROM world y WHERE x.continent=y.continent AND x.name != y.name)

/*SUM and COUNT*/

/* #1.Total world population*/
SELECT SUM(population)
FROM world

/* #2.List of continents*/
SELECT continent
FROM world
GROUP BY continent

/* #3.GDP of Africa*/
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'

/* #4.Count the big countries*/
SELECT COUNT(name)
FROM world
WHERE area > 1000000

/* #5.Baltic states population*/
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

/* #6.Counting the countries of each contient*/
SELECT continent, COUNT(name)
FROM world
GROUP BY continent

/* #7.Counting big countries in each contient*/
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent

/* #8.Counting big contients*/
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000

/*JOIN*/

/* #1.*/
SELECT matchid, player FROM goal 
WHERE teamid = 'GER'

/* #2.*/
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012

/* #3.*/
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id = matchid)
WHERE teamid = 'GER'

/* #4.*/
SELECT team1, team2, player
FROM game JOIN goal ON (id = matchid)
WHERE player LIKE 'Mario%'

/* #5.*/
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (teamid = id)
WHERE gtime <= 10

/* #6.*/
SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos'

/* #7.*/
SELECT player
FROM goal JOIN game ON (matchid = id)
WHERE stadium = 'National Stadium, Warsaw'

/* #8.*/
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'GER' AND team2 = teamid) OR (team1 = teamid AND team2 = 'GER')

/* #9.*/
SELECT teamname, COUNT(teamid)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

/* #10.*/
SELECT stadium, COUNT(matchid)
FROM game JOIN goal ON id=matchid
GROUP BY stadium

/* #11.*/
SELECT matchid, mdate, COUNT(matchid)
FROM game JOIN goal ON (id = matchid) 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

/* #12.*/
SELECT matchid, mdate, COUNT(matchid)
FROM game JOIN goal ON (id = matchid) 
WHERE (teamid = 'GER')
GROUP BY matchid, mdate

/* #13.*/
SELECT mdate, team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON id = matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2

/*More JOIN*/

/* #1.1962 movie*/
SELECT id, title
FROM movie
WHERE yr=1962

/* #2.When was Citizen Kane released?*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

/* #3.Star Trek movies*/
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'

/* #4.id for actor Glenn Close*/
SELECT id
FROM actor
WHERE name = 'Glenn Close'

/* #5.id for Casablanca*/
SELECT id
FROM movie
WHERE title = 'Casablanca'

/* #6.Cast list for Casablanca*/
SELECT name
FROM actor JOIN casting ON id = actorid
WHERE movieid = 27

/* #7.Alien cast list*/
SELECT name
FROM actor 
JOIN casting ON actor.id = actorid
JOIN movie ON movieid = movie.id
WHERE title = 'Alien'

/* #8.Harrison Ford movies*/
SELECT title
FROM movie 
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE name = 'Harrison Ford'

/* #9.Harrison Ford as a supporting actor*/
SELECT title
FROM movie 
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE name = 'Harrison Ford' AND ord != 1

/* #10.Lead actors in 1962 movies*/
SELECT title, name
FROM movie 
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE yr = 1962 AND ord = 1

/* #11.Busy years for Rock Hudson*/
SELECT yr, COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/* #12.Lead actor in Julie Andrews movies*/
SELECT title, name 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE title IN (SELECT DISTINCT title
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name = 'Julie Andrews')
AND ord = 1

/* #13.Actors with 15 leading roles*/
SELECT DISTINCT name
FROM actor 
JOIN casting ON actor.id=actorid
WHERE actorid IN (SELECT actorid
FROM casting
WHERE ord = 1
GROUP BY actorid
HAVING COUNT(actorid) > 14)

/* #14.*/
SELECT title, COUNT(actorid)
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title ASC

/* #15.*/
SELECT name 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE title IN (SELECT DISTINCT title
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name = 'Art Garfunkel')
AND name != 'Art Garfunkel'

/*Using NULL*/

/* #1.*/
SELECT name
FROM teacher
WHERE dept IS NULL

/* #2.*/
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)

/* #3.*/ 
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

/* #4.*/
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)

/* #5.*/
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher

/* #6.*/
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON (dept=dept.id)

/* #7.*/
SELECT COUNT(name), COUNT(mobile)
FROM teacher

/* #8.*/
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON (dept=dept.id)
GROUP BY dept.name

/* #9.*/
SELECT name,
CASE WHEN dept IN (1,2) THEN 'Sci' ELSE 'Art' END
FROM teacher

/* #10.*/
SELECT name,
CASE WHEN dept IN (1,2) THEN 'Sci'
WHEN dept IN (3) THEN 'Art'
ELSE 'None' END
FROM teacher

/*Self JOIN*/

/* #1.*/
SELECT COUNT(id)
FROM stops

/* #2.*/
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

/* #3.*/
SELECT id, name 
FROM stops JOIN route ON (id=stop) 
WHERE company='LRT' AND num='4'

/* #4.*/
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

/* #5.*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

/* #6.*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

/* #7.*/
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

/* #8.*/
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON (a.num=b.num AND a.company=b.company)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

/* #9.*/
SELECT stopa.name, a.company, a.num
FROM route a JOIN route b ON (a.num=b.num AND a.company=b.company)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopb.name = 'Craiglockhart'


