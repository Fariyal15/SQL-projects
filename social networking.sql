CREATE DATABASE social_networking;

USE social_networking;

create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

insert into Highschooler (ID , name, grade) values (1510, 'Jordan', 9),
(1689, 'Gabriel', 9),
(1381, 'Tiffany', 9),
(1709, 'Cassandra', 9),
(1101, 'Haley', 10),
(1782, 'Andrew', 10),
(1468, 'Kris', 10),
(1641, 'Brittany', 10),
(1247, 'Alexis', 11),
(1316, 'Austin', 11),
(1911, 'Gabriel', 11),
(1501, 'Jessica', 11),
(1304, 'Jordan', 12),
(1025, 'John', 12),
(1934, 'Kyle', 12),
(1661, 'Logan', 12);


insert into Friend (ID1, ID2) values (1510, 1381),
(1510, 1689),
(1689, 1709),
(1381, 1247),
(1709, 1247),
(1689, 1782),
(1782, 1468),
(1782, 1316),
(1782, 1304),
(1468, 1101),
(1468, 1641),
(1101, 1641),
(1247, 1911),
(1247, 1501),
(1911, 1501),
(1501, 1934),
(1316, 1934),
(1934, 1304),
(1304, 1661),
(1661, 1025);
insert into Friend select ID2, ID1 from Friend;


insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

/* Find the names of all students who are friends with someone named Gabriel.*/

SELECT name
FROM Highschooler
WHERE ID IN (SELECT ID1
FROM Friend
WHERE ID2 IN 
(SELECT ID
FROM Highschooler
WHERE name = "Gabriel")
UNION
SELECT ID2
FROM Friend
WHERE ID1 IN 
(SELECT ID
FROM Highschooler
WHERE name = "Gabriel"));

/* For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1
JOIN Likes L1
ON H1.ID = L1.ID1
JOIN Highschooler H2 
ON H2.ID = L1.ID2
WHERE H1.grade - H2.grade >= 2;

/* For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1
JOIN Likes L1
ON H1.ID = L1.ID1
JOIN Highschooler H2 
ON H2.ID = L1.ID2
WHERE L1.ID1 IN (SELECT ID2 FROM Likes) AND L1.ID2 IN (SELECT ID1 FROM Likes) AND H1.name < H2.name
ORDER BY H1.name, H2.name;

/* Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.*/
SELECT name, grade
FROM Highschooler
WHERE ID NOT IN (SELECT ID2 FROM Likes) AND ID NOT IN (SELECT ID1 FROM Likes);

/* For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1
JOIN LIKES L ON H1.ID = L.ID1 
JOIN Highschooler H2 ON H2.ID = L.ID2
WHERE L.ID2 NOT IN (SELECT ID1 FROM Likes)
ORDER BY H1.name, H2.name;

/* Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.*/
SELECT  H1.name, H1.grade
FROM Highschooler H1
WHERE NOT EXISTS (
   SELECT * 
FROM Friend F
JOIN Highschooler H2
ON (H1.ID = F.ID1 AND H2.ID = F.ID2) 
WHERE H1.grade <> H2.grade)
ORDER BY H1.grade, H1.name;

/* For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.*/
SELECT DISTINCT H1.name,H1.grade, H2.name,H2.grade,H3.name,H3.grade
FROM Likes L
JOIN Highschooler H1 ON L.ID1 = H1.ID
JOIN Highschooler H2 ON L.ID2 = H2.ID
JOIN Friend F1 ON F1.ID1 = H1.ID
JOIN Friend F2 ON F2.ID1 = H2.ID AND F1.ID2 = F2.ID2
JOIN Highschooler H3 ON H3.ID = F1.ID2
WHERE NOT EXISTS (SELECT *
FROM Friend F
WHERE (F.ID1 = H1.ID AND F.ID2 = H2.ID) OR (F.ID2 = H1.ID AND F.ID1 = H2.ID));

/* Find the difference between the number of students in the school and the number of different first names.*/
SELECT T.nID - T.nNAME
FROM 
(SELECT COUNT(ID) AS nID, COUNT(DISTINCT name) nNAME
FROM Highschooler) T;

/* Find the name and grade of all students who are liked by more than one other student.*/
SELECT DISTINCT name, grade
FROM Highschooler H
JOIN Likes L ON H.ID = L.ID2
WHERE H.ID IN 
(SELECT ID2
FROM Likes
GROUP BY ID2
Having Count(ID2) > 1);

/* For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.*/
SELECT  H1.name,H1.grade, H2.name,H2.grade,H3.name,H3.grade
FROM Likes L1
JOIN LIKES L2 ON L1.ID1 <> L2.ID2
JOIN Highschooler H1 ON L1.ID1 = H1.ID
JOIN Highschooler H2 ON L1.ID2 = H2.ID AND L1.ID2 = L2.ID1
JOIN Highschooler H3 ON H3.ID = L2.ID2
WHERE L1.ID2 IN (SELECT ID1 FROM Likes L2);

/* Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.*/
SELECT H1.name, H1.grade
FROM Highschooler H1
JOIN Highschooler H2
ON H1.ID < H2.ID AND H1.name < H2.name
JOIN Friend F 
ON H1.ID = F.ID1 AND H2.ID = F.ID2
WHERE H1.grade < H2.grade ;

/* What is the average number of friends per student? (Your result should be just one number.)*/
SELECT AVG(NF.num)/COUNT(ID)
FROM Highschooler, (SELECT COUNT(*) AS num
FROM Friend) NF;

/* Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.*/
SELECT COUNT(F1.ID1)
FROM Friend F1 
JOIN Highschooler H1 ON H1.ID = F1.ID2
JOIN Highschooler H2 ON H1.ID < H2.ID
JOIN Friend F2 ON  F1.ID2 = F2.ID1 AND H2.ID = F2.ID2 
WHERE H2.name = 'Cassandra' OR H1.name = 'Cassandra';

/* Find the name and grade of the student(s) with the greatest number of friends.*/
SELECT DISTINCT name, grade
FROM Highschooler
JOIN Friend
ON ID IN (SELECT ID1 
FROM Friend
GROUP BY ID1
HAVING COUNT(ID2) > 3)
ORDER BY name, grade;

/* It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
DELETE FROM highschooler  
WHERE ID IN (SELECT ID
FROM highschooler
WHERE grade = "12"
GROUP BY ID, name, grade);

/* If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.*/
DELETE FROM Likes
WHERE ID1 IN (SELECT L.ID1
FROM Likes L
JOIN Friend F
ON  F.ID1 = L.ID1 AND F.ID2 = L.ID2 AND L.ID2 NOT IN (SELECT ID1 FROM Likes L WHERE ID2 IN (SELECT ID1 FROM Likes))
GROUP BY L.ID1, L.ID2);