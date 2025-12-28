# Social Networking Database – SQL Analysis Project

## Project Overview
This project is a SQL-based data analysis exercise built on a simulated **high school social networking database**.  
The goal is to demonstrate strong SQL skills by designing a relational schema, inserting sample data, and solving complex analytical queries using **MySQL**.

The project focuses on real-world SQL concepts such as:
- Multi-table joins
- Subqueries and correlated subqueries
- Aggregations and grouping
- EXISTS / NOT EXISTS logic
- Data cleanup using DELETE operations
- Handling MySQL-specific constraints

---

## Database Schema

### Tables

#### **Highschooler**
| Column | Type | Description |
|------|------|-------------|
| ID | INT | Unique student identifier |
| name | TEXT | Student first name |
| grade | INT | Grade level (9–12) |

#### **Friend**
| Column | Type | Description |
|------|------|-------------|
| ID1 | INT | Student ID |
| ID2 | INT | Friend’s student ID |

> Friendship is treated as **bidirectional**.

#### **Likes**
| Column | Type | Description |
|------|------|-------------|
| ID1 | INT | Student who likes |
| ID2 | INT | Student being liked |

---

## Data Population
The database is populated with:
- 16 students across grades 9–12
- Bidirectional friendship relationships
- Directed “likes” relationships to allow one-sided and mutual likes

---

## Analytical Queries Implemented

The project answers a wide range of analytical questions, including:

- Students who are friends with someone named **Gabriel**
- Students who like someone **two or more grades younger**
- Pairs of students who **mutually like each other**
- Students who **never appear** in the Likes table
- One-sided likes where the liked student has **no recorded likes**
- Students who have **friends only in the same grade**
- Students who like someone but are **not friends**, yet share a **mutual friend**
- Difference between total students and **distinct first names**
- Students who are liked by **more than one person**
- Love triangles (A likes B, B likes C)
- Students whose friends are **all in different grades**
- Average number of friends per student
- Students with the **highest number of friends**
- Data cleanup using DELETE with MySQL-safe subqueries

---

## Key SQL Concepts Demonstrated

- INNER JOIN and self-joins
- Subqueries and nested queries
- EXISTS and NOT EXISTS
- GROUP BY with HAVING
- DISTINCT filtering
- MySQL-specific DELETE constraints
- Data integrity reasoning

---

## Tools & Technologies
- **Database:** MySQL
- **Language:** SQL
- **Environment:** MySQL Workbench / Command Line

---

## Why This Project Matters
This project demonstrates the ability to:
- Think analytically about relational data
- Write clean, efficient SQL queries
- Handle real-world database logic and constraints
- Translate business-style questions into SQL solutions

It is suitable as a **portfolio project** for entry-level **Data Analyst** roles.

---

## Future Improvements
- Add primary and foreign key constraints
- Normalize schema further
- Convert queries to use CTEs (WITH clauses)
- Visualize insights using Power BI or Python

---

##  Author
**Faryal Rizwan**  
Aspiring Data Analyst  
Skills: SQL | Python | Power BI




