# 🎵 Music Store Data Analysis - SQL Project

This project is a comprehensive SQL-based analysis of a digital music store database. The dataset mimics a real-world schema of a music e-commerce platform and includes tables for customers, invoices, tracks, artists, genres, and more. The analysis is divided into three difficulty levels: **Easy**, **Moderate**, and **Advanced**, each with relevant business questions and SQL queries to extract actionable insights.

---

## 🗃️ Dataset Schema

The database includes the following key tables:

- `employee`: Employee details including job title and reporting hierarchy.
- `customer`: Customer demographic and contact information.
- `invoice`: Purchase information including invoice totals and billing country.
- `invoice_line`: Line-level details for each item in an invoice.
- `track`: Track-level metadata (name, genre, media type, album, artist).
- `album`: Album details with associated artist.
- `artist`: Artist names.
- `genre`: Music genres.
- `playlist`, `playlist_track`: Playlist definitions and associated tracks.
- `media_type`: File format or type of the music files.

> **Note:** Refer to the included ERD diagram (Entity Relationship Diagram) for a visual overview of the schema. ![ERD](./path_to_your_erd_image.png)

---

## ✅ Objectives

The goal of this project is to answer business-critical questions using SQL queries, enabling data-driven decisions such as identifying top customers, popular genres, and high-performing cities.

---

## 🧩 Question Sets

### 🔹 Question Set 1 – Easy

1. Who is the senior-most employee based on job title?
2. Which countries have the most invoices?
3. What are the top 3 values of total invoice?
4. Which city has the best customers? Return city name and total invoice sum.
5. Who is the best customer? Return customer with the highest total spending.

### 🔸 Question Set 2 – Moderate

1. List email, first name, last name & genre of all **Rock** music listeners, ordered by email.
2. List the top 10 **artists** who have written the most Rock tracks.
3. List all track names that are longer than the average song length, sorted by length.

### 🔺 Question Set 3 – Advanced

1. For each customer, how much money was spent on each **artist**?
2. What is the most popular **genre** in each country (by purchase count)? Return all genres in case of a tie.
3. Who is the **top-spending customer** in each country? Return all customers in case of a tie.

---

## 🔧 Tools Used

- **SQL (MySQL)** – Querying and data extraction
- **DBMS**: MySQL Workbench / SQLite / PostgreSQL (your choice)
- **ERD Tool**: dbdiagram.io / MySQL Workbench (for schema visualization)

---

## 📁 Project Structure

📦 music-store-sql-analysis
├── 📜 README.md
├── 📊 SQL_queries.sql # All SQL queries grouped by question set
├── 📸 music_store_schema.png # Schema / ERD image
└── 📂 analysis_outputs/ # Optional: CSV or screenshots of results

## 📝 How to Use

1. Clone the repository or download the project files.
2. Load the dataset into your SQL environment.
3. Run the SQL queries in `SQL_queries.sql` to explore answers.
4. Modify or extend queries to derive further insights.

---

## 🌟 Outcomes

By completing this project, you will learn:

- Intermediate to advanced SQL querying
- Use of `JOIN`, `GROUP BY`, `RANK()`, `ROW_NUMBER()`, and CTEs
- Analytical thinking for real business scenarios
- How to work with normalized relational databases

---

## 💡 Future Enhancements

- Connect with Power BI or Tableau for data visualization.
- Turn queries into stored procedures for reporting.
- Build an interactive dashboard.
