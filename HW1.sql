#Assignment: SQL Select and Aggregations
#Please use the tables in the flights database. Your deliverable should include the SQL queries that you write in
#support of your conclusions.

#1. Which destination in the flights database is the furthest distance away, based on information in the flights table.
#Show the SQL query(s) that support your conclusion.

#The longest flight is from John F Kennedy Intl airport to Honolulu Intl.

select distinct o.name as origin, d.name as destination, distance
from flights fl
join airports d on d.faa = fl.dest 
join airports o on o.faa = fl.origin
join (select max(distance) as md from flights) mfl on mfl.md = fl.distance
order by distance desc;


#2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have
#the most number of seats? Show the SQL statement(s) that support your result.

#There are 1,2,3, and 4 engine planes

select distinct engines from planes order by engines asc
;
#The DEHAVILLAND	OTTER DHC-3 has the most seats (16) for a 1 engine plane
#The BOEING 777-222,777-200,777-224, and the 777-232 have the most seats (400) for 2 engine planes
#The AIRBUS A330-223 has the most seats (379) for 3 engine planes
#The BOEING 747-451 has the most seats(450) for a 4 engine plane

select distinct manufacturer, model, engines, seats from(
select year, manufacturer, model, engines, max(seats) over(partition by engines) as most_seats, seats
from planes p) x where most_seats = seats
;

#3. Show the total number of flights.

#336,776 flights

select count(flight) from flights 
;

#4. Show the total number of flights by airline (carrier).

select count(flight), fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
group by fl.carrier, air.name
;
#58665	UA	United Air Lines Inc.
#32729	AA	American Airlines Inc.
#54635	B6	JetBlue Airways
#48110	DL	Delta Air Lines Inc.
#54173	EV	ExpressJet Airlines Inc.
#26397	MQ	Envoy Air
#20536	US	US Airways Inc.
#12275	WN	Southwest Airlines Co.
#5162	VX	Virgin America
#3260	FL	AirTran Airways Corporation
#714	AS	Alaska Airlines Inc.
#18460	9E	Endeavor Air Inc.
#685	F9	Frontier Airlines Inc.
#342	HA	Hawaiian Airlines Inc.
#601	YV	Mesa Airlines Inc.
#32	OO	SkyWest Airlines Inc.
;

select count(flight), fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
group by fl.carrier, air.name
;
#5. Show all of the airlines, ordered by number of flights in descending order.

select * from (
select count(flight) as flights, fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
group by fl.carrier, air.name) x order by flights desc


#58665	UA	United Air Lines Inc.
#54635	B6	JetBlue Airways
#54173	EV	ExpressJet Airlines Inc.
#48110	DL	Delta Air Lines Inc.\
#32729	AA	American Airlines Inc.
#26397	MQ	Envoy Air
#20536	US	US Airways Inc.
#18460	9E	Endeavor Air Inc.
#12275	WN	Southwest Airlines Co.
#5162	VX	Virgin America
#3260	FL	AirTran Airways Corporation
#714	AS	Alaska Airlines Inc.
#685	F9	Frontier Airlines Inc.
#601	YV	Mesa Airlines Inc.
#342	HA	Hawaiian Airlines Inc.
#32	OO	SkyWest Airlines Inc.

#6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
;
select * from (
select count(flight) as flights, fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
group by fl.carrier, air.name) x order by flights desc limit 5
;
#58665	UA	United Air Lines Inc.
#54635	B6	JetBlue Airways
#54173	EV	ExpressJet Airlines Inc.
#48110	DL	Delta Air Lines Inc.
#32729	AA	American Airlines Inc.

#7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of
#flights in descending order.

select * from (
select count(flight) as flights, fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
where distance >= 1000
group by fl.carrier, air.name) x order by flights desc limit 5
;
#41135	UA	United Air Lines Inc.
#30022	B6	JetBlue Airways
#28096	DL	Delta Air Lines Inc.
#23583	AA	American Airlines Inc.
#6248	EV	ExpressJet Airlines Inc.

#8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and
#write down both the question, and the query that answers the question.

#Find the bottom 10 airlines by the average distance of their flights


select * from (
select avg(distance) as average_dist, fl.carrier, air.name as airline_name
from flights fl join airlines air on air.carrier = fl.carrier
group by fl.carrier, air.name) x order by flights asc limit 10

#375.0333	YV	Mesa Airlines Inc.
#500.8125	OO	SkyWest Airlines Inc.
#530.2358	9E	Endeavor Air Inc.
#553.4563	US	US Airways Inc.
#562.9917	EV	ExpressJet Airlines Inc.
#569.5327	MQ	Envoy Air
#664.8294	FL	AirTran Airways Corporation
#996.2691	WN	Southwest Airlines Co.
#1068.6215	B6	JetBlue Airways
#1236.9012	DL	Delta Air Lines Inc.




