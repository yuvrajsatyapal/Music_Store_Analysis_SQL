# Chinook Music Store SQL Project


## Overview

This project demonstrates the design, population, and querying of a sample music store database modeled after the Chinook dataset. It includes creating tables, inserting sample data, and performing various SQL queries to analyze music tracks, albums, artists, customers, invoices, and sales.

The database schema contains information about artists, albums, tracks, customers, invoices, and invoice line items.

---

## Database Schema

<img width="1178" height="633" alt="image" src="https://github.com/user-attachments/assets/33195f8d-6250-4932-816d-d01866296684" />

The database contains the following tables with their respective columns and relationships:

- **artists**
  - `ArtistId` (Primary Key)
  - `Name`

- **albums**
  - `AlbumId` (Primary Key)
  - `Title`
  - `ArtistId` (Foreign Key → artists)

- **tracks**
  - `TrackId` (Primary Key)
  - `Name`
  - `AlbumId` (Foreign Key → albums)
  - `Genre`
  - `UnitPrice`

- **customers**
  - `CustomerId` (Primary Key)
  - `FirstName`
  - `LastName`
  - `Country`

- **invoices**
  - `InvoiceId` (Primary Key)
  - `CustomerId` (Foreign Key → customers)
  - `InvoiceDate`
  - `Total`

- **invoice_items**
  - `InvoiceLineId` (Primary Key)
  - `InvoiceId` (Foreign Key → invoices)
  - `TrackId` (Foreign Key → tracks)
  - `UnitPrice`
  - `Quantity`

---

## Sample Data

The database is populated with sample data including:

- 10 artists (e.g., Adele, Ed Sheeran, Taylor Swift)
- Multiple albums linked to artists
- Tracks belonging to albums, categorized by genres such as Pop, Hip-Hop, Rock, etc.
- Customers from various countries
- Invoices and invoice items representing purchases of tracks by customers on specific dates

---

## SQL Queries

Here are some key example queries included in this project:

1. **List all tracks with their album and artist names**
2. **Find all customers from the USA**
3. **Count total tracks per genre**
4. **Find all albums created by Taylor Swift**
5. **Display invoices with customer full names**
6. **Top 5 most expensive tracks**
7. **Number of albums per artist**
8. **Total amount spent by each customer**
9. **Total sales revenue per country**
10. **Tracks purchased in July 2025**
11. **Top 3 selling artists by quantity sold**
12. **Most popular genre per country (by sales quantity)**
13. **Customers who purchased tracks from more than 3 genres**
14. **Month-over-month revenue growth for 2025**
15. **Album with highest total sales revenue**

---

## How to Use

1. Create the database and tables by running the provided `CREATE DATABASE` and `CREATE TABLE` statements.
2. Insert the sample data using the provided `INSERT INTO` statements.
3. Run the SQL queries to analyze the data and generate insights about sales, customers, artists, and music preferences.

---

## Technologies

- MySQL (or compatible SQL database)
- SQL queries for data manipulation and analysis

---

## Project Purpose

This project serves as an educational example of:

- Designing relational databases with foreign keys and constraints
- Populating databases with realistic sample data
- Writing and optimizing complex SQL queries involving joins, aggregations, window functions, and common table expressions (CTEs)
- Gaining insights from music store sales data using SQL analytics

---
