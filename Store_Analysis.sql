USE Chinook;

-- List all the tracks along with their album name and artist name.
SELECT t.Name , a.Title, ar.Name
FROM tracks AS t, albums AS a, artists AS ar
WHERE t.AlbumId = a.AlbumId AND ar.ArtistId = a.ArtistId;

-- Find all customers from the USA.
SELECT CustomerId, FirstName, LastName, Country
FROM customers 
WHERE Country = 'USA';

-- Show the total number of tracks in each genre.
SELECT Genre, COUNT(Genre) AS 'No. of tracks'
FROM tracks
GROUP BY Genre;

-- Find all albums created by “Taylor Swift.”
SELECT a.Title 
FROM albums as a
JOIN artists ar
ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'Taylor Swift';


-- Display all invoices along with the full name of the customer who made the purchase.
SELECT i.InvoiceId, CONCAT(c.FirstName ,' ', c.LastName) AS 'FullName'
FROM customers c
JOIN invoices i
ON c.CustomerId = i.CustomerId;

-- Find the top 5 most expensive tracks.
SELECT Name, UnitPrice
FROM tracks
ORDER BY UnitPrice DESC
LIMIT 5;


-- Show the number of albums per artist.
SELECT ar.Name, COUNT(a.Title) AS 'No. of albums'
FROM artists ar
JOIN albums as a
ON ar.ArtistId = a.ArtistId
GROUP BY ar.Name;

-- List customers and the total amount they have spent.
SELECT CONCAT(c.FirstName , ' ', c.LastName) AS 'Full_Name', SUM(i.total) AS 'Amount_Spent'
FROM customers c
JOIN invoices i
ON c.CustomerId = i.CustomerId
GROUP BY i.CustomerId;

-- Find the total sales revenue for each country.
SELECT c.Country AS 'Country', SUM(i.total) AS 'Revenue'
FROM customers c
LEFT JOIN invoices i
ON c.CustomerId = i.CustomerId
GROUP BY c.Country;

-- Show all tracks purchased in July 2025.
SELECT t.Name AS 'Track_Name'
FROM invoice_items it
INNER JOIN tracks AS t ON it.TrackId = t.TrackId
INNER JOIN invoices AS i ON i.InvoiceId = it.InvoiceId
WHERE i.InvoiceDate >= '2025-07-01' AND i.InvoiceDate < '2025-08-01';

-- Find the top 3 selling artists based on total quantity sold.
SELECT ar.Name AS 'Artist_Name'
FROM artists ar
INNER JOIN albums AS ab ON ar.ArtistId = ab.ArtistId
INNER JOIN tracks AS t ON t.AlbumId = ab.AlbumId
INNER JOIN invoice_items AS i ON t.TrackId = i.TrackId
GROUP BY ar.Name
ORDER BY SUM(i.Quantity) DESC
LIMIT 3;


-- List the most popular genre for each country (by sales quantity).

WITH GenrePopularity AS (
		SELECT 
        t.Genre,
        c.Country,
        SUM(it.Quantity) AS TotalSales
        FROM tracks t
        INNER JOIN invoice_items AS it ON t.TrackId = it.TrackId
		INNER JOIN invoices AS i ON it.InvoiceId = i.InvoiceId
		INNER JOIN customers AS c ON i.CustomerId = c.CustomerId
        GROUP BY t.Genre, c.Country
),
RankedGenre AS (
		SELECT 
        Genre,
        Country,
        TotalSales,
        RANK() OVER (PARTITION BY Country ORDER BY TotalSales DESC) AS rnk
        FROM GenrePopularity
)
SELECT Country, Genre , TotalSales 
FROM RankedGenre
WHERE rnk = 1
ORDER BY Country;

-- Find customers who have purchased tracks from more than 3 different genres.
SELECT CONCAT(c.FirstName,' ', c.LastName) AS 'Full_Name'
FROM customers c
INNER JOIN invoices AS i ON c.CustomerId = i.CustomerId
INNER JOIN invoice_items AS it ON i.InvoiceId = it.InvoiceId
INNER JOIN tracks AS t ON t.TrackId = it.TrackId
GROUP BY c.CustomerId
HAVING COUNT(DISTINCT t.Genre) > 3;

-- Show the month-over-month revenue growth for 2025.
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(i.InvoiceDate, '%Y-%m') AS month,
        SUM(ii.UnitPrice * ii.Quantity) AS total_revenue
    FROM invoices i
    JOIN invoice_items ii ON i.InvoiceId = ii.InvoiceId
    WHERE YEAR(i.InvoiceDate) = 2025
    GROUP BY DATE_FORMAT(i.InvoiceDate, '%Y-%m')
)
SELECT 
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY month)) 
        / LAG(total_revenue) OVER (ORDER BY month) * 100, 
        2
    ) AS growth_percentage
FROM monthly_revenue
ORDER BY month;


-- Find the album with the highest total sales revenue.
SELECT ab.Title AS 'TITLE', SUM(ii.UnitPrice * ii.Quantity) AS TotalRevenue
FROM albums ab
INNER JOIN tracks AS t ON t.AlbumId = ab.AlbumId
INNER JOIN invoice_items AS ii ON t.TrackId = ii.TrackId
GROUP BY ab.AlbumId, ab.Title
ORDER BY TotalRevenue DESC
LIMIT 1;



