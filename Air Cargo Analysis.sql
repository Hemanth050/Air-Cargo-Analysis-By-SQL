-- 1. Create an ER diagram for the given airlines database.

-- 2. Write a query to create route_details table using suitable data types for the fields, such as route_id, flight_num, origin_airport, destination_airport,
-- aircraft_id, and distance_miles. Implement the check constraint for the flight number and unique constraint for the route_id fields.
-- Also, make sure that the distance miles field is greater than 0.
create table route_details as(
select 
      distinct(route_id),
      flight_num,
      origin_airport,
      destination_airport,
      aircraft_id,
      distance_miles
from routes 
where distance_miles > 0)


-- 3. Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. Take data  from the passengers_on_flights table.
select
      * 
from 
passengers_on_flights
where route_id between 1 and 25
order by route_id asc


-- 4. Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
select 
      sum(no_of_tickets) as passengers,
      sum(no_of_tickets*Price_per_ticket) as revenue
from ticket_details
where class_id = 'Bussiness'
 
      
-- 5. Write a query to display the full name of the customer by extracting the first name and last name from the customer table.
select 
      concat(first_name, ' ', last_name) as Full_Name 
from 
customer
-- 6. Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.
select
      *
from customer c
join ticket_details t on c.customer_id = t.customer_id 
-- 7. Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.
select 
      first_name,
      last_name,
      brand
from customer c 
join ticket_details t on c.customer_id = t.customer_id
where brand = 'Emirates'
-- 8. Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table.
SELECT 
    customer_id
FROM passengers_on_flights
GROUP BY customer_id
HAVING SUM(CASE WHEN class_id = 'Economy Plus' THEN 1 ELSE 0 END) > 0;

-- 9. Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.
select
      if(sum(no_of_tickets*Price_per_ticket)> 10000, 'yes','No') as crossed
from ticket_details

-- 10. Write a query to create and grant access to a new user to perform operations on a database.
-- 1. Create a new user
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'your_password';

GRANT ALL PRIVILEGES ON `air cargo analysis`.* TO 'new_user'@'localhost';


-- 3. Apply changes
FLUSH PRIVILEGES;


-- 11. Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.
select
      distinct class_id,
      max(Price_per_ticket) over ( partition by class_id) as max_price
from ticket_details


-- 12. Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.
SELECT customer_id, aircraft_id, class_id
FROM passengers_on_flights
WHERE route_id = 4;


-- 13.For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.
SELECT customer_id, aircraft_id, class_id
FROM passengers_on_flights
WHERE route_id = 4;

/*14.Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.*/
select 
      customer_id,
      sum(Price_per_ticket)
from
ticket_details
group by customer_id with rollup;


/*15. Write a query to create a view with only business class customers along with the brand of airlines.*/
create view Business_class_Customers as
select 
customer_id,
brand
from 
ticket_details
where class_id =  'Bussiness'  
select * from Business_class_Customers

/*16. Write a query to create a stored procedure to get the details of all passengers flying between a range of routes defined in run time. 
Also, return an error message if the table doesn't exist.*/
 
DELIMITER //

CREATE PROCEDURE GetPassengersByRouteRange(IN start_route INT, IN end_route INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: passengers_on_flights table is missing or another SQL error occurred.' AS error_message;
    END;

    -- Attempt the query
    SELECT *
    FROM routes
    WHERE route_id BETWEEN start_route AND end_route;
END //

DELIMITER ;

CALL GetPassengersByRouteRange(2, 5);





/*17. Write a query to create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.*/
delimiter //
create procedure routestabel()
begin 
     select * 
     from
     routes 
     where distance_miles >= 2000;
end //

call routestabel()
/*18. Write a query to create a stored procedure that groups the distance travelled by each flight into three categories. 
The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500.*/
delimiter //
create procedure categories()
begin
     select *,
     case 
     when distance_miles between 0 and 2000 then 'sdt'
     when distance_miles between 2000 and 6500 then 'idt'
     when distance_miles > 6500 then 'ldt'
     end
	 from 
     routes;
end //

call categories()

DELIMITER //



DELIMITER //

CREATE PROCEDURE categorize_distance_travel()
BEGIN
    SELECT 
        flight_num,
        distance_miles,
        CASE
            WHEN distance_miles BETWEEN 0 AND 2000 THEN 'SDT'   -- Short Distance Travel
            WHEN distance_miles > 2000 AND distance_miles <= 6500 THEN 'IDT'  -- Intermediate Distance Travel
            WHEN distance_miles > 6500 THEN 'LDT'  -- Long Distance Travel
            ELSE 'Unknown'
        END AS distance_category
    FROM routes;
END //

DELIMITER ;
CALL categorize_distance_travel();

/*19. Write a query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific class using a stored function in stored procedure on the ticket_details table.
Condition:
• If the class is Business and Economy Plus, then complimentary services are given as Yes, else it is No*/
DELIMITER //

CREATE FUNCTION get_complimentary_status(class_name VARCHAR(50))
RETURNS VARCHAR(3)
DETERMINISTIC
BEGIN
    DECLARE status VARCHAR(3);
    IF class_name IN ('Business', 'Economy Plus') THEN
        SET status = 'Yes';
    ELSE
        SET status = 'No';
    END IF;
    RETURN status;
END;
//

DELIMITER ;
DELIMITER //

CREATE PROCEDURE get_ticket_info_with_services()
BEGIN
    SELECT 
        p_date AS purchase_date,
        customer_id,
        class_id,
        get_complimentary_status(class_id) AS complimentary_services
    FROM ticket_details;
END;
//

DELIMITER ;
CALL get_ticket_info_with_services();



/*    20. Write a query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table.*/
select *
from 
customer
where last_name = 'Scott'


DELIMITER //

CREATE PROCEDURE get_first_scott_customer()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_customer_id INT;
    DECLARE c_first_name VARCHAR(100);
    DECLARE c_last_name VARCHAR(100);

    DECLARE cur CURSOR FOR 
        SELECT customer_id, first_name, last_name 
        FROM customer 
        WHERE last_name LIKE '%Scott' 
        ORDER BY customer_id ASC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    FETCH cur INTO c_customer_id, c_first_name, c_last_name;

    IF NOT done THEN
        SELECT c_customer_id AS customer_id, c_first_name AS first_name, c_last_name AS last_name;
    ELSE
        SELECT 'No customer found with last name ending Scott' AS message;
    END IF;

    CLOSE cur;
END //

DELIMITER ;
CALL get_first_scott_customer();
