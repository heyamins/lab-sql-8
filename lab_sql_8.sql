-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
use sakila;
select film_id,title,length,rank() over(order by length asc) as `rank` from film
where length is not null;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title,length,rating,rank() over(partition by rating order by length asc) as `rank` from film
where length is not null or length <> 0;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select f.category_id, count(f.film_id) from sakila.category c
join sakila.film_category f on c.category_id = f.category_id
group by f.category_id
order by f.category_id;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select * from sakila.film_actor a;

select a.actor_id, count(f.film_id) films from sakila.actor a
join sakila.film_actor f on a.actor_id=f.actor_id
group by a.actor_id
order by a.actor_id;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select r.customer_id, count(r.rental_id) rented_films from rental r
join sakila.customer c on r.customer_id=c.customer_id
group by r.customer_id
order by r.customer_id;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

select f.film_id,f.title,i.inventory_id,r.rental_id from film f
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id;

select f.title, count(r.rental_id) from film f
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
group by f.film_id
order by count(r.rental_id) desc;


