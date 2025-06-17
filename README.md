# ✈️ Air Cargo Analysis - SQL Project

This repository contains the **Course-End Project for SQL Training** titled **"Air Cargo Analysis"** from Simplilearn.

---

## 🎯 Project Objectives

The aim of this project is to:
- Analyze the busiest air routes to determine aircraft requirements
- Identify regular customers for targeted offers
- Improve operational efficiency and enhance customer-centric services

---

## 🧰 Tech Stack

- **Database**: MySQL / SQL Server
- **Tools**: SQL Views, Functions, Procedures, Cursors, Window Functions, Constraints
- **Data Visualization (Optional)**: Power BI, Tableau (for post-analysis)

---

## 🗃️ Dataset Overview

| Table Name               | Description                                 |
|--------------------------|---------------------------------------------|
| `customer`              | Customer personal information               |
| `passengers_on_flights` | Travel history of passengers                |
| `ticket_details`        | Ticket booking, class, pricing, brand info |
| `routes`                | Route distance and flight metadata          |

---

## 📌 Tasks Overview

Below is a summary of the key tasks and SQL features used:

| # | Task | SQL Concepts |
|--|------|--------------|
| 1 | Create ER Diagram | Entity Relationships |
| 2 | Create `route_details` table | `CREATE TABLE`, `CHECK`, `UNIQUE` |
| 3 | Passengers on routes 01–25 | `SELECT`, `WHERE` |
| 4 | Business class revenue & count | `GROUP BY`, `SUM()` |
| 5 | Full customer name | `CONCAT()` |
| 6 | Registered + booked customers | `JOIN` |
| 7 | Customers who used Emirates | `WHERE`, `JOIN` |
| 8 | Grouped Economy Plus travelers | `GROUP BY`, `HAVING` |
| 9 | Revenue > 10000 | `IF` condition |
| 10 | Create and grant user access | `CREATE USER`, `GRANT` |
| 11 | Max ticket price per class | `WINDOW FUNCTION`, `RANK()` |
| 12 | Optimize query for route ID = 4 | `INDEX`, `EXPLAIN` |
| 13 | Execution plan for route ID = 4 | `EXPLAIN PLAN` |
| 14 | Total price per customer | `ROLLUP` |
| 15 | View for business class customers | `CREATE VIEW` |
| 16 | Procedure: Passengers between route range | `PROCEDURE`, `IF NOT EXISTS` |
| 17 | Procedure: Distance > 2000 | `PROCEDURE` |
| 18 | Procedure: Categorize route distances | `CASE`, `GROUP BY` |
| 19 | Complimentary service via function | `FUNCTION`, `IF` |
| 20 | Cursor for customer with last name Scott | `CURSOR`, `FETCH` |

---

## 📂 Folder Structure

