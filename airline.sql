CREATE TABLE `reservation` (
   reservation_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   flight_id int NOT NULL,
   ticket_id int NOT NULL,
   cust_ID int NOT NULL,
   total int NOT NULL,
   FOREIGN KEY (flight_id) REFERENCES flight(flight_id),
   FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
   FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
 );

CREATE TABLE `customer` (
  `cust_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(15) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `number` varchar(10) NOT NULL,
  `addr` varchar(100) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip` char(5) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`cust_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `flight` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `depart_time` varchar(45) NOT NULL,
  `arrive_time` varchar(45) NOT NULL,
  `date` int NOT NULL,
  `origin` varchar(3) NOT NULL,
  `dest` varchar(3) NOT NULL,
  `passengers` int DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `passenger` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `cust_id` int NOT NULL,
  PRIMARY KEY (`passenger_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `Customer` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `ticket_id` int NOT NULL,
  `cust_ID` int NOT NULL,
  `total` int NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `flight_id` (`flight_id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `cust_ID` (`cust_ID`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`cust_ID`) REFERENCES `customer` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `ticket` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `seat` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `passenger_ID` int NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `passenger_ID` (`passenger_ID`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`passenger_ID`) REFERENCES `passenger` (`passenger_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci