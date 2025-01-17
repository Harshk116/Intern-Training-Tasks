-- Q1: What is the title of the album with AlbumId 67?
SELECT Title 
FROM Album 
WHERE AlbumId = 67;
-- Q2: Find the name and length (in seconds) of all tracks that have a length between 50 and 70 seconds.
SELECT Name, Milliseconds / 1000 AS LengthInSeconds 
FROM Track 
WHERE Milliseconds / 1000 BETWEEN 50 AND 70;
-- Q3: List all the albums by artists with the word ‘black’ in their name.
SELECT Album.Title
FROM Album 
JOIN Artist ON Album.ArtistId = Artist.ArtistId 
WHERE Artist.Name LIKE '%black%';
-- Q4: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry 
FROM Invoice;
-- Q5: Display the city with the highest sum total invoice.
SELECT BillingCity, SUM(Total) AS TotalInvoice 
FROM Invoice 
GROUP BY BillingCity 
ORDER BY TotalInvoice DESC 
LIMIT 1;
-- Q6: Produce a table that lists each country and the number of customers in that country, in descending order.
SELECT Country, COUNT(CustomerId) AS CustomerCount 
FROM Customer 
GROUP BY Country 
HAVING CustomerCount > 0 
ORDER BY CustomerCount DESC;
-- Q7: Find the top five customers in terms of sales (total combined invoice amounts). Include their name, CustomerId, and total invoice amount.
SELECT Customer.CustomerId, Customer.FirstName || ' ' || Customer.LastName AS CustomerName, SUM(Invoice.Total) AS TotalSales 
FROM Customer 
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId 
GROUP BY Customer.CustomerId 
ORDER BY TotalSales DESC 
LIMIT 5;
-- Q8: Find the state-wise count of CustomerId and list the names of states with the count in decreasing order. Exclude rows where the state is NULL.
SELECT State, COUNT(CustomerId) AS CustomerCount 
FROM Customer 
WHERE State IS NOT NULL 
GROUP BY State 
ORDER BY CustomerCount DESC;
-- Q9: How many invoices were there in 2009 and 2011?
SELECT strftime('%Y', InvoiceDate) AS Year, COUNT(InvoiceId) AS InvoiceCount 
FROM Invoice 
WHERE Year IN ('2009', '2011') 
GROUP BY Year;
-- Q10: Provide a query showing only the Employees who are Sales Agents using LIKE.
SELECT EmployeeId, FirstName, LastName, Title 
FROM Employee 
WHERE Title LIKE '%Sales%' 
  AND Title LIKE '%Agent%';
