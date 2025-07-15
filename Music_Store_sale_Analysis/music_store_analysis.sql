SET SQL_SAFE_UPDATES = 0;
-- 1. Who is the senior most employee based on job title? 
select * from music.employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices? 
select billing_country , count(*) as total_invoice from music.invoice
group by billing_country
order by total_invoice desc;

-- 4. Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice 
-- totals 
select billing_city , sum(total) as total_invoice from music.invoice
group by billing_city
order by total_invoice desc
limit 1;

-- 5. Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 
 
select c.customer_id, c.first_name , c.last_name , sum(i.total) as max_invoice
from customer as c
left join invoice as i
on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by max_invoice desc
limit 1;

-- Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A 
select distinct email, first_name , last_name
from music.customer
join music.invoice on customer.customer_id = invoice.customer_id
join music.invoice_line on invoice.invoice_id = invoice_line.invoice_id 
where track_id in(
select track_id from music.track 
join music.genre on
track.genre_id = genre.genre_id
where genre.name = "Rock" )
order by email;

-- Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands
select artist.artist_id , artist.name , count(artist.artist_id) as number_of_song  from
music.artist join music.album2 on artist.artist_id = album2.artist_id
join music.track on album2.album_Id = track.album_id
where track_id in (
select track_id from music.track 
join music.genre on
track.genre_id = genre.genre_id
where genre.name Like 'Rock' )
group by artist.artist_id , artist.name
order by number_of_song desc;

-- Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first 
select name , milliseconds 
from music.track
where milliseconds > (
select avg(milliseconds) from music.track) 
order by milliseconds desc;

-- Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent 
with best_selling_artist as (select artist.artist_id as artist_id , artist.name as artist_name , sum(invoice_line.unit_price * invoice_line.quantity) as total_spent
from music.invoice_line 
join music.track on track.track_id = invoice_line.track_id
join music.album2 on album2.album_id = track.album_id
join music.artist on artist.artist_id = album2.artist_id
group by 1 , 2
order by 3 desc
limit 1)
select c.customer_id , c.first_name, c.last_name , bsa.artist_name, sum(il.unit_price*il.quantity) as spent
from music.invoice as i
join music.customer c on c.customer_id = i.customer_id
join music.invoice_line il on il.invoice_id = i.invoice_id
join music.track t on t.track_id= il.track_id
join music.album2 a on a.album_id = t.album_id 
join best_selling_artist bsa on  bsa.artist_id = a.artist_id
group by 1,2,3,4
order by 5 desc;

-- We want to find out the most popular music Genre for each country. We determine the 
-- most popular genre as the genre with the highest amount of purchases. Write a query 
-- that returns each country along with the top Genre. For countries where the maximum 
-- number of purchases is shared return all Genres 
with best_selling_country as
(select count(invoice_line.quantity) as purchases , customer.country , genre.name , genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as Rowno
from music.invoice_line
join music.invoice on invoice.invoice_id = invoice_line.invoice_id
join music.customer on customer.customer_id = invoice.customer_id
join music.track on track.track_id = invoice_line.track_id
join music.genre on genre.genre_id = track.genre_id
group by 2,3,4
order by 2 asc , 1 desc
)
select * from best_selling_country where Rowno <=1;

-- Write a query that determines the customer that has spent the most on music for each 
-- country. Write a query that returns the country along with the top customer and how 
-- much they spent. For countries where the top amount spent is shared, provide all 
-- customers who spent this amount
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        i.billing_country,
        SUM(i.total) AS total_spent
    FROM music.invoice i
    JOIN music.customer c ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country, i.billing_country
),
ranked_spending AS (
    SELECT 
        *,
        RANK() OVER(PARTITION BY billing_country ORDER BY total_spent DESC) AS rnk
    FROM customer_spending
)
SELECT 
    billing_country,
    first_name,
    last_name,
    total_spent
FROM ranked_spending
WHERE rnk = 1
ORDER BY billing_country;


