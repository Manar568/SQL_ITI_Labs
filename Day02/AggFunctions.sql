 --Aggregate Functions  (Use World database) '
--2.1.  Calculate the total population for each continent. 
use World

select SUM(convert(bigint,c.Population))
from Country c
group by c.Continent




--2.2. Find the average life expectancy for each region. 

select AVG(c.LifeExpectancy),c.Region
from Country c
group by c.Region



--2.3. Determine the maximum and minimum surface area of countries on each continent. 

select max(c.SurfaceArea) max,MIN(c.SurfaceArea) min,c.Continent
from Country c 
group by c.Continent

--2.4. Count the number of cities in each country. 

select COUNT(ci.ID) , ci.CountryCode
from Country co inner join City ci
on co.Code =ci.CountryCode
group by ci.CountryCode

--2.5. Calculate the total and average GNP of all countries.

select AVG(c.GNP) avg,SUM(c.GNP) sum
from Country c